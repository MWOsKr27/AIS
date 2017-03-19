CREATE PROCEDURE [dbo].[add_server]
	@server_name NVARCHAR(50),
	@server_address NVARCHAR(50)
AS
BEGIN
	DECLARE @server_id SMALLINT = (SELECT COUNT(1) FROM lu_server) + 1

	INSERT INTO lu_server (server_id, server_name, server_address)
	VALUES (@server_id, @server_name, @server_address)
END