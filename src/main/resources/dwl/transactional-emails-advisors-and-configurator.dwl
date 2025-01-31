%dw 2.0
output application/json skipNullOn = "everywhere"
var interestData = vars.originalPayload.interestData
var productData = vars.originalPayload.productData map ((item, index) -> item)
---
if ( vars.originalPayload.source.campaign == "boxspring-configurator" ) {
	"subject": p("subject." ++ vars.originalPayload.source.campaign ++ "." ++ vars.originalPayload.language) default "Here is your offer",
	"tos": [{
		"email": vars.originalPayload.email
	}],
	"from": {
		"name": "Swiss Sense",
		"email": p("from_email.NL")
	},
	"reply_to": {
		"name": "Swiss Sense",
		"email": p("reply_email." ++ vars.originalPayload.addresses[0].countryCode) default "contact@swisssense.nl"
	},
	"template_id": p("template_id." ++ vars.originalPayload.source.campaign ++ "." ++ vars.originalPayload.addresses[0].countryCode),
	"dynamic_fields": {
		"type": vars.originalPayload.source."type",
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
else
{
	"subject": p("subject." ++ vars.originalPayload.source.campaign ++ "." ++ vars.originalPayload.language) default "Here is your offer",
	"tos": [{
		"email": vars.originalPayload.email
	}],
	"from": {
		"name": "Swiss Sense",
		"email": p("from_email.NL")
	},
	"reply_to": {
		"name": "Swiss Sense",
		"email": p("reply_email." ++ vars.originalPayload.addresses[0].countryCode) default "contact@swisssense.nl"
	},
	"template_id": p("template_id." ++ vars.originalPayload.source.campaign ++ "." ++ vars.originalPayload.addresses[0].countryCode),
	"dynamic_fields": {
		"type": vars.originalPayload.source."type",
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
		"product_1_id": productData[0].productId default null,
		"product_1_quantity": productData[0].quantity as String default null,
		"product_1_price": productData[0].price as String default null,
		"product_1_discounted_price": productData[0].discountedPrice as String default null,
		"product_1_matching_percentage": productData[0].matchingPercentage as String default null,
		"product_2_id": productData[1].productId default null,
		"product_2_quantity": productData[1].quantity as String default null,
		"product_2_price": productData[1].price as String default null,
		"product_2_discounted_price": productData[1].discountedPrice as String default null,
		"product_2_matching_percentage": productData[1].matchingPercentage as String default null,
		"product_3_id": productData[2].productId default null,
		"product_3_quantity": productData[2].quantity as String default null,
		"product_3_price": productData[2].price as String default null,
		"product_3_discounted_price": productData[2].discountedPrice as String default null,
		"product_3_matching_percentage": productData[2].matchingPercentage as String default null
	}
}