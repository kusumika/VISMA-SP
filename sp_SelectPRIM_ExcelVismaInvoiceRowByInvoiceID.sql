ALTER procedure [dbo].[sp_SelectPRIM_ExcelVismaInvoiceRowByInvoiceID]
@InvoiceID int

as
SELECT DISTINCT 
                     

     [ExcelVismaInvoiceRow_ID],
	 ISNULL([DescriptionText], '') + ' ' + ISNULL([DescriptionAmount],'')  + ' ' + ISNULL([DescriptionOperator],'')  + ' ' + ISNULL([DescriptionAmountPercentage],'')  + ' ' + ISNULL([DescriptionAmountType],'') as [Description]
      ,[ExcelVismaInvoice_FK]
      ,[DescriptionText]
      ,[DescriptionAmount]
      ,[DescriptionOperator]
      ,[DescriptionAmountPercentage]
      ,[DescriptionAmountType]
      ,[OrderedQuantity]
      ,[DeliveredQuantity]
      ,[Price]
      ,[Sum]
      ,[AccountNo],
      [ProjectNo]
  FROM [dbo].[tbl_PRIM_ExcelVismaInvoiceRow] where [ExcelVismaInvoice_FK]=@InvoiceID order by ExcelVismaInvoiceRow_ID  

