CREATE TABLE [dbo].[lu_step] (
    [step_id]          INT           NOT NULL,
    [step_description] NVARCHAR (50) NOT NULL,
    [step_project_type] NCHAR(10) NOT NULL, 
    CONSTRAINT [PK_lu_step] PRIMARY KEY CLUSTERED ([step_id] ASC)
);

