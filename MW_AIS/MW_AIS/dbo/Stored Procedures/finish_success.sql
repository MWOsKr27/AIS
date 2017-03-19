
CREATE PROCEDURE [dbo].[finish_success]
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @request_id NVARCHAR(25) = (SELECT request_id FROM lu_request WHERE status_id = 1)
	DECLARE @flag INT = (SELECT flag FROM lu_request WHERE request_id = @request_id)
	EXEC delete_task @request_id
	
	IF(SELECT request_type_id FROM lu_request WHERE request_id = @request_id) = 1
	BEGIN
		UPDATE lu_request
		SET status_id = 3,
			step_id = 8,
			end_timestamp = CURRENT_TIMESTAMP
		WHERE request_id = @request_id
	END
	ELSE
	BEGIN
		UPDATE lu_request
		SET status_id = 3,
			step_id = 11 + @flag,
			flag += 1,
			end_timestamp = CURRENT_TIMESTAMP
		WHERE request_id = @request_id
	END

	EXEC start_next
END