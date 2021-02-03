%dw 2.0
output application/json
var concat = 'error.' ++ error.errorType.namespace ++ '.' ++ error.errorType.identifier
---
{
	error: (p(concat ++ '.message') default "") ++ (error.description default "")
}