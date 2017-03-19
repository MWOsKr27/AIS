CREATE TABLE [dbo].[lu_retailer] (
    [retailer_id]   INT            NOT NULL,
    [retailer_name] NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_lu_retailer] PRIMARY KEY CLUSTERED ([retailer_id] ASC)
);

