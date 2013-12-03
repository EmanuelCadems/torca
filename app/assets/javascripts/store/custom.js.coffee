$(document).ready ->
  $(".rate-name:contains('Retira en Sucursal')").prev("input").click ->
    $(this).closest('.shipment').find("select").show()

  $(".rate-name:contains('Recibir en Domicilio')").prev("input").click ->
    $(this).closest('.shipment').find("select").hide()
