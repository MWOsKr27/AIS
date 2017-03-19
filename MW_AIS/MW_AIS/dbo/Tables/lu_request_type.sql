CREATE TABLE [dbo].[lu_request_type] (
    [request_type_id] INT           NOT NULL,
    [request_type]    NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_lu_request_type] PRIMARY KEY CLUSTERED ([request_type_id] ASC)
);

