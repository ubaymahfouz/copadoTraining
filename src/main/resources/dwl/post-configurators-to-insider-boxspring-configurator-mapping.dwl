%dw 2.0
output application/json skipNullOn = "everywhere"
var interestData = payload.interestData
---
{
	"users": [{
		"identifiers": {
			"uuid": payload.globalCustomerId,
			"email": payload.email
		},
		"attributes": {
			"email_opt_in": "true",
			"language": payload.language,
			"country": payload.addresses[0].countryCode
		},
		"events": [{
			"event_name": "user_interest_recorded_for_" ++ payload.source.campaign,
			"timestamp": now() as DateTime as String {
				format: "yyyy-HH-mm'T'HH:mm:ss'Z'"
			},
			"event_params": {
				"custom": {
					"origin": payload.origin,
					"type": payload.source.name,
					"campaign": payload.source.campaign,
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