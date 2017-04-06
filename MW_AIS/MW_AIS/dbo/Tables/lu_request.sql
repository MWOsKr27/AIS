CREATE TABLE [dbo].[lu_request] (
    [request_id]        NVARCHAR (25)  NOT NULL,
    [project_id]        INT            NOT NULL,
    [server_id]         INT            NULL,
    [requester_id]      INT            NOT NULL,
    [status_id]         INT            NOT NULL,
    [supplier_calendar] INT            NULL,
    [item_account]      INT            NULL,
    [start_timestamp]   DATETIME       NULL,
    [retailer_string]   NVARCHAR (MAX) NOT NULL,
    [step_id]           INT            NOT NULL,
    [wh_name]           NVARCHAR (MAX) NULL,
    [end_timestamp]     DATETIME       NULL,
    [request_type_id]   INT            NOT NULL,
    [flag]              INT DEFAULT(0) NOT NULL,
    CONSTRAINT [PK_lu_request] PRIMARY KEY CLUSTERED ([request_id] ASC),
    CONSTRAINT [FK_lu_request_lu_project] FOREIGN KEY ([project_id]) REFERENCES [dbo].[lu_project] ([project_id]),
    CONSTRAINT [FK_lu_request_lu_request_type] FOREIGN KEY ([request_type_id]) REFERENCES [dbo].[lu_request_type] ([request_type_id]),
    CONSTRAINT [FK_lu_request_lu_requester] FOREIGN KEY ([requester_id]) REFERENCES [dbo].[lu_requester] ([requester_id]),
    CONSTRAINT [FK_lu_request_lu_server] FOREIGN KEY ([server_id]) REFERENCES [dbo].[lu_server] ([server_id]),
    CONSTRAINT [FK_lu_request_lu_status] FOREIGN KEY ([status_id]) REFERENCES [dbo].[lu_status] ([status_id]),
    CONSTRAINT [FK_lu_request_lu_step] FOREIGN KEY ([step_id]) REFERENCES [dbo].[lu_step] ([step_id])
);


GO
CREATE TRIGGER et_ai_LU_REQUEST ON dbo.lu_request AFTER INSERT AS
BEGIN
	DECLARE @count INT = (SELECT COUNT(1) FROM lu_request WHERE status_id = 1)

	IF @count = 0
	BEGIN
		EXEC start_next
	END
END;

GO
CREATE TRIGGER [dbo].[et_au_LU_REQUEST] ON [dbo].[lu_request] AFTER UPDATE AS
BEGIN
	DECLARE @count INT = (SELECT COUNT(1) FROM lu_request WHERE status_id = 1)
	DECLARE @step_id INT = (SELECT TOP 1 step_id FROM lu_request WHERE status_id = 1 ORDER BY start_timestamp)
	DECLARE @request_id NVARCHAR(25) = (SELECT TOP 1 request_id FROM lu_request WHERE status_id = 1 ORDER BY start_timestamp)

	IF @count = 1
		IF (@step_id = 1 OR @step_id = 9 OR @step_id = 13)
		BEGIN
			EXEC set_parameters @request_id
			EXEC schedule_task @request_id
		END
		ELSE IF @step_id = 2
			EXEC schedule_task @request_id
		ELSE IF @step_id = 4
			EXEC schedule_task @request_id
		ELSE IF @step_id = 7
			EXEC schedule_task @request_id
		ELSE IF @step_id = 8
			EXEC schedule_task @request_id
		ELSE IF @step_id = 10
			EXEC schedule_task @request_id
END;