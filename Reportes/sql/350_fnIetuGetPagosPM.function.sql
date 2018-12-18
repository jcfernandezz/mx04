-------------------------------------------------------------------------------------------------
IF OBJECT_ID ('dbo.fnIetuGetPagosPM') IS NOT NULL
   DROP FUNCTION dbo.fnIetuGetPagosPM
GO

create function dbo.fnIetuGetPagosPM(@VCHRNMBR varchar(21), @DOCTYPE smallint)
returns table
as
--Prop�sito. Obtiene datos del pago original: 
--			pago simult�neo en factura, miscel�neos, pagos mcp, pagos manuales, pagos anulados, cheques computarizados
--Requisitos. 
--09/01/13 jcf Creaci�n 
--
return
( 
	--Documentos PM: factura, miscel�neos, pagos, anulaci�n de facturas, cheques computarizados
	select pt.txrgnnum, pt.USERDEF1, pt.doctype, pt.vchrnmbr,
		'' poprctnm, 
		case when pt.ttlpymts <> 0 then		--pago simult�neo en la factura
			ie.voided_apfr					--pago anulado?
		else
			 pt.voided 
		end voided,
		isnull(ie.aplica_IETU, 0) aplica_IETU, isnull(ie.prchamntProporcional, 0) prchamntProporcional, 0 slsamntProporcional
	from vwPmTransaccionesTodas pt			--[doctype, vchrnmbr]
		outer apply dbo.fnAplicaIETU(pt.VCHRNMBR, pt.DOCTYPE, pt.ttlpymts) ie
	where --@SOURCEDOC in ('PMTRX', 'PMPAY', 'PMVVR', 'PMVPY', 'PMCHK')
	 pt.VCHRNMBR = @VCHRNMBR
	and pt.DOCTYPE = @DOCTYPE
)
go

IF (@@Error = 0) PRINT 'Creaci�n exitosa de la funci�n: fnIetuGetPagosPM()'
ELSE PRINT 'Error en la creaci�n de la funci�n: fnIetuGetPagosPM()'
GO
