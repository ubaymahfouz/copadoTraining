%dw 2.0
output application/json
---
{
	quoteId: payload.orderHeader.id,
	date: payload.orderHeader.date,
	personAccountId: vars.customerRefSfIdResponse.targetCustomerId,
	storeName: payload.orderHeader.salesOffice.id as String,
	salesRepName: payload.salesRep.partnName,
	urlQuote: payload.pdfPermanentLink,
	quoteValue: payload.salesTotals.grandTotal.value
}