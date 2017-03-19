-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[next_step]
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @request_id NVARCHAR(50) = (SELECT TOP 1 request_id FROM lu_request WHERE status_id = 1)
	
	UPDATE lu_request
	SET step_id += 1
	WHERE request_id = @request_id
END
