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
	         (mail.attributes filter (attr) -> attr.name == "OrderNumber")[0].value default "",
    "tos": [
    {
    "name": ((mail.attributes filter (attr) -> attr.name == "FirstName")[0].value) default "" ++ " " ++ ((mail.attributes filter (attr) -> attr.name == "LastName")[0].value)default "" ,  
    "email": mail.emailAddress default ""
    }    
    ],
    "from": {
        "name": (mail.attributes filter (attr) -> attr.name == "DepartmentID")[0].value default "",
        "email": p("from_email." ++ region)
    default ""},
    "reply_to": {
        "name": (mail.attributes filter (attr) -> attr.name == "DepartmentID")[0].value default "",
        "email": (mail.attributes filter (attr) -> attr.name == "DepEmailAddress")[0].value default ""
    },
    "template_id": (p("customerkey." ++ key ++ "-" ++ region) 
   			 	default "") as String,
    "dynamic_fields": (mail.attributes reduce ((item, accumulator= {}) -> accumulator ++ { (item.name): item.value} ))
}  