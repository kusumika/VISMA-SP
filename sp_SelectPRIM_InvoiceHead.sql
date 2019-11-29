ALTER PROCEDURE [dbo].[sp_SelectPRIM_InvoiceHead]
@Company_ID int,
@Invoice_ID int

as

select @Invoice_ID Invoice_ID,Company_ID,tbl_PRIM_AddressHasAddressTypes.Value1, tbl_PRIM_PostalPlaces.Postnummer, tbl_PRIM_PostalPlaces.Postort, tbl_PRIM_AddressTypes.AddressTypeName, 
       tbl_PRIM_AddressTypes.AddressType_ID, tbl_PRIM_AddressCore.Tel, tbl_PRIM_AddressCore.Cell, tbl_PRIM_AddressCore.Fax,tbl_PRIM_AddressCore.Email, tbl_PRIM_Companies.CompanyNo, 
       tbl_PRIM_Companies.CompanyName,tbl_PRIM_Companies.CompanyRegNo, tbl_PRIM_PostalPlaces.Lan, tbl_PRIM_AddressHasAddressTypes.Value2, tbl_PRIM_Countries.CountryName,tbl_prim_countries.CountryCode 
       into #temp
from  tbl_PRIM_Companies left outer join
      tbl_PRIM_AddressCore ON tbl_PRIM_AddressCore.Address_ID = tbl_PRIM_Companies.Company_ID left outer join
      tbl_PRIM_AddressHasAddressTypes ON tbl_PRIM_AddressCore.Address_ID = tbl_PRIM_AddressHasAddressTypes.Address_ID left outer join
      tbl_PRIM_AddressTypes ON tbl_PRIM_AddressHasAddressTypes.AddressType_fk = tbl_PRIM_AddressTypes.AddressType_ID left outer join
      tbl_PRIM_PostalPlaces ON tbl_PRIM_AddressHasAddressTypes.Place_fk = tbl_PRIM_PostalPlaces.PostalPlace_ID left outer join
      tbl_PRIM_Countries ON tbl_PRIM_PostalPlaces.Country_fk = tbl_PRIM_Countries.Country_ID
where tbl_PRIM_Companies.Company_ID = @Company_ID and tbl_PRIM_AddressTypes.AddressType_ID=4     

select *,
                     [dbo].[fn_InvoiceRounding] (tbl_PRIM_Invoice.VATAmount) AS InvoiceRounding,(select CompanyRegNo from tbl_PRIM_Companies where Company_ID = tbl_PRIM_Invoice.Company_fk ) CustomerRegNo,PaymentTerms as PaymentTermsName
from tbl_PRIM_Invoice,#temp 
where tbl_PRIM_Invoice.Invoice_ID = #temp.Invoice_ID
and tbl_PRIM_Invoice.Invoice_ID=@Invoice_ID

--exec [dbo].[sp_SelectPRIM_InvoiceHead] 378,126
--SELECT * FROM dbo.tbl_PRIM_Invoice