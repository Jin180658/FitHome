
CREATE TABLE [dbo].[Users] (
    [UserID]     INT            IDENTITY (1, 1) NOT NULL,
    [Username]   NVARCHAR (50)  NOT NULL,
    [Password]   NVARCHAR (50)  NOT NULL,
    [Email]      NVARCHAR (100) NOT NULL,
    [Weight]     DECIMAL (5, 2) NULL,
    [Height]     DECIMAL (5, 2) NULL,
    [ProfilePic] NVARCHAR (255) NULL,
    PRIMARY KEY CLUSTERED ([UserID] ASC)
);

CREATE TABLE [dbo].[Courses] (
    [CourseID]    INT            IDENTITY (1, 1) NOT NULL,
    [Title]       NVARCHAR (100) NOT NULL,
    [Description] NVARCHAR (MAX) NULL,
    [VideoLink]   NVARCHAR (255) NOT NULL,
    [Category]    NVARCHAR (50)  NOT NULL,
    [Thumbnail]   NVARCHAR (255) NULL,
    PRIMARY KEY CLUSTERED ([CourseID] ASC)
);

CREATE TABLE [dbo].[Admins] (
    [AdminID]  INT           IDENTITY (1, 1) NOT NULL,
    [Name]     NVARCHAR (50) NOT NULL,
    [Password] NVARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([AdminID] ASC)
);


CREATE TABLE [dbo].[UserProgress] (
    [ProgressID]    INT      IDENTITY (1, 1) NOT NULL,
    [UserID]        INT      NOT NULL,
    [CourseID]      INT      NOT NULL,
    [DateCompleted] DATETIME NOT NULL,
    PRIMARY KEY CLUSTERED ([ProgressID] ASC),
    CONSTRAINT [FK_UserProgress_Courses] FOREIGN KEY ([CourseID]) REFERENCES [dbo].[Courses] ([CourseID]),
    CONSTRAINT [FK_UserProgress_Users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([UserID])
);

CREATE TABLE [dbo].[QuizResults] (
    [ResultID]       INT      IDENTITY (1, 1) NOT NULL,
    [UserID]         INT      NOT NULL,
    [CourseID]       INT      NOT NULL,
    [Score]          INT      NOT NULL,
    [TotalQuestions] INT      NOT NULL,
    [AttemptDate]    DATETIME DEFAULT (getdate()) NULL,
    [ProgressID]     INT      NULL,
    PRIMARY KEY CLUSTERED ([ResultID] ASC),
    CONSTRAINT [FK_QuizResults_Users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([UserID]),
    CONSTRAINT [FK_QuizResults_Courses] FOREIGN KEY ([CourseID]) REFERENCES [dbo].[Courses] ([CourseID])
);

CREATE TABLE [dbo].[QuizQuestions] (
    [QuestionID]    INT            IDENTITY (1, 1) NOT NULL,
    [CourseID]      INT            NOT NULL,
    [QuestionText]  NVARCHAR (MAX) NOT NULL,
    [OptionA]       NVARCHAR (255) NOT NULL,
    [OptionB]       NVARCHAR (255) NOT NULL,
    [OptionC]       NVARCHAR (255) NOT NULL,
    [OptionD]       NVARCHAR (255) NOT NULL,
    [CorrectAnswer] CHAR (1)       NOT NULL,
    PRIMARY KEY CLUSTERED ([QuestionID] ASC),
    CONSTRAINT [FK_QuizQuestions_Courses] FOREIGN KEY ([CourseID]) REFERENCES [dbo].[Courses] ([CourseID])
);

CREATE TABLE [dbo].[Favorites] (
    [FavID]     INT           IDENTITY (1, 1) NOT NULL,
    [UserID]    INT           NOT NULL,
    [CourseID]  INT           NOT NULL,
    [DateAdded] DATETIME2 (7) NOT NULL,
    PRIMARY KEY CLUSTERED ([FavID] ASC),
    CONSTRAINT [FK_Favorites_Courses] FOREIGN KEY ([CourseID]) REFERENCES [dbo].[Courses] ([CourseID]),
    CONSTRAINT [FK_Favorites_Users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([UserID])
);


CREATE TABLE [dbo].[ForumTopics] (
    [TopicID]   INT            IDENTITY (1, 1) NOT NULL,
    [UserID]    INT            NOT NULL,
    [Title]     NVARCHAR (255) NOT NULL,
    [Content]   NVARCHAR (MAX) NOT NULL,
    [CreatedAt] DATETIME       DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([TopicID] ASC),
    CONSTRAINT [FK_ForumTopics_Users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([UserID])
);

CREATE TABLE [dbo].[ForumReplies] (
    [ReplyID]      INT            IDENTITY (1, 1) NOT NULL,
    [TopicID]      INT            NOT NULL,
    [UserID]       INT            NOT NULL,
    [ReplyContent] NVARCHAR (MAX) NOT NULL,
    [CreatedAt]    DATETIME       DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([ReplyID] ASC),
    CONSTRAINT [FK_ForumReplies_Topics] FOREIGN KEY ([TopicID]) REFERENCES [dbo].[ForumTopics] ([TopicID]),
    CONSTRAINT [FK_ForumReplies_Users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([UserID])
);