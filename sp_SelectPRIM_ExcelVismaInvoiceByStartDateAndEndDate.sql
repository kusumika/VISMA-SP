ALTER procedure [dbo].[sp_SelectPRIM_ExcelVismaInvoiceByStartDateAndEndDate]
@InvoiceStartDate smalldatetime,
@InvoiceEndDate smalldatetime,
@ExcelVismaCompanyName [nvarchar](50) 
as

select MarterInvoice.* , sum(tbl_PRIM_ExcelVismaInvoiceRow.Sum) as TotalSum from (SELECT 
                     tbl_PRIM_ExcelVismaInvoice.ExcelVismaInvoice_ID,  
                     tbl_PRIM_ExcelVismaInvoice.ExcelCustomerName,tbl_PRIM_ExcelVismaInvoice.ExcelVismaCustomerNo,tbl_PRIM_ExcelVismaInvoice.ExcelVismaExternalInvoiceNo,tbl_PRIM_ExcelVismaInvoice.ExternalInvoiceDate,
					tbl_PRIM_ExcelVismaInvoice.ExcelVismaInvoiceYear , tbl_PRIM_ExcelVismaInvoice.CreatedBy,tbl_PRIM_ExcelVismaInvoice.CreatedDate,tbl_PRIM_ExcelVismaInvoice.ChangedBy,tbl_PRIM_ExcelVismaInvoice.ChangedDate,tbl_PRIM_ExcelVismaInvoice.[OurReference],
 isSendToSPCS_icon= case 
when tbl_PRIM_ExcelVismaInvoice.isSendToSPCS=0
then 'Blank' 
when tbl_PRIM_ExcelVismaInvoice.isSendToSPCS=1
then 'SendToSPCS16' 
end
,
ExcelInvoiceType= case 
when tbl_PRIM_ExcelVismaInvoice.ExcelVismaInvoiceType=1
then 'Fakt' 
when tbl_PRIM_ExcelVismaInvoice.ExcelVismaInvoiceType=2
then 'Kred' end
,
tbl_PRIM_ExcelVismaInvoice.isSendToSPCS,

tbl_PRIM_ExcelVismaInvoice.ExcelVismaInvoiceType 
FROM         tbl_PRIM_ExcelVismaInvoice 
WHERE ExcelVismaCompanyName = @ExcelVismaCompanyName

) as MarterInvoice 
left join tbl_PRIM_ExcelVismaInvoiceRow on MarterInvoice.ExcelVismaInvoice_ID=tbl_PRIM_ExcelVismaInvoiceRow.ExcelVismaInvoice_FK
group by MarterInvoice.ExcelVismaInvoice_ID,
MarterInvoice.ExcelCustomerName,
MarterInvoice.ExcelVismaCustomerNo,
MarterInvoice.ExcelVismaExternalInvoiceNo,
MarterInvoice.ExcelInvoiceType,
MarterInvoice.ExcelVismaInvoiceType,
MarterInvoice.ChangedBy,MarterInvoice.ChangedDate,
MarterInvoice.CreatedBy,
MarterInvoice.CreatedDate
,MarterInvoice.ExcelVismaInvoiceYear,
MarterInvoice.ExternalInvoiceDate,
MarterInvoice.isSendToSPCS,
MarterInvoice.isSendToSPCS_icon
,MarterInvoice.OurReference
order by MarterInvoice.ExcelVismaInvoice_ID desc