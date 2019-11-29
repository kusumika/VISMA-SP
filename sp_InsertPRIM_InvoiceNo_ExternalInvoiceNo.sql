ALTER PROCEDURE [dbo].[sp_InsertPRIM_InvoiceNo_ExternalInvoiceNo]
	@ExternalInvoiceNo nvarchar(50),
	@Invoice_ID int
as
Update tbl_PRIM_Invoice Set ExternalInvoiceNo=@ExternalInvoiceNo where Invoice_ID=@Invoice_ID