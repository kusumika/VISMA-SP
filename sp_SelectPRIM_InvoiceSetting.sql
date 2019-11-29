ALTER PROCEDURE [dbo].[sp_SelectPRIM_InvoiceSetting]
	@Company_ID int
AS

SET NOCOUNT ON

Select * from tbl_PRIM_InvoiceSetting
where  Company_ID=@Company_ID