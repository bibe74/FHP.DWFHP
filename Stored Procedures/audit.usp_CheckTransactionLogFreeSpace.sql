SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE   PROCEDURE [audit].[usp_CheckTransactionLogFreeSpace]
(@MinFreeLogSpaceMB INT = NULL)
AS
BEGIN

    -- Check https://www.wikihow.com/Check-Transaction-Log-Size-in-Sql-Server for the queries used here

    DECLARE @MinFreeSpacePercentage INT = 30;
    DECLARE @profile_name NVARCHAR(127) = N'Default profile',
            @recipients NVARCHAR(127) = N'alberto.turelli@gmail.com',
            @query_attachment_filename NVARCHAR(127) = N'warning.txt';

    DECLARE @subject NVARCHAR(128),
            @body NVARCHAR(1024),
            @query NVARCHAR(1024);

    SET @query
        = N'SELECT @TotalLogSizeMB AS TotalLogSizeMB,
           @MinFreeLogSpaceMB AS MinFreeLogSpaceMB,
           @UsedLogSpaceMB AS UsedLogSpaceMB,
           @FreeLogSpaceMB AS FreeLogSpaceMB,
           CASE
               WHEN @FreeLogSpaceMB < @MinFreeLogSpaceMB THEN
                   N''!!!CRITICAL SITUATION!!!''
               ELSE
                   N''''
           END AS Warning;';

    SET NOCOUNT ON;

    DECLARE @TotalLogSizeMB INT,
            @UsedLogSpaceMB INT,
            @FreeLogSpaceMB INT;

    SELECT @TotalLogSizeMB = CONVERT(INT, ROUND(total_log_size_in_bytes * 1.0 / 1024 / 1024, 0)),
           @UsedLogSpaceMB = CONVERT(INT, ROUND(used_log_space_in_bytes * 1.0 / 1024 / 1024, 0)),
           @FreeLogSpaceMB
               = CONVERT(INT, ROUND((total_log_size_in_bytes - used_log_space_in_bytes) * 1.0 / 1024 / 1024, 0))
    FROM sys.dm_db_log_space_usage;

    IF (@MinFreeLogSpaceMB IS NULL)
    BEGIN

        SET @MinFreeLogSpaceMB = CONVERT(INT, ROUND(@TotalLogSizeMB * 1.0 * @MinFreeSpacePercentage / 100, 0));

    END;

    SELECT @TotalLogSizeMB AS TotalLogSizeMB,
           @MinFreeLogSpaceMB AS MinFreeLogSpaceMB,
           @UsedLogSpaceMB AS UsedLogSpaceMB,
           @FreeLogSpaceMB AS FreeLogSpaceMB,
           CASE
               WHEN @FreeLogSpaceMB < @MinFreeLogSpaceMB THEN
                   N'!!!CRITICAL SITUATION!!!'
               ELSE
                   N''
           END AS Warning;

    IF (@FreeLogSpaceMB < @MinFreeLogSpaceMB)
    BEGIN

        SELECT @subject
            = REPLACE(
                         REPLACE(
                                    N'%SERVERNAME%: Transaction log space ALERT for database %DB_NAME%',
                                    N'%SERVERNAME%',
                                    @@SERVERNAME
                                ),
                         N'%DB_NAME%',
                         DB_NAME()
                     ),
               @body
                   = REPLACE(
                                REPLACE(
                                           N'Transaction log space lower than %MinFreeLogSpaceMB% for database %DB_NAME%',
                                           N'%MinFreeLogSpaceMB%',
                                           CONVERT(NVARCHAR(10), @MinFreeLogSpaceMB)
                                       ),
                                N'%DB_NAME%',
                                DB_NAME()
                            );

        EXEC msdb.dbo.sp_send_dbmail @profile_name = @profile_name,
                                     @recipients = @recipients,
                                     @subject = @subject,
                                     @body = @body,
                                     @query = @query,
                                     @attach_query_result_as_file = 1,
                                     @query_attachment_filename = @query_attachment_filename;

    END;

END;
GO
