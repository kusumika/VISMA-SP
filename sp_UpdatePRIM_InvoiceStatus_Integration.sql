ALTER PROCEDURE [dbo].[sp_UpdatePRIM_InvoiceStatus_Integration]
@Invoice_ID int,
@Status int,
@UpdateColumn nvarchar(50)
AS

SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
if(@UpdateColumn='IsBookKeep')
begin
Update tbl_PRIM_Invoice
set IsBookKeep=@Status
where
Invoice_ID=@Invoice_ID
end
else
if(@UpdateColumn='IsSendToSPCS')
begin
Update tbl_PRIM_Invoice
set IsSendToSPCS=@Status
where
Invoice_ID=@Invoice_ID

		-------------------------------------------------------------------------
		-- Bonus Summary --Pedning=1, Created =2, Reversed = 3, Invoiced = 4
		-------------------------------------------------------------------------
		Update	tbl_PRIM_Bonuses_withCalculation_Summary Set BonusStatus=4 
where Bonuses_withCalculation_Summary_ID in (SELECT	OrderData_fk
											 FROM	tbl_PRIM_InvoiceRows INNER JOIN
													tbl_PRIM_OrderRows ON tbl_PRIM_InvoiceRows.InvoiceData_fk = tbl_PRIM_OrderRows.OrderRows_ID INNER JOIN
													tbl_PRIM_Order ON tbl_PRIM_OrderRows.Order_fk = tbl_PRIM_Order.Order_ID INNER JOIN
													tbl_PRIM_Bonuses_withCalculation_Summary ON 
													tbl_PRIM_OrderRows.OrderData_fk = tbl_PRIM_Bonuses_withCalculation_Summary.Bonuses_withCalculation_Summary_ID               
											 where	Invoice_fk = @Invoice_ID       
											)
											
end
--endregion