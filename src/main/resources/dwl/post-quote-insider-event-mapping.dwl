%dw 2.0
output application/json
var event = vars.'quote.step2.payload'
---
{    
    users: [
        {
            "identifiers":
             {
                "uuid": vars.customerRefSfIdResponse.targetCustomerId,
                "email": event.customer.email default "",
                "phone_number": if (event.customer.phone startsWith "+") 
                                     event.customer.phone 
                             else 
                                if (event.customer.countryCode == "NL") 
                                    "+31" ++ (event.customer.phone replace /^(0+)/ with "") 
                                else if (event.customer.countryCode == "DE") 
                                    "+49" ++ (event.customer.phone replace /^(0+)/ with "") 
                                else 
                                    "+" ++ (event.customer.phone replace /^(0+)/ with "")
             },
            "events": 
             [
                {
                    "event_name": "quote_created",
                    "timestamp": now(),
                    "event_params": {
                        "url": event.pdfPermanentLink,
                        "custom": {
                            "sales_office": event.orderHeader.salesOffice.name,
                            "quote_id": event.orderHeader.id,
                            "status": "Proposal",
                            "date": event.orderHeader.date,
                            "valid_till": event.orderHeader.validTill,
                            "grand_total": event.salesTotals.grandTotal.value
                        }
                    }
                }
            ]
        }
    ]
}  
