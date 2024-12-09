output application/json
---
{
    errors: [
        {
            correlationId: correlationId default "",
            timestamp: now(),
            statusCode: "500",
            error: "Internal Server Error",
            detail: error.detailedDescription default ""
        }
    ]
}