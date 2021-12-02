%dw 2.0
output application/json skipNullOn = "everywhere"
var telephoneTypes = ["home", "office"]

// function to delete all empty objects and arrays from the input
fun treeFilter(value: Any, predicate: (value:Any) -> Boolean) =
    value  match {
            case object is Object ->  do {
               object mapObject ((value, key, index) -> 
                    (key): treeFilter(value, predicate)
                )
                filterObject ((value, key, index) -> predicate(value))
            }
            case array is Array -> do {
                    array map ((item, index) -> treeFilter(item, predicate))
                                         filter ((item, index) -> predicate(item))                 
            }
            else -> $
    }
---
({
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
})

// output from mapping above as input for treeFilter function
treeFilter ((value) -> 
    value match {
        case v is Array| Object | Null -> !isEmpty(v)
        else -> true
    }
)