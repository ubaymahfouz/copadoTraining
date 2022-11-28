%dw 2.0
output application/json
---
payload - 'customer' ++ {
    "customer": (payload.customer - "id" ++ {
        "id": vars.customerRefResponse.targetCustomerId
    })
}