%dw 2.0
output application/json skipNullOn = "everywhere"
var interestData = vars.originalPayload.interestData
var productData = vars.originalPayload.productData map ((item, index) -> item)
fun format(d: DateTime) = d as String {
	format: "yyyy-MM-dd'T'HH:mm:ss'Z'"
}
---
if ( vars.originalPayload.source.campaign == "boxspring-configurator" ) {
	"users": [{
		"identifiers": {
			"uuid": vars.originalPayload.globalCustomerId,
			"email": vars.originalPayload.email
		},
		"attributes": {
			"email_optin": if ( vars.originalPayload.subscriptions? ) "true" else "false",
			"language": vars.originalPayload.language ++ "_" ++ vars.originalPayload.addresses[0].countryCode,
			"country": vars.originalPayload.addresses[0].countryCode
		},
		"append": "true",
		"events": [{
			"event_name": "mailmy_" ++ vars.originalPayload.source.campaign,
			"timestamp": format(now() >> "CET"),
			"event_params": {
				"custom": {
					"source": vars.originalPayload.source.name,
					"campaign": vars.originalPayload.source.campaign,
					"config_url": (interestData filter ((item) -> item.key == "ConfigURL"))[0].value  default "",
					"sku_configured_product": (interestData filter ((item) -> item.key == "SKUConfiguredProduct"))[0].value default "",
					"discounted_price": (interestData filter ((item) -> item.key == "DiscountedPrice"))[0].value default "",
					"size": (interestData filter ((item) -> item.key == "Size"))[0].value default "",
					"size_charge": (interestData filter ((item) -> item.key == "SizeCharge"))[0].value default "",
					"base": (interestData filter ((item) -> item.key == "Base"))[0].value default "",
					"base_charge": (interestData filter ((item) -> item.key == "BaseCharge"))[0].value default "",
					"material_color": (interestData filter ((item) -> item.key == "MaterialColor"))[0].value default "",
					"material_color_charge": (interestData filter ((item) -> item.key == "MaterialColorCharge"))[0].value default "",
					"stitching": (interestData filter ((item) -> item.key == "Stitching"))[0].value default "",
					"stitching_charge": (interestData filter ((item) -> item.key == "StitchingCharge"))[0].value default "",
					"headboard": (interestData filter ((item) -> item.key == "HeadBoard"))[0].value default "",
					"headboard_charge": (interestData filter ((item) -> item.key == "HeadBoardCharge"))[0].value default "",
					"mattress_core_left": (interestData filter ((item) -> item.key == "MattressCoreLeft"))[0].value default "",
					"mattress_core_left_charge": (interestData filter ((item) -> item.key == "MattressCoreLeftCharge"))[0].value default "",
					"mattress_core_right": (interestData filter ((item) -> item.key == "MattressCoreRight"))[0].value default "",
					"mattress_core_right_charge": (interestData filter ((item) -> item.key == "MattressCoreRightCharge"))[0].value default "",
					"hardness_left": (interestData filter ((item) -> item.key == "HardnessLeft"))[0].value default "",
					"hardness_left_charge": (interestData filter ((item) -> item.key == "HardnessLeftCharge"))[0].value default "",
					"hardness_right": (interestData filter ((item) -> item.key == "HardnessRight"))[0].value default "",
					"hardness_right_charge": (interestData filter ((item) -> item.key == "HardnessRightCharge"))[0].value default "",
					"stepping": (interestData filter ((item) -> item.key == "Stepping"))[0].value default "",
					"stepping_charge": (interestData filter ((item) -> item.key == "SteppingCharge"))[0].value default "",
					"handles": (interestData filter ((item) -> item.key == "Handles"))[0].value default "",
					"handles_charge": (interestData filter ((item) -> item.key == "HandlesCharge"))[0].value default "",
					"top_mattress": (interestData filter ((item) -> item.key == "TopMattress"))[0].value default "",
					"top_mattress_charge": (interestData filter ((item) -> item.key == "TopMattressCharge"))[0].value default "",
					"feet": (interestData filter ((item) -> item.key == "Feet"))[0].value default "",
					"feet_charge": (interestData filter ((item) -> item.key == "FeetCharge"))[0].value default "",
					"footboard": (interestData filter ((item) -> item.key == "FootBoard"))[0].value default "",
					"footboard_charge": (interestData filter ((item) -> item.key == "FootBoardCharge"))[0].value default "",
					"price": (interestData filter ((item) -> item.key == "Price"))[0].value default "",
				}
			}
		}]
	}]
}
 
else 

{
	"users": [{
		"identifiers": {
			"uuid": vars.originalPayload.globalCustomerId,
			"email": vars.originalPayload.email
		},
		"attributes": {
			"email_optin": if ( vars.originalPayload.subscriptions? ) "true" else "false",
			"language": vars.originalPayload.language ++ "_" ++ vars.originalPayload.addresses[0].countryCode,
			"country": vars.originalPayload.addresses[0].countryCode
		},
		"append": "true",
		"events": [{
			"event_name": "mailmy_" ++ vars.originalPayload.source.campaign,
			"timestamp": format(now() >> "CET"),
			"event_params": {
				"custom": {
					"source": vars.originalPayload.source.name,
					"campaign": vars.originalPayload.source.campaign,
					"config_url": (interestData filter ((item) -> item.key == "ConfigURL"))[0].value  default null,
					"why_new": (interestData filter ((item) -> item.key == "WhyNew"))[0].value default null,
					"posture": (interestData filter ((item) -> item.key == "Posture"))[0].value default null,
					"length": (interestData filter ((item) -> item.key == "Length"))[0].value default null,
					"weight": (interestData filter ((item) -> item.key == "Weight"))[0].value default null,
					"temperature": (interestData filter ((item) -> item.key == "Temperature"))[0].value default null,
					"sweat": (interestData filter ((item) -> item.key == "Sweat"))[0].value default null,
					"mattress_length": (interestData filter ((item) -> item.key == "MattressLength"))[0].value default null,
					"mattress_width": (interestData filter ((item) -> item.key == "MattressWidth"))[0].value default null,
					"amount": (interestData filter ((item) -> item.key == "Amount"))[0].value default null,
					"budget": (interestData filter ((item) -> item.key == "Budget"))[0].value default null,
					"product_data1": [productData[0].productId, productData[0].quantity as String, productData[0].price as String, productData[0].discountedPrice as String, productData[0].matchingPercentage as String] default null,
					"product_data2": [productData[1].productId, productData[1].quantity as String, productData[1].price as String, productData[1].discountedPrice as String, productData[1].matchingPercentage as String] default null,
					"product_data3": [productData[2].productId, productData[2].quantity as String, productData[2].price as String, productData[2].discountedPrice as String, productData[2].matchingPercentage as String]  default null,
				}
			}
		}]
	}]
}