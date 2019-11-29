ALTER PROCEDURE [dbo].[sp_InsertPRIM_ExcelVismaInvoice]
	@ExcelVismaCustomerNo nvarchar(50),
	@ExcelVismaInvoiceType int,
	@ExcelVismaExternalInvoiceNo varchar(50),
	@ExcelVismaInvoiceYear varchar(15),
	@ExcelCustomerName nvarchar(50),
	@ExternalInvoiceDate date,
	@CreatedBy nvarchar(50),
	@CreatedDate smalldatetime,
	@ChangedBy nvarchar(50),
	@ChangedDate smalldatetime,
	@isSendToSPCS bit,
	@OurReference nvarchar(50),
	@ExcelVismaCompanyName nvarchar(50)
AS
	   
INSERT INTO [dbo].[tbl_PRIM_ExcelVismaInvoice] (	
	[ExcelVismaCustomerNo],
	[ExcelVismaInvoiceType],
	[ExcelVismaExternalInvoiceNo],
	[ExcelVismaInvoiceYear],
	[ExcelCustomerName],
	[ExternalInvoiceDate],
	[CreatedBy],
	[CreatedDate],
	[ChangedBy],
	[ChangedDate],
	[isSendToSPCS],
	[OurReference],
	[ExcelVismaCompanyName]
) VALUES (
	
	@ExcelVismaCustomerNo,
	@ExcelVismaInvoiceType,
	@ExcelVismaExternalInvoiceNo,
	@ExcelVismaInvoiceYear,
	@ExcelCustomerName,
	@ExternalInvoiceDate,
	@CreatedBy,
	@CreatedDate,
	@ChangedBy,
	@ChangedDate,
	@isSendToSPCS,
	@OurReference,
	@ExcelVismaCompanyName
)

SELECT @@IDENTITY

--endregion
