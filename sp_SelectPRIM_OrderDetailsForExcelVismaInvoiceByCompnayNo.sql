ALTER  PROCEDURE [dbo].[sp_SelectPRIM_OrderDetailsForExcelVismaInvoiceByCompnayNo]
	@CompnayNo int
AS

SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ COMMITTED

SELECT    top 1   [Company_fk],[VAT],[Description],[Quantity],[Interest]
 ,PaymentTerms,PaymentMethods,DeliveryTerms,DeliveryMethods,AccountNo,CurrencyUnit,DeliveryDate,OurReference,YourReference,Note1,Note2,iName,
 iPostalAddress,iPostalAddress2,iZipCode,iCity,iCountry,iPhone,iPhone2,iFax,dName,dPostalAddress,dPostalAddress2,dZipCode,dCity,dCountry,dPhone,dPhone2,dFax,Unit,Discount,DiscountUnit,ShipingCharges,OtherCharges
                      
FROM         tbl_PRIM_Order INNER JOIN
                      tbl_PRIM_OrderRows ON tbl_PRIM_Order.Order_ID = tbl_PRIM_OrderRows.Order_fk
WHERE     (tbl_PRIM_OrderRows.[SrNo]='LB') and
 tbl_PRIM_Order.[CustomerNo]=@CompnayNo order by tbl_PRIM_Order.CreatedDate desc