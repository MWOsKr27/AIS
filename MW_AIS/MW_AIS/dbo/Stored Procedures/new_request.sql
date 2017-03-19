
CREATE PROCEDURE [dbo].[new_request]
	@project_id INT,
	@server_id INT,
	@requester_id INT,
	@supplier_calendar INT,
	@item_account INT,
	@request_type_id INT,
	@project_name NVARCHAR(100),
	@retailer NVARCHAR(MAX),
	@flag INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @request_id NVARCHAR(25)
	
	IF @request_type_id = 1
	BEGIN
		SET @request_id = 'I:' + CONVERT(NVARCHAR(6), @project_id) + ':' + CONVERT(NVARCHAR(16), CURRENT_TIMESTAMP, 21)

		BEGIN TRY
			INSERT INTO lu_project
			VALUES (
				@project_id,
				@project_name
			)
		END TRY
		BEGIN CATCH
			PRINT ERROR_MESSAGE()
		END CATCH
	END
	ELSE
	BEGIN
		SELECT @project_name = project_name FROM lu_project WHERE project_id = @project_id
		SET @request_id = 'R:' + CONVERT(NVARCHAR(6), @project_id) + ':' + CONVERT(NVARCHAR(16), CURRENT_TIMESTAMP, 21)
	END
	
	BEGIN TRY
		INSERT INTO lu_request
		VALUES (
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
			@request_type_id,
			@flag
		)
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE()
	END CATCH
END
