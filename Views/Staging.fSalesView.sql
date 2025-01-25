SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [Staging].[fSalesView]
AS
SELECT
	-- Chiavi
	T.DivisionKey,
    T.DivisionBusinessKey,
    T.DateKey,
    T.CustomerKey,
	T.CustomerBusinessKey,
    T.ProductKey,
    T.ProductBusinessKey,

    -- Data warehouse
	CONVERT(VARBINARY(20), HASHBYTES('MD5', CONCAT(
        T.DivisionBusinessKey,
        T.DateKey,
        T.CustomerBusinessKey,
        T.ProductBusinessKey,
		' '
    ))) AS HistoricalHashKey,
    CONVERT(VARBINARY(20), HASHBYTES('MD5', CONCAT(
        T.SalesQuantity,
        T.SalesAmount,
		' '
    ))) AS ChangeHashKey,

	-- Misure
    T.SalesQuantity,
    T.SalesAmount
	
FROM (

    SELECT
	    D.DivisionKey,
	    D.DivisionBusinessKey,
        DF.DateKey,
		RF.CODCLI,
		COALESCE(C.CustomerKey, CASE WHEN RF.CODCLI = N'' THEN -D.DivisionKey ELSE -100-D.DivisionKey END) AS CustomerKey,
		COALESCE(C.CustomerBusinessKey, CASE WHEN COALESCE(RF.CODCLI, N'') = N'' THEN N'' ELSE N'???' END) AS CustomerBusinessKey,
        COALESCE(P.ProductKey, -D.DivisionKey) AS ProductKey,
        COALESCE(P.ProductBusinessKey, N'') AS ProductBusinessKey,
        RF.QTAFATT AS SalesQuantity,
        RF.IMPFATT AS SalesAmount

    FROM LandingDbFlorence.RiepilogoFatturato RF
    INNER JOIN Dim.Division D ON D.DivisionBusinessKey = RF.CODSOCIETA
    --INNER JOIN Dim.Date DF ON DF.Date = RF.DATA
    INNER JOIN Dim.Date DF ON DF.Datetime = RF.DATA
	LEFT JOIN Dim.Customer C ON C.DivisionBusinessKey = RF.CODSOCIETA AND C.CustomerBusinessKey = RF.CODCLI
    LEFT JOIN Dim.Product P ON P.DivisionBusinessKey = RF.CODSOCIETA AND P.ProductBusinessKey = RF.CODART
	WHERE RF.Datetimeupdated > DATEADD(DAY,  -1, CURRENT_TIMESTAMP)

) T
LEFT JOIN dim.Customer CC ON CC.CustomerKey = T.CustomerKey;
GO
