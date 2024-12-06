%dw 2.0
output application/json

---
{
    errors: [
        {
            correlationId: correlationId default "",
            timestamp: now() default "",
            statusCode: (p('error.' ++ error.errorType.namespace ++ '.' ++ error.errorType.identifier ++ '.status')) default "",
            error: (p('error.' ++ error.errorType.namespace ++ '.' ++ error.errorType.identifier ++ '.message')) default "",
            //details : error.exception.errorMessage.typedValue,
            detail : error.errorMessage.payload default ""
            
        }
    ]
}