%dw 2.0
output application/json skipNullOn = "everywhere"
var filterSF = {(vars.lastModifiedGetCustomersResponse.systemCustomerIds filter ((item, index) -> item.system == "salesforce"))}
---
{
	origin: vars.origin,
	source: {
		"type": vars.originalPayload.source."type",
		name: vars.originalPayload.source.name,
		campaign: vars.originalPayload.source.campaign
	},
	email: vars.originalPayload.email,
	salesforceContactKey: if (vars.lastModifiedGetCustomersResponse != null and filterSF.customerType == "lead") filterSF.id
	else if (vars.lastModifiedGetCustomersResponse != null and filterSF.customerType == "customer") filterSF.contactId
	else vars.customerRefResponse.salesforceCustomerId,
	globalCustomerId: if (vars.lastModifiedGetCustomersResponse != null) vars.lastModifiedGetCustomersResponse.globalCustomerId else vars.postCustomersResponse.globalCustomerId,
	firstName: vars.originalPayload.firstName,
	lastName: vars.originalPayload.lastName,
	language: vars.originalPayload.language,
	interestData: vars.originalPayload.interestData map ( interestData , indexOfInterestData ) -> {
		key: interestData.key,
		value: interestData.value
	},
	productData: vars.originalPayload.productData map ( productData , indexOfProductData ) -> {
		productId: productData.productId,
		quantity: productData.quantity,
		price: productData.price,
		discountedPrice: productData.discountedPrice,
		matchingPercentage: productData.matchingPercentage
	}
}