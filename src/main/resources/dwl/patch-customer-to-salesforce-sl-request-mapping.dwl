%dw 2.0
output application/json skipNullOn = "everywhere"
var salesforceData = {
	(payload.systemCustomerIds filter ((value, index) -> (value.system == "salesforce")))
}
---
{
	customerId: salesforceData.id,
	customerType: if ( salesforceData.customerType == "customer" ) "account"
        else if ( salesforceData.customerType == "lead" ) "lead"
        else "other",
	globalCustomerId: payload.globalCustomerId,
	contactId: salesforceData.contactId,
	individualId: payload.individualId,
	firstName: payload.firstName,
	lastName: payload.lastName,
	salutation: payload.salutation,
	communicationLanguage: vars.originalPayload.language,
	communicationPreference: vars.originalPayload.preferredChannel,
	email: payload.email,
	lastModifiedDate: payload.lastModifiedDate,
	subscriptions: vars.originalPayload.subscriptions map ( subscription , indexOfSubscription ) -> {
		subscription: subscription.subscription,
		enabled: subscription.enabled
	}
}