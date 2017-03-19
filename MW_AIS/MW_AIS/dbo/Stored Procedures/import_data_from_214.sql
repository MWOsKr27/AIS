-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE import_data_from_214
	-- Add the parameters for the stored procedure here
	@project_id INT
AS
BEGIN
	SET NOCOUNT ON;

	IF(SELECT COUNT(1) FROM lu_project WHERE project_id = @project_id) = 0
	BEGIN
		INSERT INTO lu_project
		SELECT * FROM CARTRMSVC214.MicroStrategyAutomation.dbo.lu_project WHERE project_id = @project_id

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
			step_id = CASE WHEN step_id = 11 THEN 0 WHEN step_id > 11 THEN step_id - 1 END,
			wh_name,
			end_timestamp,
			request_type_id,
			flag = flag - 1
		FROM CARTRMSVC214.MicroStrategyAutomation.dbo.lu_request WHERE project_id = @project_id
	END
END
