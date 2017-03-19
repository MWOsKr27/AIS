CREATE TABLE [dbo].[lu_requester] (
    [requester_id]       INT           NOT NULL,
    [requester_name]     NVARCHAR (50) NULL,
    [requester_lastname] NVARCHAR (50) NULL,
    [requester_email]    NVARCHAR (50) NULL,
    CONSTRAINT [PK_lu_requester] PRIMARY KEY CLUSTERED ([requester_id] ASC)
);

