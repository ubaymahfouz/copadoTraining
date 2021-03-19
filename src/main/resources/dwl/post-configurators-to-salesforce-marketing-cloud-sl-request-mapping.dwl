%dw 2.0
output application/json skipNullOn = "everywhere"
---
{
	origin: vars.origin,
	source: {
		"type": vars.originalPayload.source."type",
		name: vars.originalPayload.source.name,
		campaign: vars.originalPayload.source.campaign
	},
	email: vars.originalPayload.email,
	salesforceContactKey: if (vars.lastModifiedGetCustomersResponse != null) {(vars.lastModifiedGetCustomersResponse.systemCustomerIds filter ((item, index) -> item.system == "salesforce"))}.id
	else {(vars.postCustomersResponse.systemCustomerIds filter ((item, index) -> item.system == "salesforce"))}.id,
	globalCustomerId: if (vars.lastModifiedGetCustomersResponse != null) vars.lastModifiedGetCustomersResponse.globalCustomerId else vars.postCustomersResponse.globalCustomerId,
	firstName: vars.originalPayload.firstName,
	lastName: vars.originalPayload.lastName,
	interestData: vars.originalPayload.interestData map ( interestDatum , indexOfInterestDatum ) -> {
		key: interestDatum.key,
		value: interestDatum.value
	},
	productData: vars.originalPayload.productData map ( productDatum , indexOfProductDatum ) -> {
		productId: productDatum.productId,
		quantity: productDatum.quantity,
		price: productDatum.price,
		discountedPrice: productDatum.discountedPrice,
		matchingPercentage: productDatum.matchingPercentage
	}
}