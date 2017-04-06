-- =============================================
-- Author:		<OsKr #27>
-- Create date: <2017/04/05>
-- Description:	<Start next request in queue>
-- =============================================
CREATE PROCEDURE [dbo].[start_next]
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @request_id NVARCHAR(25) = NULL
	DECLARE @request_type_id INT = NULL
	DECLARE @flag INT = NULL

	DECLARE @count_in_queue INT = (SELECT COUNT(1) FROM lu_request WHERE status_id = 4)
	DECLARE @count_in_progress INT = (SELECT COUNT(1) FROM lu_request WHERE status_id = 1)
	
	IF (@count_in_queue > 0) AND (@count_in_progress = 0)
	BEGIN
		SELECT TOP 1 @request_id = request_id FROM lu_request WHERE status_id = 4 ORDER BY start_timestamp

		SELECT @request_type_id = request_type_id FROM lu_request WHERE request_id = @request_id
		SELECT @flag = flag FROM lu_request WHERE request_id = @request_id
		
		IF (@request_type_id = 1 AND @flag = 0)
			UPDATE lu_request SET step_id = 1 WHERE request_id = @request_id
		ELSE IF (@request_type_id = 1 AND @flag = 1)
			UPDATE lu_request SET step_id = 9 WHERE request_id = @request_id
		ELSE
			UPDATE lu_request SET step_id = 13 WHERE request_id = @request_id

		UPDATE lu_request SET status_id = 1 WHERE request_id = @request_id
	END
END
