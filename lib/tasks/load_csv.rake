#encoding=utf-8
require 'csv'
require "#{Rails.root}/lib/load_subcategory.rb"
require "#{Rails.root}/lib/ftp.rb"

desc "Load CSV"
namespace :csv do
  task :load => :environment do
    categories = Hash.new

    require "open-uri"

    categories_csv = Ftp.download("ftp://torcaweb@torcasistemas.no-ip.org/exportaciones/finales/Categorias.csv")

    if File.exist?("./tmp/#{categories_csv}")
      CSV.foreach("./tmp/#{categories_csv}", :quote_char => '"', :col_sep => ";") do |taxon|
        category = Spree::Taxonomy.create!(name: taxon[1]) unless taxon[1] =='DESCRIPCION'
        if category
          categories[taxon[0]] = category.taxons.find_by_name(category.name).id
        end
      end

      sub_categories1 = Subcategory.load("ftp://torcaweb@torcasistemas.no-ip.org/exportaciones/finales/Subcategorias_1.csv", categories)
      sub_categories2 = Subcategory.load("ftp://torcaweb@torcasistemas.no-ip.org/exportaciones/finales/Subcategorias_2.csv", sub_categories1)
      sub_categories3 = Subcategory.load("ftp://torcaweb@torcasistemas.no-ip.org/exportaciones/finales/Subcategorias_3.csv", sub_categories2)
      Subcategory.load("ftp://torcaweb@torcasistemas.no-ip.org/exportaciones/finales/Subcategorias_4.csv", sub_categories3)
    end

    products = Ftp.download("ftp://torcaweb@torcasistemas.no-ip.org/exportaciones/finales/product.csv")

    if File.exist?("./tmp/#{products}")
      CSV.foreach("./tmp/#{products}", :quote_char => '"',:col_sep => ";", :encoding => 'UTF-8') do |row|
        product = Spree::Product.create!(
          sku:            row[0],
          name:           row[1],
          available_on:   row[2].to_datetime,
          price:          row[3].to_d,
          shipping_category_id: Spree::ShippingCategory.first.id)

        # stock = product.stock_items.first
        # stock.update_attribute(:count_on_hand, row[4].to_i)
        # stock.save

        taxon = nil

        row[6,6].select{|x| x}.each_with_index do |sub_category, index|
          if index == 0
            taxon = Spree::Taxonomy.find_by_name(sub_category).taxons.find_by_name(sub_category)
          else
            taxon = taxon.children.find_by_name(sub_category)
          end
        end

        product.taxons << taxon

        row[12,3].select{|x| x}.each do |ftp|
          ftp["ftp://torcaweb"] = "ftp://"+ENV["USER_FTP"]+":"+ENV["PASSWORD_FTP"]
          image = Spree::Image.new
          begin
            image.attachment = open(ftp)
            product.images << image
          rescue Exception => e
            puts "Doesn't may open the ftp file because have ocurred the following errors:"
            puts e.message
          end
        end
      end
    end

    stock_items = Ftp.download("ftp://torcaweb@torcasistemas.no-ip.org/exportaciones/finales/STOCK_WEB.csv")

    if File.exist?("./tmp/#{stock_items}")
      CSV.foreach("./tmp/#{stock_items}", :quote_char => '"',:col_sep => ";", :encoding => 'UTF-8') do |row|
        stock_item_id = Spree::StockItem.joins(:stock_location, :variant).where("spree_stock_locations.erp_id = ? and spree_variants.sku = ?", row[2], row[1]).first.id

        if stock_item_id
          Spree::StockMovement.create!(:quantity => row[5].to_i, :stock_item_id => stock_item_id)
        end
      end
    end

  end
end
