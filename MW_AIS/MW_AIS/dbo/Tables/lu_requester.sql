﻿CREATE TABLE [dbo].[lu_requester] (
    [requester_id]       INT           NOT NULL,
    [requester_name]     NVARCHAR (50) NOT NULL,
    [requester_lastname] NVARCHAR (50) NOT NULL,
    [requester_email]    NVARCHAR (50) NOT NULL,
	[requester_active] BIT DEFAULT(1) NOT NULL,
    CONSTRAINT [PK_lu_requester] PRIMARY KEY CLUSTERED ([requester_id] ASC)
);

