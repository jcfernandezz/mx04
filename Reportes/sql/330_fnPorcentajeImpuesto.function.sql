IF OBJECT_ID ('dbo.fnPorcentajeImpuesto') IS NOT NULL
   DROP FUNCTION dbo.fnPorcentajeImpuesto
GO

create FUNCTION fnPorcentajeImpuesto (@p_idimpuesto varchar(20))
RETURNS numeric(19,5)
AS
BEGIN
   DECLARE @l_TXDTLPCT numeric(19,5)
   select @l_TXDTLPCT = round(TXDTLPCT/100, 2) from tx00201 where taxdtlid = @p_idimpuesto
   RETURN(@l_TXDTLPCT)
END
go

IF (@@Error = 0) PRINT 'Creaci�n exitosa de la funci�n: fnPorcentajeImpuesto()'
ELSE PRINT 'Error en la creaci�n de la funci�n: fnPorcentajeImpuesto()'
GO
