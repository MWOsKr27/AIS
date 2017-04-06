CREATE PROCEDURE [dbo].[add_request]
	@project_id INT,
	@server_id INT,
	@requester_id INT,
	@supplier_calendar INT,
	@item_account INT,
	@request_type_id INT,
	@project_name NVARCHAR(100),
	@retailer NVARCHAR(MAX)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @count INT = (SELECT COUNT(1) FROM lu_project WHERE project_id = @project_id)

	IF (@count = 0)
		INSERT INTO lu_project VALUES (@project_id, @project_name)

	DECLARE @request_id NVARCHAR(25) = CASE WHEN @request_type_id = 1 THEN 'I:' ELSE 'R:' END + CONVERT(NVARCHAR(6), @project_id) + ':' + CONVERT(NVARCHAR(16), CURRENT_TIMESTAMP, 21)
	SELECT @project_name = project_name FROM lu_project WHERE project_id = @project_id
	
	BEGIN TRY
		INSERT INTO lu_request (
			request_id,
			project_id,
			server_id,
			requester_id,
			status_id,
			supplier_calendar,
			item_account,
			start_timestamp,
			retailer_string,
			step_id,
			wh_name,
			end_timestamp,
			request_type_id
		) VALUES (
			@request_id,
			@project_id,
			@server_id,
			@requester_id,
			4,
			@supplier_calendar,
			@item_account,
			CURRENT_TIMESTAMP,
			@retailer,
			0,
			@project_name,
			NULL,
			@request_type_id
		)
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE()
	END CATCH
END
