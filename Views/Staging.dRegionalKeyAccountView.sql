SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [Staging].[dRegionalKeyAccountView]
AS
SELECT
	-- Chiavi
    T.KeyAccountCode,

    -- Data warehouse
	CONVERT(VARBINARY(20), HASHBYTES('MD5', CONCAT(
        T.KeyAccountCode,
		' '
    ))) AS HistoricalHashKey,
    CONVERT(VARBINARY(20), HASHBYTES('MD5', CONCAT(
        T.KeyAccountDescription,
        T.RegionalKeyAccountCode,
        T.RegionalKeyAccountDescription,
		' '
    ))) AS ChangeHashKey,

	-- Attributi
    T.KeyAccountDescription,
    T.RegionalKeyAccountCode,
    T.RegionalKeyAccountDescription
	
FROM (

	SELECT DISTINCT
		CODAGENTE AS KeyAccountCode,
		Description AS KeyAccountDescription,
		CODAGENTEPADRE AS RegionalKeyAccountCode,
		SalesGroupDescription AS RegionalKeyAccountDescription

	FROM Import.TerritorialADUsers

) T;
GO
