%dw 2.0
output application/json skipNullOn = "everywhere"
---
{
	Customer: {
		customerType: "lead",
		legalEntity: {
			(contact: ([{
				email: vars.originalPayload.email,
                (vars.originalPayload.phoneNumbers map ( phoneNumber , indexOfPhoneNumber ) -> {
                    (mobilePhone: phoneNumber.number) if (phoneNumber."type" == "mobile"),
                    (fixedPhone: phoneNumber.number) if (phoneNumber."type" == "home")
			    })
			}])) if (vars.originalPayload.email != null or vars.originalPayload.phoneNumbers != null),
			address: vars.originalPayload.addresses map ( address , indexOfAddress ) -> {
				streetName: address.street,
				houseNumber: address.houseNumber,
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
}