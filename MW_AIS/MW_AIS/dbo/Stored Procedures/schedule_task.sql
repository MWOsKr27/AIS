-- =============================================
-- Author:		<OsKr #27>
-- Create date: <2017/05/04>
-- Description:	<Schedule a windows task>
-- =============================================
CREATE PROCEDURE [dbo].[schedule_task]
	@request_id NVARCHAR(MAX)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @step INT = (SELECT step_id FROM lu_request WHERE request_id = @request_id)
	DECLARE @request_type_id INT = (SELECT request_type_id FROM lu_request WHERE request_id = @request_id)
	DECLARE @name VARCHAR(20) = (SELECT 'AIS_' + CAST(project_id AS VARCHAR) + CASE WHEN @request_type_id = 1 THEN '_I' ELSE '_R' END FROM lu_request WHERE request_id = @request_id)

	DECLARE @aux DATETIME = DATEADD(MINUTE, 1, CURRENT_TIMESTAMP)
	DECLARE @time VARCHAR(5) = RIGHT('00' + CAST(DATEPART(HOUR, @aux) AS VARCHAR), 2) + ':' + RIGHT('00' + CAST(DATEPART(MINUTE, @aux) AS VARCHAR), 2)
	
	DECLARE @file VARCHAR(200) = NULL
	DECLARE @batch VARCHAR(500) = NULL

	IF @step = 1
		SET @file = 'C:\AIS\Batch\Implementation\start_DSN_creation.bat'
	ELSE IF @step = 2
		SET @file = 'C:\AIS\Batch\Implementation\start_duplication.bat'
	ELSE IF @step = 4
		SET @file = 'C:\AIS\Batch\Implementation\start_attributes.bat'
	ELSE IF @step = 7
		SET @file = 'C:\AIS\Batch\Implementation\start_retailer_settings.bat'
	ELSE IF @step = 8
		SET @file = 'C:\AIS\Batch\Implementation\start_portal_setup.bat'
	ELSE IF @step = 9
		SET @file = 'C:\AIS\Batch\Duplication\start_DSN_creation.bat'
	ELSE IF @step = 10
		SET @file = 'C:\AIS\Batch\Duplication\start_duplication.bat'
	ELSE IF @step = 13
		SET @file = 'C:\AIS\Batch\Ramp\start_ramp.bat'
	
	SET @batch = 'C:\AIS\Batch\create_task.bat ' + @name + ' ' + @time + ' ' + @file
	EXEC master..xp_CMDShell @batch
END
