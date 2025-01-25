SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [Staging].[dProductView]
AS
SELECT
	-- Chiavi
	T.DivisionKey,
    T.DivisionBusinessKey,
    T.ProductBusinessKey,

    -- Data warehouse
	CONVERT(VARBINARY(20), HASHBYTES('MD5', CONCAT(
        T.DivisionBusinessKey,
        T.ProductBusinessKey,
		' '
    ))) AS HistoricalHashKey,
    CONVERT(VARBINARY(20), HASHBYTES('MD5', CONCAT(
        T.ProductDescription,
        T.ProductDescription2,
        T.PPHyerarchyCode,
        T.PPLevel1Description,
        T.PPLevel2Description,
        T.PPLevel3Description,
		' '
    ))) AS ChangeHashKey,

	-- Attributi
    T.ProductDescription,
    T.ProductDescription2,
    T.PPHyerarchyCode,
    T.PPLevel1Description,
    T.PPLevel2Description,
    T.PPLevel3Description
	
FROM (

    SELECT
	    D.DivisionKey,
	    D.DivisionBusinessKey,
	    AP.CODART_F AS ProductBusinessKey,
	    AP.DESART1 AS ProductDescription,
	    AP.DESC_ART AS ProductDescription2,
	    CASE
	    WHEN LEN(AP.COD_LIV_3) = 4
		    AND LEN(AP.COD_LIV_2) = 4
		    AND LEN(AP.COD_LIV_1) = 4
		    THEN CONCAT(RTRIM(LTRIM(AP.COD_LIV_3)), RTRIM(LTRIM(AP.COD_LIV_2)), RTRIM(LTRIM(AP.COD_LIV_1)))
	    WHEN LEN(AP.COD_LIV_3) = 0
		    AND LEN(AP.COD_LIV_2) = 0
		    AND LEN(AP.COD_LIV_1) = 0
		    THEN N''
	    WHEN AP.COD_LIV_3 = N'-1' THEN N''
	    ELSE N'<???>'
	    END AS PPHyerarchyCode,
	    AP.DESC_LIV_3 AS PPLevel1Description,
	    AP.DESC_LIV_2 AS PPLevel2Description,
	    AP.DESC_LIV_1 AS PPLevel3Description

    FROM LandingDbFlorence.AnagraficaProdotti AP
    INNER JOIN Dim.Division D ON D.DivisionBusinessKey = AP.CODSOCIETA

) T;
GO
