CREATE TABLE [dbo].[lu_server] (
    [server_id]      INT           NOT NULL,
    [server_name]    NVARCHAR (50) NOT NULL,
    [server_address] NVARCHAR (50) NOT NULL,
	[server_environment] NVARCHAR (10) NOT NULL,
    CONSTRAINT [PK_lu_database] PRIMARY KEY CLUSTERED ([server_id] ASC)
);

