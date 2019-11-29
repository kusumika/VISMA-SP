ALTER procedure [dbo].[sp_SelectPRIM_ExcelVismaInvoiceByInvoiceID]
@InvoiceID int

as
SELECT DISTINCT 
                     

    [ExcelVismaInvoice_ID]
      ,[ExcelVismaCustomerNo]
      ,[ExcelVismaInvoiceType]
      ,[ExcelVismaExternalInvoiceNo]
      ,[ExcelVismaInvoiceYear]
      ,[ExcelCustomerName]
      ,[ExternalInvoiceDate]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[ChangedBy]
      ,[ChangedDate]
      ,[isSendToSPCS],
      [OurReference]
  FROM [dbo].[tbl_PRIM_ExcelVismaInvoice]
  where [ExcelVismaInvoice_ID]=@InvoiceID 