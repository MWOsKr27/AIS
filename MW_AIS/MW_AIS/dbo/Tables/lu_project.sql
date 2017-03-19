CREATE TABLE [dbo].[lu_project] (
    [project_id]   INT           NOT NULL,
    [project_name] NVARCHAR (50) NULL,
    CONSTRAINT [PK_lu_projects] PRIMARY KEY CLUSTERED ([project_id] ASC)
);

