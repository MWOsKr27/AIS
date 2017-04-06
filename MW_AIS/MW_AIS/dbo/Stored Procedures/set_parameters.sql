-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[set_parameters]
	@request_id NVARCHAR(25)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @project_name VARCHAR(100) = (SELECT p.project_name FROM lu_project p JOIN lu_request r ON p.project_id = r.project_id WHERE r.request_id = @request_id)
	DECLARE @project_type_id INT = (SELECT request_type_id FROM lu_request WHERE request_id = @request_id)
	DECLARE @flag INT = (SELECT flag FROM lu_request WHERE request_id = @request_id)

	DECLARE @param VARCHAR(300) = NULL
	DECLARE @batch VARCHAR(400) = NULL

	SET @param = CAST(@project_type_id AS VARCHAR)
	SET @param += ' ' + @project_name
	SET @batch = 'C:\AIS\Batch\clean_parameters.bat ' + @param
	EXEC master..xp_CMDShell @batch

	IF @project_type_id = 1
	BEGIN
		SET @param = @project_name
		SET @param += ' ' + CAST((SELECT project_id FROM lu_request WHERE request_id = @request_id) AS VARCHAR)
		SET @param += ' ' + (SELECT s.server_name FROM lu_server s JOIN lu_request r ON s.server_id = r.server_id WHERE r.request_id = @request_id)
		SET @param += ' ' + (SELECT wh_name FROM lu_request WHERE request_id = @request_id)
		SET @param += ' ' + LOWER(@project_name) + 'user'
		SET @param += ' ' + LOWER(@project_name) + 'user123'
		SET @batch = CASE WHEN @flag = 0 THEN 'C:\AIS\Batch\Implementation\write_DSN_parameters.bat ' ELSE 'C:\AIS\Batch\Duplication\write_DSN_parameters.bat ' END + @param
		EXEC master..xp_CMDShell @batch

		SET @param = @project_name
		IF @flag = 0 SET @param += ' ' + CAST((SELECT item_account FROM lu_request WHERE request_id = @request_id) AS VARCHAR)
		SET @param += ' ' + CAST((SELECT project_id FROM lu_request WHERE request_id = @request_id) AS VARCHAR)
		SET @batch = CASE WHEN @flag = 0 THEN 'C:\AIS\Batch\Implementation\write_duplication_parameters.bat ' ELSE 'C:\AIS\Batch\Duplication\write_duplication_parameters.bat ' END + @param
		EXEC master..xp_CMDShell @batch

		SET @param = @project_name
		SET @param += ' ' + (SELECT retailer_string FROM lu_request WHERE request_id = @request_id)
		SET @param += ' ' + CAST((SELECT supplier_calendar FROM lu_request WHERE request_id = @request_id) AS VARCHAR)
		SET @batch = 'C:\AIS\Batch\Implementation\write_retailer_settings_parameters.bat ' + @param
		EXEC master..xp_CMDShell @batch

		SET @param = CAST((SELECT project_id FROM lu_request WHERE request_id = @request_id) AS VARCHAR)
		SET @param += ' ' + (SELECT s.server_name FROM lu_server s JOIN lu_request r ON s.server_id = r.server_id WHERE r.request_id = @request_id)
		SET @param += ' ' + (SELECT s.server_address FROM lu_server s JOIN lu_request r ON s.server_id = r.server_id WHERE r.request_id = @request_id)
		SET @batch = 'C:\AIS\Batch\Implementation\write_portal_setup_parameters.bat ' + @param
		EXEC master..xp_CMDShell @batch
	END
	ELSE IF @project_type_id = 2
	BEGIN
		SET @param = @project_name
		SET @param += ' ' + (SELECT retailer_string FROM lu_request WHERE request_id = @request_id)
		SET @param += ' ' + CAST(@flag AS VARCHAR)
		SET @batch = 'C:\AIS\Batch\Ramp\write_parameters.bat ' + @param
		EXEC master..xp_CMDShell @batch
	END
END