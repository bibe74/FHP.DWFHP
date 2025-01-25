SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [Staging].[usp_Reload_dProduct]
AS
BEGIN

SET NOCOUNT ON;

TRUNCATE TABLE Staging.dProduct;

INSERT INTO Staging.dProduct
(
    DivisionKey,
    DivisionBusinessKey,
    ProductBusinessKey,
    HistoricalHashKey,
    ChangeHashKey,
    ProductDescription,
    ProductDescription2,
    PPHyerarchyCode,
    PPLevel1Description,
    PPLevel2Description,
    PPLevel3Description
)
SELECT
    DivisionKey,
    DivisionBusinessKey,
    ProductBusinessKey,
    HistoricalHashKey,
    ChangeHashKey,
    ProductDescription,
    ProductDescription2,
    PPHyerarchyCode,
    PPLevel1Description,
    PPLevel2Description,
    PPLevel3Description

FROM Staging.dProductView;

END;
GO
