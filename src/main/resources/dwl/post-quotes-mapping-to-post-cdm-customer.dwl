%dw 2.0
output application/json
---
{
	legalEntity: {
		firstName: payload.customer.firstName default "",
		lastName: payload.customer.lastName default "",
		salutation: payload.customer.title default p('legalentity.salutation.default'),
		address: [{
			country: {
				code: payload.customer.countryCode default ""
			},
			city: payload.customer.city default "",
			houseNumberSuffix: payload.customer.houseNumberSuffix default "",
			postalCode: payload.customer.postalCode default "",
			houseNumber: payload.customer.houseNumber default "",
			streetName: payload.customer.street default ""
		}],
		contact: [{
			fixedPhone: payload.customer.phone default "",
			mobilePhone: payload.customer.mobile default "",
			email: payload.customer.email default ""
		}]
	},
	preferences: {
		communication: {
			language: p('communication.language.' ++ (payload.customer.language default "nl_nl"))
		}
	},
	salesoffice: payload.orderHeader.salesOffice.id default "",
	vatnum: payload.customer.vatNumber default ""
}