%dw 2.0
output application/json skipNullOn = "everywhere"
var interestData = payload.interestData
var productData = payload.productData map ((item, index) -> item)
---
{
	"subject": p("subject." ++ payload.source.campaign ++ "." ++ payload.language) default "Here is your offer",
	"tos": [{
		"name": "Random Customer",
		"email": payload.email
	}],
	"from": {
		"name": "Swiss Sense",
		"email": "contact@email.swisssense.nl"
	},
	"reply_to": {
		"name": "Swiss Sense",
		"email": p("reply_email." ++ payload.addresses[0].countryCode) default "contact@swisssense.nl"
	},
	"template_id": "13407",
	"dynamic_fields": {
		"origin": payload.origin,
		"type": payload.source."type",
		"campaign": payload.source.campaign,
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
		"product_1_id": productData[0].productId,
		"product_1_quantity": productData[0].quantity as String,
		"product_1_price": productData[0].price as String,
		"product_1_discounted_price": productData[0].discountedPrice as String,
		"product_1_matching_percentage": productData[0].matchingPercentage as String,
		"product_2_id": productData[1].productId,
		"product_2_quantity": productData[1].quantity as String,
		"product_2_price": productData[1].price as String,
		"product_2_discounted_price": productData[1].discountedPrice as String,
		"product_2_matching_percentage": productData[1].matchingPercentage as String,
		"product_3_id": productData[2].productId,
		"product_3_quantity": productData[2].quantity as String,
		"product_3_price": productData[2].price as String,
		"product_3_discounted_price": productData[2].discountedPrice as String,
		"product_3_matching_percentage": productData[2].matchingPercentage as String
	}
}