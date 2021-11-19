%dw 2.0
output application/json skipNullOn = "everywhere"
var telephoneTypes = ["home", "office"]
---
{
	customerType: "lead",
	customerSourceType: vars.originalPayload.source."type",
	legalEntity: {
		contact: [{
                mobilePhone: (vars.originalPayload.phoneNumbers filter $."type" == "mobile").number[0],
                fixedPhone: (vars.originalPayload.phoneNumbers filter (telephoneTypes contains $."type")).number[0],
                email: vars.originalPayload.email,
            }],
		address: vars.originalPayload.addresses map ( address , indexOfAddress ) -> {
			streetName: address.street,
			houseNumber: (address.houseNumber as String) default null,
			houseNumberSuffix: address.houseNumberSuffix,
			postalCode: address.postalCode,
			city: address.city,
			country: {
				code: address.countryCode
			}
		},
		lastName: vars.originalPayload.lastName,
		firstName: vars.originalPayload.firstName,
		salutation: vars.originalPayload.salutation
	},
	preferences: {
		communication: {
			subscriptions: vars.originalPayload.subscriptions map ( subscription , indexOfSubscription ) -> {
				subscription: subscription.subscription,
				enabled: subscription.enabled
			},
			preferredChannel: vars.originalPayload.preferredChannel,
			language: vars.originalPayload.language
		}
	}
}