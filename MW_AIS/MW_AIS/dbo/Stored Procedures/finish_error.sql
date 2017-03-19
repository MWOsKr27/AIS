-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[finish_error]
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @request_id NVARCHAR(25) = (SELECT TOP 1 request_id FROM lu_request WHERE status_id = 1 ORDER BY start_timestamp)
	EXEC delete_task @request_id

	UPDATE lu_request
	SET status_id = 2
	WHERE request_id = @request_id

	EXEC start_next
END
