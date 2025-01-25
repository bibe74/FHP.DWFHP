SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [LandingDbFlorence].[AnagraficaClientiView]
AS
SELECT
	-- Chiavi
    T.CODSOCIETA,
    T.CODCLI_F,

    -- Data warehouse
	CONVERT(VARBINARY(20), HASHBYTES('MD5', CONCAT(
		T.CODSOCIETA,
        T.CODCLI_F,
		' '
    ))) AS HistoricalHashKey,
    CONVERT(VARBINARY(20), HASHBYTES('MD5', CONCAT(
        T.CODUTENTEPADRE,
        T.DESCR,
        T.DATAINI,
        T.DATAFINE,
        T.RAGSOC1,
        T.CODAGENTE,
        T.CODCLI_STATISTICO,
        T.LIV1,
        T.LIV1_DESCR,
        T.LIV2,
        T.LIV2_DESCR,
        T.LIV3,
        T.LIV3_DESCR,
        T.LIV4,
        T.LIV4_DESCR,
        T.LIV5,
        T.LIV5_DESCR,
        T.LIV6,
        T.LIV6_DESCR,
        T.LIV7,
        T.LIV7_DESCR,
		' '
    ))) AS ChangeHashKey,
    CURRENT_TIMESTAMP AS DatetimeInserted,
    CURRENT_TIMESTAMP AS DatetimeUpdated,
    CAST('19000101' AS DATETIME) AS DatetimeDeleted,

	-- Attributi
    T.CODUTENTEPADRE,
    T.DESCR,
    T.DATAINI,
    T.DATAFINE,
    T.RAGSOC1,
    T.CODAGENTE,
    T.CODCLI_STATISTICO,
    T.LIV1,
    T.LIV1_DESCR,
    T.LIV2,
    T.LIV2_DESCR,
    T.LIV3,
    T.LIV3_DESCR,
    T.LIV4,
    T.LIV4_DESCR,
    T.LIV5,
    T.LIV5_DESCR,
    T.LIV6,
    T.LIV6_DESCR,
    T.LIV7,
    T.LIV7_DESCR
	
FROM (

    SELECT
        AGC.CODSOCIETA,
        AGC.CODCLI_F,

        AGC.CODUTENTEPADRE,
        AGC.DESCR,
        AGC.DATAINI,
        AGC.DATAFINE,
        AGC.RAGSOC1,
        AGC.CODAGENTE,
        AGC.CODCLI_STATISTICO,
        AGC.LIV1,
        AGC.LIV1_DESCR,
        AGC.LIV2,
        AGC.LIV2_DESCR,
        AGC.LIV3,
        AGC.LIV3_DESCR,
        AGC.LIV4,
        AGC.LIV4_DESCR,
        AGC.LIV5,
        AGC.LIV5_DESCR,
        AGC.LIV6,
        AGC.LIV6_DESCR,
        AGC.LIV7,
        AGC.LIV7_DESCR

    FROM DBFlorencePP.dbo._TxPP_AnagraficaGerarchia_Clienti AGC

) T;
GO
