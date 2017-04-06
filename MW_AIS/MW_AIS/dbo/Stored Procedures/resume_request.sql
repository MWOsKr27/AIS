-- =============================================
-- Author:		<OsKr #27>
-- Create date: <2017/04/05>
-- Description:	<Resumes a request>
-- =============================================
CREATE PROCEDURE [dbo].[resume_request]
	@request_id NVARCHAR(25),
	@server_id INT
AS
BEGIN
	SET NOCOUNT ON;
	
	UPDATE lu_request
	SET status_id = 4,
		end_timestamp = NULL,
		server_id = @server_id,
		step_id = 0
	WHERE request_id = @request_id

	EXEC start_next
END