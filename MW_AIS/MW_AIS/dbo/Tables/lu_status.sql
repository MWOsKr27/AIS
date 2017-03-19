CREATE TABLE [dbo].[lu_status] (
    [status_id]   INT           NOT NULL,
    [status_name] NVARCHAR (50) NULL,
    CONSTRAINT [PK_lu_status] PRIMARY KEY CLUSTERED ([status_id] ASC)
);

