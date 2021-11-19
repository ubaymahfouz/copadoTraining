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
	individualId: salesforceData.individualId,
	firstName: payload.legalEntity.firstName,
	lastName: payload.legalEntity.lastName,
	salutation: payload.legalEntity.salutation,
	communicationLanguage: upper(vars.originalPayload.language),
	communicationPreference: vars.originalPayload.preferredChannel,
	email: payload.legalEntity.contact.email reduce ($$ ++ $) default null,
	lastModifiedDate: payload.lastModifiedDate,
	subscriptions: vars.originalPayload.subscriptions map ( subscription , indexOfSubscription ) -> {
		subscription: subscription.subscription,
		enabled: subscription.enabled
	}
}