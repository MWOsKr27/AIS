-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[start_next]
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @request_id NVARCHAR(25)
	DECLARE @count INT = (SELECT COUNT(1) FROM lu_request WHERE status_id = 4)

	IF (@count > 0) AND ((SELECT COUNT(1) FROM lu_request WHERE status_id = 1) = 0)
	BEGIN
		SELECT TOP 1 @request_id = request_id FROM lu_request WHERE status_id = 4 ORDER BY start_timestamp

		IF(SELECT request_type_id FROM lu_request WHERE request_id = @request_id) = 1
			UPDATE lu_request SET step_id = 1 WHERE request_id = @request_id
		ELSE
			UPDATE lu_request SET step_id = 9 WHERE request_id = @request_id

		UPDATE lu_request SET status_id = 1 WHERE request_id = @request_id
	END
END
