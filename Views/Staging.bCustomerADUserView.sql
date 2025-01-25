SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [Staging].[bCustomerADUserView]
AS
SELECT
	-- Chiavi
	T.CustomerKey,
	ADU.ADUserKey,

    -- Data warehouse
	CONVERT(VARBINARY(20), HASHBYTES('MD5', CONCAT(
        T.CustomerKey,
		ADU.ADUserKey,
		' '
    ))) AS HistoricalHashKey,
    CONVERT(VARBINARY(20), HASHBYTES('MD5', CONCAT(
        ADU.ADUserKey,
		' '
    ))) AS ChangeHashKey
	
FROM (

    SELECT
		C.CustomerKey,
		U.ADDomain,
		TADU.ADUser

	FROM Dim.Customer C
	INNER JOIN Staging.dCustomer StgC ON StgC.DivisionBusinessKey = C.DivisionBusinessKey AND StgC.CustomerBusinessKey = C.CustomerBusinessKey
	INNER JOIN Import.TerritorialADUsers TADU ON TADU.CODAGENTE = C.KeyAccountCode
	INNER JOIN Dim.ADUser U ON U.ADDomain = N'FHP' AND U.ADUser = TADU.ADUser

	UNION

	SELECT DISTINCT
		C.CustomerKey,
		U.ADDomain,
		RTADU.ADUser

	FROM Dim.Customer C
	INNER JOIN Staging.dCustomer StgC ON StgC.DivisionBusinessKey = C.DivisionBusinessKey AND StgC.CustomerBusinessKey = C.CustomerBusinessKey
	INNER JOIN Import.TerritorialADUsers TADU ON TADU.CODAGENTE = C.KeyAccountCode
	INNER JOIN Import.TerritorialADUsers RTADU ON RTADU.CODAGENTE = TADU.CODAGENTEPADRE
	INNER JOIN Dim.ADUser U ON U.ADDomain = N'FHP' AND U.ADUser = RTADU.ADUser

	UNION

	SELECT
		C.CustomerKey,
		U.ADDomain,
		AADU.ADUser

	FROM Dim.Customer C
	CROSS JOIN Import.AdministrativeADUsers AADU
	INNER JOIN Dim.ADUser U ON U.ADDomain = N'FHP' AND U.ADUser = AADU.ADUser

) T
INNER JOIN Dim.ADUser ADU ON ADU.ADDomain = T.ADDomain AND ADU.ADUser = T.ADUser;;
GO
