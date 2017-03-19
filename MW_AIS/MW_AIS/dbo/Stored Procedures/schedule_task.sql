-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[schedule_task]
	@request_id NVARCHAR(MAX)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @name VARCHAR(20) = NULL
	DECLARE @time VARCHAR(5) = NULL
	DECLARE @file VARCHAR(200) = NULL
	DECLARE @batch VARCHAR(500) = NULL
	DECLARE @step INT = NULL
	
	IF(SELECT request_type_id FROM lu_request WHERE request_id = @request_id) = 1
	BEGIN
		SELECT @step = step_id FROM lu_request WHERE request_id = @request_id
		SELECT @name = 'AIS_' + CAST(project_id AS VARCHAR) + '_I' FROM lu_request WHERE request_id = @request_id

		IF @step = 1
			SET @file = 'C:\AIS\Batch\Implementation\start_DSN_creation.bat'
		ELSE IF @step = 2
			SET @file = 'C:\AIS\Batch\Implementation\start_duplication.bat'
		ELSE IF @step = 4
			SET @file = 'C:\AIS\Batch\Implementation\start_attributes.bat'
		ELSE IF @step = 7
			SET @file = 'C:\AIS\Batch\Implementation\start_retailer_settings.bat'
	END
	ELSE
	BEGIN
		SELECT @name = 'AIS_' + CAST(project_id AS VARCHAR) + '_R' FROM lu_request WHERE request_id = @request_id
		SET @file = 'C:\AIS\Batch\Ramp\start.bat'
	END
	
	DECLARE @aux DATETIME = DATEADD(MINUTE, 1, CURRENT_TIMESTAMP)
	SET @time = RIGHT('00' + CAST(DATEPART(HOUR, @aux) AS VARCHAR), 2) + ':' + RIGHT('00' + CAST(DATEPART(MINUTE, @aux) AS VARCHAR), 2)
	SET @batch = 'C:\AIS\Batch\create_task.bat ' + @name + ' ' + @time + ' ' + @file
	EXEC master..xp_CMDShell @batch
END
