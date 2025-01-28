%dw 2.0
output application/json skipNullOn = "everywhere"
var interestData = vars.originalPayload.interestData
var productData = vars.originalPayload.productData map ((item, index) -> item)
---
if ( vars.originalPayload.source.campaign == "boxspring-configurator" ) {
	"users": [{
		"identifiers": {
			"uuid": vars.originalPayload.globalCustomerId,
			"email": vars.originalPayload.email
		},
		"attributes": {
			"email_opt_in": if ( vars.originalPayload.subscriptions? ) "true" else "false",
			"language": vars.originalPayload.language,
			"country": vars.originalPayload.addresses[0].countryCode
		},
		"events": [{
			"event_name": "user_interest_recorded_for_" ++ vars.originalPayload.source.campaign,
			"timestamp": now() as DateTime as String {
				format: "yyyy-HH-mm'T'HH:mm:ss'Z'"
			},
			"event_params": {
				"custom": {
					"source": vars.originalPayload.source.name,
					"campaign": vars.originalPayload.source.campaign,
					"config_url": (interestData filter ((item) -> item.key == "ConfigURL"))[0].value  default null,
					"sku_configured_product": (interestData filter ((item) -> item.key == "SKUConfiguredProduct"))[0].value default null,
					"price": (interestData filter ((item) -> item.key == "Price"))[0].value default null,
					"discounted_price": (interestData filter ((item) -> item.key == "DiscountedPrice"))[0].value default null,
					"size": (interestData filter ((item) -> item.key == "Size"))[0].value default null,
					"size_charge": (interestData filter ((item) -> item.key == "SizeCharge"))[0].value default null,
					"base": (interestData filter ((item) -> item.key == "Base"))[0].value default null,
					"base_charge": (interestData filter ((item) -> item.key == "BaseCharge"))[0].value default null,
					"material_color": (interestData filter ((item) -> item.key == "MaterialColor"))[0].value default null,
					"material_color_charge": (interestData filter ((item) -> item.key == "MaterialColorCharge"))[0].value default null,
					"mattress_core_left": (interestData filter ((item) -> item.key == "MattressCoreLeft"))[0].value default null,
					"mattress_core_left_charge": (interestData filter ((item) -> item.key == "MattressCoreLeftCharge"))[0].value default null,
					"hardness_left": (interestData filter ((item) -> item.key == "HardnessLeft"))[0].value default null,
					"hardness_left_charge": (interestData filter ((item) -> item.key == "HardnessLeftCharge"))[0].value default null,
					"mattress_core_right": (interestData filter ((item) -> item.key == "MattressCoreRight"))[0].value default null,
					"mattress_core_right_charge": (interestData filter ((item) -> item.key == "MattressCoreRightCharge"))[0].value default null,
					"hardness_right": (interestData filter ((item) -> item.key == "HardnessRight"))[0].value default null,
					"hardness_right_charge": (interestData filter ((item) -> item.key == "HardnessRightCharge"))[0].value default null,
					"top_mattress": (interestData filter ((item) -> item.key == "TopMattress"))[0].value default null,
					"top_mattress_charge": (interestData filter ((item) -> item.key == "TopMattressCharge"))[0].value default null,
					"feet": (interestData filter ((item) -> item.key == "Feet"))[0].value default null,
					"feet_charge": (interestData filter ((item) -> item.key == "FeetCharge"))[0].value default null,
					"footboard": (interestData filter ((item) -> item.key == "FootBoard"))[0].value default null,
					"footboard_charge": (interestData filter ((item) -> item.key == "FootBoardCharge"))[0].value default null,
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
			"email_opt_in": if ( vars.originalPayload.subscriptions? ) "true" else "false",
			"language": vars.originalPayload.language,
			"country": vars.originalPayload.addresses[0].countryCode
		},
		"events": [{
			"event_name": "user_interest_recorded_for_" ++ vars.originalPayload.source.campaign,
			"timestamp": now() as DateTime as String {
				format: "yyyy-HH-mm'T'HH:mm:ss'Z'"
			},
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