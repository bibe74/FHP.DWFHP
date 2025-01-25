SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [LandingDbFlorence].[RiepilogoFatturatoView]
AS
SELECT
	-- Chiavi
    T.CODSOCIETA,
    T.DATA,
    T.CODCLI,
    T.CODART,

    -- Data warehouse
	CONVERT(VARBINARY(20), HASHBYTES('MD5', CONCAT(
        T.CODSOCIETA,
        T.DATA,
        T.CODCLI,
        T.CODART,
		' '
    ))) AS HistoricalHashKey,
    CONVERT(VARBINARY(20), HASHBYTES('MD5', CONCAT(
        T.QTAFATT,
        T.IMPFATT,
		' '
    ))) AS ChangeHashKey,
    CURRENT_TIMESTAMP AS DatetimeInserted,
    CURRENT_TIMESTAMP AS DatetimeUpdated,
    CAST('19000101' AS DATETIME) AS DatetimeDeleted,

	-- Misure
    T.QTAFATT,
    T.IMPFATT
	
FROM (

    SELECT
        'IT1C' AS CODSOCIETA,
        F.DATA,
        F.CODCLI,
        F.CODART,
        SUM(F.QTAFATT) AS QTAFATT,
        SUM(F.IMPFATT) AS IMPFATT

    FROM DBFlorencePP.dbo._Fatturato F
    GROUP BY F.DATA,
        F.CODCLI,
        F.CODART

) T;
GO
