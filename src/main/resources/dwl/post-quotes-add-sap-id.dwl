%dw 2.0
output application/json
---
payload - 'customer' ++ {
    "customer": ((payload.customer default {}) - "id" ++ {
        "id": vars.customersPostResponse.customerId
    })
}