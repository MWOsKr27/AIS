-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[delete_task]
	@request_id NVARCHAR(25)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @name VARCHAR(20) = NULL
	DECLARE @batch VARCHAR(100) = NULL

	IF(SELECT request_type_id FROM lu_request WHERE request_id = @request_id) = 1
		SELECT @name = 'AIS_' + CAST(project_id AS VARCHAR) + '_I' FROM lu_request WHERE request_id = @request_id
	ELSE
		SELECT @name = 'AIS_' + CAST(project_id AS VARCHAR) + '_R' FROM lu_request WHERE request_id = @request_id

	SET @batch = 'C:\AIS\Batch\delete_task.bat ' + @name
	EXEC master..xp_CMDShell @batch
END
