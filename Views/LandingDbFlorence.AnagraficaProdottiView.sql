SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [LandingDbFlorence].[AnagraficaProdottiView]
AS
SELECT
	-- Chiavi
	T.CODSOCIETA,
    T.CODART_F,

    -- Data warehouse
	CONVERT(VARBINARY(20), HASHBYTES('MD5', CONCAT(
		T.CODSOCIETA,
        T.CODART_F,
		' '
    ))) AS HistoricalHashKey,
    CONVERT(VARBINARY(20), HASHBYTES('MD5', CONCAT(
        T.DESART1,
        T.DESC_ART,
        T.COD_LIV_3,
        T.DESC_LIV_3,
        T.COD_LIV_2,
        T.DESC_LIV_2,
        T.COD_LIV_1,
        T.DESC_LIV_1,
		' '
    ))) AS ChangeHashKey,
    CURRENT_TIMESTAMP AS DatetimeInserted,
    CURRENT_TIMESTAMP AS DatetimeUpdated,
    CAST('19000101' AS DATETIME) AS DatetimeDeleted,

	-- Attributi
    T.DESART1,
    T.DESC_ART,
    T.COD_LIV_3,
    T.DESC_LIV_3,
    T.COD_LIV_2,
    T.DESC_LIV_2,
    T.COD_LIV_1,
    T.DESC_LIV_1
	
FROM (

    SELECT
        AP.CODSOCIETA,
	    AP.CODART_F,
	    AP.DESART1,
	    AP.DESC_ART,
	    AP.COD_LIV_3,
	    AP.DESC_LIV_3,
	    AP.COD_LIV_2,
	    AP.DESC_LIV_2,
	    AP.COD_LIV_1,
	    AP.DESC_LIV_1

    FROM DBFlorencePP.dbo._TxPP_AnagraficaProdotti AP

) T;
GO
