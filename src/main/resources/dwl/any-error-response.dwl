%dw 2.0
output application/json
---
{
	error: "An unexpected error has occurred. " ++ (error.description)
}