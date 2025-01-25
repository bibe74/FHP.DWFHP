SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [LandingDbFlorence].[AnagraficaTerritorioView]
AS
SELECT
	-- Chiavi
    T.CODSOCIETA,
    T.CODUTENTE,

    -- Data warehouse
	CONVERT(VARBINARY(20), HASHBYTES('MD5', CONCAT(
        T.CODSOCIETA,
        T.CODUTENTE,
		' '
    ))) AS HistoricalHashKey,
    CONVERT(VARBINARY(20), HASHBYTES('MD5', CONCAT(
        T.COGNOME,
        T.NOME,
        T.CODUTENTEPADRE,
		T.Padre_Cognome,
		T.Padre_Nome,
		' '
    ))) AS ChangeHashKey,
    CURRENT_TIMESTAMP AS DatetimeInserted,
    CURRENT_TIMESTAMP AS DatetimeUpdated,
    CAST('19000101' AS DATETIME) AS DatetimeDeleted,

	-- Attributi
    T.COGNOME,
    T.NOME,
    T.CODUTENTEPADRE,
	T.Padre_Cognome,
	T.Padre_Nome
	
FROM (

    SELECT
        TT.CODSOCIETA,
        TT.CODUTENTE,
        TT.COGNOME,
        TT.NOME,
        TT.CODUTENTEPADRE,
		TT.Padre_Cognome,
		TT.Padre_Nome

    FROM DBFlorencePP.dbo._TxPP_Territorio TT

) T;
GO
