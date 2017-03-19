-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[resume_ramp]
	@request_id NVARCHAR(25)
AS
BEGIN
	SET NOCOUNT ON;
	
	UPDATE lu_request
	SET status_id = 4,
		end_timestamp = NULL,
		step_id = 0
	WHERE request_id = @request_id

	EXEC start_next
END