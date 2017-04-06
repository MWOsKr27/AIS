
CREATE PROCEDURE [dbo].[finish_success]
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @request_id NVARCHAR(25) = (SELECT request_id FROM lu_request WHERE status_id = 1)
	DECLARE @request_type_id INT = (SELECT request_type_id FROM lu_request WHERE request_id = @request_id)
	DECLARE @flag INT = (SELECT flag FROM lu_request WHERE request_id = @request_id)
	
	EXEC delete_task @request_id

	UPDATE lu_request
	SET status_id = 3,
		step_id = CASE WHEN @request_type_id = 1 AND @flag = 0 THEN 8 WHEN @request_type_id = 1 AND @flag = 1 THEN 12 ELSE 15 + @flag END,
		flag += 1,
		end_timestamp = CURRENT_TIMESTAMP
	WHERE request_id = @request_id

	EXEC start_next
END