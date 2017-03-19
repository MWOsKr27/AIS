CREATE PROCEDURE [dbo].[add_requester]
	@requester_name NVARCHAR(50),
	@requester_lastname NVARCHAR(50),
	@requester_email NVARCHAR(50)
AS
BEGIN
	DECLARE @requester_id SMALLINT = (SELECT COUNT(1) FROM lu_requester) + 1

	INSERT INTO [dbo].[lu_requester] (requester_id, requester_name, requester_lastname, requester_email)
	VALUES (@requester_id, @requester_name, @requester_lastname, @requester_email)
END