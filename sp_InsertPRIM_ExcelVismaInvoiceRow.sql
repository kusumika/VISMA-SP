ALTER PROCEDURE [dbo].[sp_InsertPRIM_ExcelVismaInvoiceRow]
	@ExcelVismaInvoice_FK int,
	@DescriptionText nvarchar(MAX),
	@DescriptionAmount nvarchar(100),
	@DescriptionOperator nvarchar(50),
	@DescriptionAmountPercentage nvarchar(100),
	@DescriptionAmountType nvarchar(100),
	@OrderedQuantity float,
	@DeliveredQuantity float,
	@Price decimal(18,2),
	@Sum decimal(18,2),
	@AccountNo nvarchar(100),
	@ProjectNo nvarchar(100)

AS
   
INSERT INTO [dbo].[tbl_PRIM_ExcelVismaInvoiceRow] (
	[ExcelVismaInvoice_FK],
	[DescriptionText],
	[DescriptionAmount],
	[DescriptionOperator],
	[DescriptionAmountPercentage],
	[DescriptionAmountType],
	[OrderedQuantity],
	[DeliveredQuantity],
	[Price],
	[Sum],
	[AccountNo],
	[ProjectNo]
) VALUES (
	@ExcelVismaInvoice_FK,
	@DescriptionText,
	@DescriptionAmount,
	@DescriptionOperator,
	@DescriptionAmountPercentage,
	@DescriptionAmountType,
	@OrderedQuantity,
	@DeliveredQuantity,
	@Price,
	@Sum,
	@AccountNo,
	@ProjectNo
)

--SELECT @@IDENTITY

--endregion