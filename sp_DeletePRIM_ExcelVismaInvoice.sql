ALTER   PROCEDURE [dbo].[sp_DeletePRIM_ExcelVismaInvoice]
	@ExcelVismaInvoice_ID int
	
AS
	SET NOCOUNT ON;

	Delete From [dbo].[tbl_PRIM_ExcelVismaInvoiceRow] WHERE 
ExcelVismaInvoice_FK=@ExcelVismaInvoice_ID

	DELETE From  [dbo].[tbl_PRIM_ExcelVismaInvoice] WHERE 
ExcelVismaInvoice_ID=@ExcelVismaInvoice_ID
