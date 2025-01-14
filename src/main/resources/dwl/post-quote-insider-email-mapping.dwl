%dw 2.0
output application/json
var mail = vars.'quote.step2.payload'
---
{    
    "subject": if((mail.customer.language == "nl_nl") or (mail.customer.language == "be_be")) 
                p("subject.nl_nl.subject" ) ++ " (" ++ (mail.orderHeader.id replace /^quote-/ with "" ) ++ ")" default ""
              else
                if((mail.customer.language == "de_de") or (mail.customer.language == "at_at")) 
                p("subject.de_de.subject" ) ++ " (" ++ (mail.orderHeader.id replace /^quote-/ with "")  ++ ")" default ""
              else  
                p("subject.nl_nl.subject" ) ++ " (" ++ (mail.orderHeader.id replace /^quote-/ with "")  ++ ")"  default "",
    "tos":
    [
        {
          "name": mail.customer.firstName ++ " " ++ mail.customer.lastName,
          "email": mail.customer.email default ""
        }
    ],
    "from": 
        {
            "name": "Swiss Sense",
            "email": p("from_email." ++ mail.orderHeader.salesOffice.countryCode)
        },
    "reply_to":
        {
            "name": mail.orderHeader.salesOffice.name,
            "email": mail.orderHeader.salesOffice.storeEmail
        },
     "template_id": if(mail.customer.language == "nl_nl")     p("subject.nl_nl.template_id" )  default ""
                        else 
                             if(mail.customer.language == "be_be") p("subject.be_be.template_id" )  default ""
                        else     
                             if(mail.customer.language == "de_de") p("subject.de_de.template_id" )  default "" 
                        else  
                             if(mail.customer.language == "at_at") p("subject.at_at.template_id" )  default "" 
                        else ""     ,
     "dynamic_fields": 
        {
        "lang_country": mail.customer.language,
        "quote_id": mail.orderHeader.id,
        "quote_url": mail.pdfPermanentLink,
        "quote_closing_date": mail.orderHeader.validTill,
        "customer_first_name": mail.customer.firstName,
        "customer_last_name": mail.customer.lastName,
        "CustomerFullName": mail.customer.firstName ++ " " ++ mail.customer.lastName,
        "store_email": mail.orderHeader.salesOffice.storeEmail,
        "store_name": mail.orderHeader.salesOffice.name,
        "store_phone": mail.orderHeader.salesOffice.phone,
        "store_salesagent": mail.salesRep.partnFirstName
     }  
}  
