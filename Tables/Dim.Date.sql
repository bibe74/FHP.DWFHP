CREATE TABLE [Dim].[Date]
(
[DateKey] [int] NOT NULL,
[Date] [date] NULL,
[Datetime] [datetime] NULL,
[DateNameIT] [char] (10) COLLATE Latin1_General_CI_AS NULL,
[Year] [int] NULL,
[YearNameIT] [char] (4) COLLATE Latin1_General_CI_AS NULL,
[Semester] [varchar] (2) COLLATE Latin1_General_CI_AS NOT NULL,
[SemesterYear] [varchar] (6) COLLATE Latin1_General_CI_AS NULL,
[SemesterYearNameIT] [varchar] (7) COLLATE Latin1_General_CI_AS NULL,
[Quarter] [char] (1) COLLATE Latin1_General_CI_AS NULL,
[QuarterYear] [varchar] (6) COLLATE Latin1_General_CI_AS NULL,
[QuarterYearNameIT] [varchar] (7) COLLATE Latin1_General_CI_AS NULL,
[Month] [int] NULL,
[MonthNameIT] [varchar] (9) COLLATE Latin1_General_CI_AS NULL,
[MonthYear] [int] NULL,
[MonthYearNameIT] [varchar] (14) COLLATE Latin1_General_CI_AS NULL,
[DayOfMonth] [varchar] (2) COLLATE Latin1_General_CI_AS NULL,
[DayOfWeek] [char] (1) COLLATE Latin1_General_CI_AS NULL,
[DayOfWeekNameIT] [varchar] (9) COLLATE Latin1_General_CI_AS NULL,
[MonthIsClosed] [bit] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Dim].[Date] ADD CONSTRAINT [PK_Dim_Date] PRIMARY KEY CLUSTERED  ([DateKey]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Dim_Date_Date] ON [Dim].[Date] ([Date]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Dim_Date_Datetime] ON [Dim].[Date] ([Datetime]) ON [PRIMARY]
GO
