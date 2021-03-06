USE [interpreter_locator]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 12/2/2016 5:19:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Employee](
	[employee_ID] [int] IDENTITY(1,1) NOT NULL,
	[LastName] [varchar](255) NOT NULL,
	[UserName] [varchar](255) NOT NULL,
	[FirstName] [varchar](255) NOT NULL,
	[Employee_Type] [int] NOT NULL,
	[isOnline] [bit] NULL,
	[RoomID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[employee_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Employee_Type]    Script Date: 12/2/2016 5:19:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Employee_Type](
	[employeetype_ID] [int] IDENTITY(1,1) NOT NULL,
	[employeetype_name] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[employeetype_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Log]    Script Date: 12/2/2016 5:19:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Log](
	[LogId] [int] IDENTITY(1,1) NOT NULL,
	[OldRecord] [nvarchar](max) NULL,
	[NewRecord] [nvarchar](max) NULL,
	[ManagerID] [int] NULL,
	[OperationType] [nchar](10) NULL,
	[EmployeeName] [nvarchar](100) NULL,
 CONSTRAINT [PK_Log] PRIMARY KEY CLUSTERED 
(
	[LogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Map]    Script Date: 12/2/2016 5:19:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Map](
	[map_id] [int] IDENTITY(1,1) NOT NULL,
	[Source] [int] NULL,
	[destination] [int] NULL,
	[path] [varchar](223) NULL,
PRIMARY KEY CLUSTERED 
(
	[map_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Msg]    Script Date: 12/2/2016 5:19:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Msg](
	[message_id] [int] IDENTITY(1,1) NOT NULL,
	[time_stamp] [datetime] NOT NULL,
	[message_text] [varchar](223) NULL,
	[source_id] [int] NOT NULL,
	[destination_id] [int] NOT NULL,
	[done] [bit] NULL,
	[toReplyID] [int] NULL,
	[inService] [bit] NULL,
	[canceled] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[message_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Room]    Script Date: 12/2/2016 5:19:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Room](
	[room_id] [int] IDENTITY(1,1) NOT NULL,
	[room_num] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[room_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Shifts]    Script Date: 12/2/2016 5:19:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Shifts](
	[shift_id] [int] IDENTITY(1,1) NOT NULL,
	[shift_name] [varchar](223) NULL,
	[start_time] [datetime] NULL,
	[end_time] [datetime] NULL,
	[day_of_week] [varchar](23) NULL,
	[night] [bit] NOT NULL,
	[EmployeeID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[shift_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD FOREIGN KEY([Employee_Type])
REFERENCES [dbo].[Employee_Type] ([employeetype_ID])
GO
ALTER TABLE [dbo].[Msg]  WITH CHECK ADD FOREIGN KEY([destination_id])
REFERENCES [dbo].[Employee] ([employee_ID])
GO
ALTER TABLE [dbo].[Msg]  WITH CHECK ADD FOREIGN KEY([source_id])
REFERENCES [dbo].[Employee] ([employee_ID])
GO
/****** Object:  StoredProcedure [dbo].[Employee_Get_ByUserName]    Script Date: 12/2/2016 5:19:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Employee_Get_ByUserName]
	-- Add the parameters for the stored procedure here
	@userName VARCHAR(255) 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
[employee_ID]
,[UserName]
,[FirstName]
,[LastName]
,[Employee_Type]
	 from [dbo].[Employee] where 
	UserName = @userName;
END

GO
/****** Object:  StoredProcedure [dbo].[Employee_Get_Online_Interpreter]    Script Date: 12/2/2016 5:19:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Employee_Get_Online_Interpreter]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
[employee_ID]
,[UserName]
,[FirstName]
,[LastName]
,[Employee_Type]
,[RoomID]
	 from [dbo].[Employee] where 
	 isOnline = 1 
	 and Employee_Type =2;
	
END

GO
/****** Object:  StoredProcedure [dbo].[Employee_Update_status_Offline]    Script Date: 12/2/2016 5:19:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Employee_Update_status_Offline]
	-- Add the parameters for the stored procedure here
	@EmployeeID int

	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	update Employee set isOnline = null,RoomID = null
	where employee_ID = @EmployeeID;
END

GO
/****** Object:  StoredProcedure [dbo].[Employee_Update_status_Online]    Script Date: 12/2/2016 5:19:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Employee_Update_status_Online]
	-- Add the parameters for the stored procedure here
	@EmployeeID int,
	@RoomID int 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	update Employee set isOnline = 1,RoomID = @RoomID
	where employee_ID = @EmployeeID;
END

GO
/****** Object:  StoredProcedure [dbo].[Get_Map]    Script Date: 12/2/2016 5:19:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_Map]
	-- Add the parameters for the stored procedure here
	@src int,
	@des int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
select path from map
where (Source = @src OR Source = @des)
and (destination = @des OR destination = @src)

END

GO
/****** Object:  StoredProcedure [dbo].[Log_Insert]    Script Date: 12/2/2016 5:19:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Log_Insert]
	-- Add the parameters for the stored procedure here
	@oldRecord VARCHAR(max),
	@newRecord VARCHAR(max),
	 @operationType VARCHAR(30),
	@ManagerId int,
	@userName Varchar(50)
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


    -- Insert statements for procedure here
INSERT into [dbo].[Log]
([OldRecord],[NewRecord],[ManagerID],[OperationType],[EmployeeName])
values
(@oldRecord,@newRecord,@ManagerId ,@operationType,@userName)


--SELECT @@Identity;
END



GO
/****** Object:  StoredProcedure [dbo].[Map_get_all_map]    Script Date: 12/2/2016 5:19:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Map_get_all_map]
	-- Add the parameters for the stored procedure here
	 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   SELECT m.Map_id,m.Source,m.destination,m.path,r.room_num, r2.room_num
   from Map m join room r 
   on m.Source = r.room_id
    Join room r2 on 
   m.destination = r2.room_id;
END

GO
/****** Object:  StoredProcedure [dbo].[msg_cancel]    Script Date: 12/2/2016 5:19:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[msg_cancel]
	-- Add the parameters for the stored procedure here
	@messageid int

	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
Update [dbo].[Msg]
set [canceled] = 1
where [message_id] = @messageid;
END



GO
/****** Object:  StoredProcedure [dbo].[msg_cancel_check]    Script Date: 12/2/2016 5:19:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[msg_cancel_check]
	-- Add the parameters for the stored procedure here
	@messageid int

	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
if((select canceled from Msg
where message_id = @messageid) is not null )
select 1 as result
else
select 0 as result 

END



GO
/****** Object:  StoredProcedure [dbo].[msg_getMessage_for_me]    Script Date: 12/2/2016 5:19:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[msg_getMessage_for_me]
	-- Add the parameters for the stored procedure here
	@ID int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
[message_id]
,[time_stamp]
,[message_text]
,[source_id]
,[destination_id]
,[done]
,[toReplyID]
,e.FirstName
,e.LastName
,e.RoomID
,e.employee_ID
from [dbo].[Msg] m
JOIN [dbo].[Employee] e
on m.[source_id] = e.employee_ID
where destination_id = @ID
and done is   null
AND canceled is null
END

GO
/****** Object:  StoredProcedure [dbo].[msg_getReply_for_me]    Script Date: 12/2/2016 5:19:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[msg_getReply_for_me]
	-- Add the parameters for the stored procedure here
	@oldID int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select 
message_id,
time_stamp,
message_text,
source_id,
destination_id
,e.FirstName
,e.LastName
,e.RoomID
from [dbo].[Msg] m
JOIN [dbo].[Employee] e
on m.[source_id] = e.employee_ID
where done = 1
and toReplyID = @oldID
END

GO
/****** Object:  StoredProcedure [dbo].[Room_Get_All]    Script Date: 12/2/2016 5:19:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Room_Get_All]
	-- Add the parameters for the stored procedure here
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT room_id,room_num FROM [dbo].[Room]
END

GO
/****** Object:  StoredProcedure [dbo].[Send_Reply_to_PCE]    Script Date: 12/2/2016 5:19:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Send_Reply_to_PCE]
	-- Add the parameters for the stored procedure here
	@message VARCHAR(max),
	@timeStamp datetime,
	@sourceID int,
	@destinationID int,
	@OldMessageID int
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRANSACTION [Tran1]

BEGIN TRY

    -- Insert statements for procedure here
INSERT into [dbo].[Msg]
([time_stamp],[message_text],[source_id],[destination_id],[done],[toReplyID])
 values
(@timeStamp,@message,@sourceID,@destinationID,1,@OldMessageID)


update [dbo].[Msg]
set done = 1
where message_id = @OldMessageID;


select @@IDENTITY;
COMMIT TRANSACTION [Tran1]

END TRY
BEGIN CATCH
  ROLLBACK TRANSACTION [Tran1]
END CATCH  

END

GO
/****** Object:  StoredProcedure [dbo].[Sent_Message_to_Interpreter]    Script Date: 12/2/2016 5:19:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sent_Message_to_Interpreter]
	-- Add the parameters for the stored procedure here
	@message VARCHAR(max),
	@timeStamp datetime,
	@sourceID int,
	@destinationID int 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
INSERT into [dbo].[Msg]
([time_stamp],[message_text],[source_id],[destination_id])
values
(@timeStamp,@message,@sourceID,@destinationID)

SELECT @@Identity;
END



GO
/****** Object:  StoredProcedure [dbo].[Shift_Get_All]    Script Date: 12/2/2016 5:19:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Shift_Get_All]
	-- Add the parameters for the stored procedure here
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
select [shift_id]
,[shift_name]
,[start_time]
,[end_time]
,[day_of_week]
,[night]
,[FirstName]
,[LastName]
from [dbo].[Shifts] s
join employee e 
on s.EmployeeID = e.employee_ID


END

GO
/****** Object:  StoredProcedure [dbo].[Shift_Get_by_ID]    Script Date: 12/2/2016 5:19:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Shift_Get_by_ID]
	-- Add the parameters for the stored procedure here
	@employeeID int 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
select [shift_id]
,[shift_name]
,[start_time]
,[end_time]
,[day_of_week]
,[night]
,[FirstName]
,[LastName]
from [dbo].[Shifts] s
join employee e 
on s.EmployeeID = e.employee_ID
where s.EmployeeID = @employeeID

END

GO
/****** Object:  StoredProcedure [dbo].[Shift_Insert]    Script Date: 12/2/2016 5:19:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Shift_Insert]
	-- Add the parameters for the stored procedure here
	@ShiftName VARCHAR(223),
	@startTime datetime,
	@endTime datetime,
	@DayOfWeek varchar(23),
	@night bit,
	@userName varchar(20)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


    -- Insert statements for procedure here
INSERT into [dbo].[Shifts]
([shift_name],[start_time],[end_time],[day_of_week],[night]
,[EmployeeID])
values
(@ShiftName,@startTime,@endTime,@DayOfWeek,@night,

(Select [employee_ID]  from [dbo].[Employee]
where [UserName] = @userName))

--SELECT @@Identity;
END



GO
/****** Object:  StoredProcedure [dbo].[Shift_update_byShiftID]    Script Date: 12/2/2016 5:19:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[Shift_update_byShiftID]
	-- Add the parameters for the stored procedure here
	@ShiftID int,
	@ShiftName VARCHAR(223),
	@startTime datetime,
	@endTime datetime,
	@DayOfWeek varchar(23)
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


    -- Insert statements for procedure here
update [dbo].[Shifts] 
set shift_name = @ShiftName,
start_time = @startTime,
end_time = @endTime,
day_of_week  = @DayOfWeek
where [shift_id]= @ShiftID

--SELECT @@Identity;
END



GO
