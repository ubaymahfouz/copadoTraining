%dw 2.0
output application/json
var mail = payload
var key = (payload.customerKey splitBy "-")[0]
var region = (payload.customerKey splitBy "-")[1]

---
{    
    "subject": (p("subject." ++ key ++ "." ++ region) 
   			 	default "")
  		 		replace "%%OrderNumber%%" with 
	         (mail.attributes filter (attr) -> attr.name == "OrderNumber")[0].value,
    "tos": [
    {
    "name": ((mail.attributes filter (attr) -> attr.name == "FirstName")[0].value) ++ " " ++ ((mail.attributes filter (attr) -> attr.name == "LastName")[0].value) ,  
    "email": mail.emailAddress
    }    
    ],
    "from": {
        "name": (mail.attributes filter (attr) -> attr.name == "DepartmentID")[0].value,
        "email": (mail.attributes filter (attr) -> attr.name == "DepEmailAddress")[0].value
    },
    "reply_to": {
        "name": (mail.attributes filter (attr) -> attr.name == "DepartmentID")[0].value,
        "email": (mail.attributes filter (attr) -> attr.name == "DepEmailAddress")[0].value
    },
    "template_id": (p("customerkey." ++ key ++ "-" ++ region) 
   			 	default "") as String,
    "dynamic_fields": (mail.attributes reduce ((item, accumulator) -> accumulator ++ { (item.name): item.value} ))
}  