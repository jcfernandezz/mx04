--M�xico 
--Impuestos IETU, ISR
--Prop�sito. Rol que da accesos a objetos de IETU
--Requisitos. Ejecutar en la compa��a.
--24/05/11 JCF Creaci�n
--
-----------------------------------------------------------------------------------
--use [COMPA�IA]

IF DATABASE_PRINCIPAL_ID('rol_ietu') IS NULL
	create role rol_ietu;

--Objetos que usa reporte base del ietu
grant select on dbo.vwGlTransaccionesIetu to rol_ietu, dyngrp;

