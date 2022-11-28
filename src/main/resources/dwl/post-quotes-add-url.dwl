%dw 2.0
output application/json
---
payload ++ {"pdfPermanentLink": vars.documentResponse.permanentLink}