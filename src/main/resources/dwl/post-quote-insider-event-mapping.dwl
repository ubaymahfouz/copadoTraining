%dw 2.0
output application/json
var event = vars.quote.step2.payload
---
{    
    users: [
        {
            "identifiers":
             {
                "uuid": vars.customerRefSfIdResponse.targetCustomerId,
                "email": event.customer.email default "",
                "phone_number": event.customer.phone  default ""
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
