SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [Staging].[dADUserView]
AS
SELECT
	-- Chiavi
	N'FHP' AS ADDomain,
	T.ADUser,

    -- Data warehouse
	CONVERT(VARBINARY(20), HASHBYTES('MD5', CONCAT(
        T.ADUser,
		' '
    ))) AS HistoricalHashKey,
    CONVERT(VARBINARY(20), HASHBYTES('MD5', CONCAT(
        T.UserType,
		' '
    ))) AS ChangeHashKey,

	-- Attributi
    T.UserType
	
FROM (

    SELECT DISTINCT
		TADU.ADUser,
		N'Sales' AS UserType

	FROM Import.TerritorialADUsers TADU
	WHERE TADU.ADUser <> N'<nessuno>'

	UNION

	SELECT
		AADU.ADUser,
		N'Administrative' AS UserType

	FROM Import.AdministrativeADUsers AADU

) T;
GO
