ALTER ROLE [db_owner] ADD MEMBER [mstrautomation];


GO
ALTER ROLE [db_owner] ADD MEMBER [EDIFICEPROD\MRosas];


GO
ALTER ROLE [db_accessadmin] ADD MEMBER [EDIFICEPROD\MRosas];


GO
ALTER ROLE [db_securityadmin] ADD MEMBER [mstrautomation];


GO
ALTER ROLE [db_securityadmin] ADD MEMBER [EDIFICEPROD\MRosas];


GO
ALTER ROLE [db_ddladmin] ADD MEMBER [mstrautomation];


GO
ALTER ROLE [db_ddladmin] ADD MEMBER [EDIFICEPROD\MRosas];


GO
ALTER ROLE [db_backupoperator] ADD MEMBER [EDIFICEPROD\MRosas];


GO
ALTER ROLE [db_datareader] ADD MEMBER [mstrautomation];


GO
ALTER ROLE [db_datareader] ADD MEMBER [EDIFICEPROD\MRosas];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [mstrautomation];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [EDIFICEPROD\MRosas];


GO
ALTER ROLE [db_denydatareader] ADD MEMBER [EDIFICEPROD\MRosas];


GO
ALTER ROLE [db_denydatawriter] ADD MEMBER [EDIFICEPROD\MRosas];

