SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [Staging].[dCustomerView]
AS
SELECT
	-- Chiavi
    T.DivisionKey,
    T.DivisionBusinessKey,
    T.CustomerBusinessKey,

    -- Data warehouse
	CONVERT(VARBINARY(20), HASHBYTES('MD5', CONCAT(
        T.DivisionKey,
        T.DivisionBusinessKey,
		' '
    ))) AS HistoricalHashKey,
    CONVERT(VARBINARY(20), HASHBYTES('MD5', CONCAT(
        T.CustomerBusinessKey,
        T.RegionalKeyAccount,
        T.KeyAccountDescription,
        T.StartDate,
        T.EndDate,
        T.Customer,
        T.KeyAccountCode,
		T.KeyAccountDescription,
		T.RegionalKeyAccountDescription,
        T.CustomerStatisticCode,
        T.PPHyerarchyCode,
        T.PPLevel1Description,
        T.PPLevel2Description,
        T.PPLevel3Description,
        T.PPLevel4Description,
        T.PPLevel5Description,
        T.PPLevel6Description,
        T.PPLevel7Description,
		' '
    ))) AS ChangeHashKey,

	-- Attributi
    T.RegionalKeyAccount,
    --T.KeyAccountDescription,
    T.StartDate,
    T.EndDate,
    T.Customer,
    T.KeyAccountCode,
	T.KeyAccountDescription,
	T.RegionalKeyAccountDescription,
    T.CustomerStatisticCode,
    T.PPHyerarchyCode,
    T.PPLevel1Description,
    T.PPLevel2Description,
    T.PPLevel3Description,
    T.PPLevel4Description,
    T.PPLevel5Description,
    T.PPLevel6Description,
    T.PPLevel7Description
	
FROM (

    SELECT
	    D.DivisionKey,
	    D.DivisionBusinessKey,
        AGC.CODCLI_F AS CustomerBusinessKey,
        AGC.CODUTENTEPADRE AS RegionalKeyAccount,
        --AGC.DESCR AS KeyAccountDescription,
        AGC.DATAINI AS StartDate,
        AGC.DATAFINE AS EndDate,
        AGC.RAGSOC1 AS Customer,
        AGC.CODAGENTE AS KeyAccountCode,
		--UPPER(COALESCE(CONCAT(ATT.COGNOME, N' ', ATT.NOME), N'')) AS KeyAccountDescription,
		COALESCE(RKA.KeyAccountDescription, N'') AS KeyAccountDescription,
		--UPPER(COALESCE(CONCAT(ATT.Padre_Cognome, N' ', ATT.Padre_Nome), N'')) AS RegionalKeyAccountDescription,
        COALESCE(RKA.RegionalKeyAccountDescription, N'') AS RegionalKeyAccountDescription,
		AGC.CODCLI_STATISTICO AS CustomerStatisticCode,
        COALESCE(AGC.LIV7, N'') AS PPHyerarchyCode,
        COALESCE(AGC.LIV1_DESCR, N'') AS PPLevel1Description,
        COALESCE(AGC.LIV2_DESCR, N'') AS PPLevel2Description,
        COALESCE(AGC.LIV3_DESCR, N'') AS PPLevel3Description,
        COALESCE(AGC.LIV4_DESCR, N'') AS PPLevel4Description,
        COALESCE(AGC.LIV5_DESCR, N'') AS PPLevel5Description,
        COALESCE(AGC.LIV6_DESCR, N'') AS PPLevel6Description,
        COALESCE(AGC.LIV7_DESCR, N'') AS PPLevel7Description

    FROM LandingDbFlorence.AnagraficaClienti AGC
    INNER JOIN Dim.Division D ON D.DivisionBusinessKey = AGC.CODSOCIETA
	--LEFT JOIN LandingDbFlorence.AnagraficaTerritorio ATT ON ATT.CODSOCIETA = AGC.CODSOCIETA AND ATT.CODUTENTE = AGC.CODAGENTE
	LEFT JOIN Staging.dRegionalKeyAccount RKA ON RKA.KeyAccountCode = AGC.CODAGENTE
) T;
GO
