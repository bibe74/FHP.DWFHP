SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [Staging].[usp_Reload_fSales]
AS
BEGIN

SET NOCOUNT ON;

TRUNCATE TABLE Staging.fSales;

INSERT INTO Staging.fSales
(
    DivisionKey,
    DivisionBusinessKey,
    DateKey,
    CustomerKey,
	CustomerBusinessKey,
    ProductKey,
    ProductBusinessKey,
    HistoricalHashKey,
    ChangeHashKey,
    SalesQuantity,
    SalesAmount
)
SELECT
    DivisionKey,
    DivisionBusinessKey,
    DateKey,
    CustomerKey,
	CustomerBusinessKey,
    ProductKey,
    ProductBusinessKey,
    HistoricalHashKey,
    ChangeHashKey,
    SalesQuantity,
    SalesAmount

FROM Staging.fSalesView;

END;
GO
