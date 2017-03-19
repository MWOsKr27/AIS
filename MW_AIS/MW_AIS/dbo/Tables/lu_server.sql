CREATE TABLE [dbo].[lu_server] (
    [server_id]      INT           NOT NULL,
    [server_name]    NVARCHAR (50) NULL,
    [server_address] NVARCHAR (50) NULL,
    CONSTRAINT [PK_lu_database] PRIMARY KEY CLUSTERED ([server_id] ASC)
);

