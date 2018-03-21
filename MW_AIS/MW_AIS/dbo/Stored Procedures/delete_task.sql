-- =============================================
-- Author:		<OsKr #27>
-- Create date: <2017/04/05>
-- Description:	<Deletes a Windows task>
-- =============================================
CREATE PROCEDURE [dbo].[delete_task]
	@request_id NVARCHAR(25)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @request_type_id INT = (SELECT request_type_id FROM lu_request WHERE request_id = @request_id)
	DECLARE @name VARCHAR(20) = (SELECT 'AIS_' + CAST(project_id AS VARCHAR) + CASE WHEN @request_type_id = 1 THEN '_I' ELSE '_R' END FROM lu_request WHERE request_id = @request_id)
	DECLARE @batch VARCHAR(100) = 'C:\AIS\Batch\delete_task.bat ' + @name

	EXEC master..xp_CMDShell @batch
END
