-- =============================================
-- Author:		<OsKr #27>
-- Create date: <2017/04/07>
-- Description:	<Import data from AIS 9.4.1>
-- =============================================
CREATE PROCEDURE import_data_from_214
	@project_id INT
AS
BEGIN
	SET NOCOUNT ON;

	IF(SELECT COUNT(1) FROM lu_project WHERE project_id = @project_id) = 0
	BEGIN
		INSERT INTO lu_project (project_id, project_name)
		SELECT * FROM CARTRMSVC214.MicroStrategyAutomation.dbo.lu_project WHERE project_id = @project_id
	END

	BEGIN TRY
		INSERT INTO lu_request
		SELECT
			request_id,
			project_id,
			server_id,
			requester_id,
			status_id,
			supplier_calendar,
			item_account,
			start_timestamp,
			retailer_string,
			step_id = CASE WHEN step_id = 8 THEN 12
						WHEN step_id = 11 THEN 0 
						WHEN step_id = 12 THEN 15
						WHEN step_id = 13 THEN 16 END,
			wh_name,
			end_timestamp,
			request_type_id,
			flag = CASE WHEN flag IS NOT NULL THEN flag - 1 ELSE 0 END
		FROM CARTRMSVC214.MicroStrategyAutomation.dbo.lu_request WHERE project_id = @project_id
	END TRY
	BEGIN CATCH
		PRINT 'Items were not fully migrated from 9.4.1 to 10'
	END CATCH
END
