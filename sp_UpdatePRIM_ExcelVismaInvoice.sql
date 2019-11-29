ALTER  PROCEDURE [dbo].[sp_UpdatePRIM_ExcelVismaInvoice]
	@ExcelVismaInvoice_ID int,
	@ExcelVismaExternalInvoiceNo varchar(50),
	@ExternalInvoiceDate date,
	@ChangedBy nvarchar(50),
	@ChangedDate smalldatetime,
	@isSendToSPCS bit
AS
	SET NOCOUNT ON;
UPDATE [dbo].[tbl_PRIM_ExcelVismaInvoice] 
SET
ExcelVismaExternalInvoiceNo=@ExcelVismaExternalInvoiceNo,
ExternalInvoiceDate=@ExternalInvoiceDate,
ChangedBy=@ChangedBy,
ChangedDate=@ChangedDate,
isSendToSPCS=@isSendToSPCS
WHERE 
ExcelVismaInvoice_ID=@ExcelVismaInvoice_ID