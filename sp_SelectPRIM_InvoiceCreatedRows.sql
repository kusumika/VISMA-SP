ALTER PROCEDURE [dbo].[sp_SelectPRIM_InvoiceCreatedRows]
@Invoice_ID int

as
SELECT DISTINCT 
                      tbl_PRIM_InvoiceRows.OrderedQuantity, tbl_PRIM_InvoiceRows.DeliveredQuantity, tbl_PRIM_InvoiceRows.Unit, REPLACE(CAST(ROUND(tbl_PRIM_InvoiceRows.price,0) AS DECIMAL(18,2)),'.',',') AS Price, 
                      tbl_PRIM_InvoiceRows.Discount, tbl_PRIM_InvoiceRows.DiscountUnit, tbl_PRIM_InvoiceRows.VAT, tbl_PRIM_InvoiceRows.[Description], 
                      tbl_PRIM_InvoiceRows.LineNote, 
                      tbl_PRIM_InvoiceRows.InvoiceData_fk, tbl_PRIM_InvoiceRows.SrNo, tbl_PRIM_InvoiceRows.AccountNo, tbl_PRIM_InvoiceRows.CurrencyUnit,
                       tbl_PRIM_Invoice.InvoiceType
                       
                       ,VATAmount= case 
when tbl_PRIM_Invoice.InvoiceType=1
then 
--tbl_PRIM_InvoiceRows.DeliveredQuantity * tbl_PRIM_InvoiceRows.Price * tbl_PRIM_InvoiceRows.VAT / 100
REPLACE(CAST(ROUND(tbl_PRIM_InvoiceRows.DeliveredQuantity * tbl_PRIM_InvoiceRows.Price * tbl_PRIM_InvoiceRows.VAT / 100,0) AS DECIMAL(18,2)),'.',',')
when tbl_PRIM_Invoice.InvoiceType=2
then 
---1*(tbl_PRIM_InvoiceRows.DeliveredQuantity * tbl_PRIM_InvoiceRows.Price * tbl_PRIM_InvoiceRows.VAT / 100)
REPLACE(CAST(ROUND(-1*(tbl_PRIM_InvoiceRows.DeliveredQuantity * tbl_PRIM_InvoiceRows.Price * tbl_PRIM_InvoiceRows.VAT / 100),0) AS DECIMAL(18,2)),'.',',')

 end
,WithOutVAT= case 
when tbl_PRIM_Invoice.InvoiceType=1
then 
--tbl_PRIM_InvoiceRows.DeliveredQuantity * tbl_PRIM_InvoiceRows.Price 
REPLACE(CAST(ROUND(tbl_PRIM_InvoiceRows.DeliveredQuantity * tbl_PRIM_InvoiceRows.Price,0) AS DECIMAL(18,2)),'.',',')
when tbl_PRIM_Invoice.InvoiceType=2
then 
---1*(tbl_PRIM_InvoiceRows.DeliveredQuantity * tbl_PRIM_InvoiceRows.Price  )
REPLACE(CAST(ROUND(-1*(tbl_PRIM_InvoiceRows.DeliveredQuantity * tbl_PRIM_InvoiceRows.Price),0) AS DECIMAL(18,2)),'.',',')
end

,WithVAT= case 
when tbl_PRIM_Invoice.InvoiceType=1
then 


                      --tbl_PRIM_InvoiceRows.DeliveredQuantity * tbl_PRIM_InvoiceRows.Price * tbl_PRIM_InvoiceRows.VAT / 100 + tbl_PRIM_InvoiceRows.DeliveredQuantity * tbl_PRIM_InvoiceRows.Price
REPLACE(CAST(ROUND(tbl_PRIM_InvoiceRows.DeliveredQuantity * tbl_PRIM_InvoiceRows.Price * tbl_PRIM_InvoiceRows.VAT / 100 + tbl_PRIM_InvoiceRows.DeliveredQuantity * tbl_PRIM_InvoiceRows.Price,0) AS DECIMAL(18,2)),'.',',')                       
                       
when tbl_PRIM_Invoice.InvoiceType=2
then 

                      ---1*(tbl_PRIM_InvoiceRows.DeliveredQuantity * tbl_PRIM_InvoiceRows.Price * tbl_PRIM_InvoiceRows.VAT / 100 + tbl_PRIM_InvoiceRows.DeliveredQuantity * tbl_PRIM_InvoiceRows.Price)
REPLACE(CAST(ROUND(-1*(tbl_PRIM_InvoiceRows.DeliveredQuantity * tbl_PRIM_InvoiceRows.Price * tbl_PRIM_InvoiceRows.VAT / 100 + tbl_PRIM_InvoiceRows.DeliveredQuantity * tbl_PRIM_InvoiceRows.Price),0) AS DECIMAL(18,2)),'.',',')                                              
 end
                       
FROM         tbl_PRIM_InvoiceRows INNER JOIN
                      tbl_PRIM_Invoice ON tbl_PRIM_InvoiceRows.Invoice_fk = tbl_PRIM_Invoice.Invoice_ID
WHERE     (tbl_PRIM_InvoiceRows.Invoice_fk = @Invoice_ID)
ORDER BY tbl_PRIM_InvoiceRows.[Description]
--and tbl_PRIM_Invoice.InvoiceType=1
              --Union              
                            
--                SELECT DISTINCT 
--                      tbl_PRIM_InvoiceRows.OrderedQuantity, tbl_PRIM_InvoiceRows.DeliveredQuantity As DeliveredQuantity,

--                     tbl_PRIM_InvoiceRows.Unit, tbl_PRIM_InvoiceRows.Price, 
--                      tbl_PRIM_InvoiceRows.Discount, tbl_PRIM_InvoiceRows.DiscountUnit, tbl_PRIM_InvoiceRows.VAT, tbl_PRIM_InvoiceRows.[Description], 
--                      tbl_PRIM_InvoiceRows.InvoiceData_fk, tbl_PRIM_InvoiceRows.SrNo,tbl_PRIM_InvoiceRows.AccountNo, tbl_PRIM_Invoice.*,
--                       (((tbl_PRIM_InvoiceRows.DeliveredQuantity *
--                      tbl_PRIM_InvoiceRows.Price)* tbl_PRIM_InvoiceRows.VAT)/100) as VATAmount,
--                         ((tbl_PRIM_InvoiceRows.DeliveredQuantity *
--                      tbl_PRIM_InvoiceRows.Price))+(tbl_PRIM_Invoice.InvoiceFee+tbl_PRIM_Invoice.ShipingCharges+tbl_PRIM_Invoice.OtherCharges)as WithOutVAT,
                      
--                         (((tbl_PRIM_InvoiceRows.DeliveredQuantity *
--                      tbl_PRIM_InvoiceRows.Price)*tbl_PRIM_InvoiceRows.VAT)/100) + (tbl_PRIM_InvoiceRows.DeliveredQuantity *
--                      tbl_PRIM_InvoiceRows.Price)as WithVAT
                      
--FROM         tbl_PRIM_Invoice INNER JOIN
--                      tbl_PRIM_InvoiceRows ON tbl_PRIM_Invoice.Invoice_ID = tbl_PRIM_InvoiceRows.Invoice_fk
--WHERE     (tbl_PRIM_Invoice.Invoice_ID = @Invoice_ID) and tbl_PRIM_Invoice.InvoiceType=2