-- 确保在正确的数据库下运行，请把 [YourDatabaseName] 换成你的数据库名字
-- USE [YourDatabaseName];
-- GO

-- 1. 插入 Users
SET IDENTITY_INSERT [dbo].[Users] ON;
INSERT INTO [dbo].[Users] ([UserID], [Username], [Password], [Email], [Weight], [Height], [ProfilePic]) VALUES 
(3, N'jin', N'123', N'jin123@gmail.com', 75.00, 171.00, N'user_3_639088770507648840.jpg'),
(5, N'jay', N'123', N'jay123@gmmail.com', 60.00, 170.00, NULL),
(7, N'jinyit', N'123', N'jinyit123', 60.00, 170.00, NULL),
(10, N'mark', N'123', N'mark123@gmail.com', 75.00, 180.00, NULL);
SET IDENTITY_INSERT [dbo].[Users] OFF;
GO

-- 2. 插入 Admins
SET IDENTITY_INSERT [dbo].[Admins] ON;
INSERT INTO [dbo].[Admins] ([AdminID], [Name], [Password]) VALUES 
(1, N'admin', N'123'),
(2, N'admin_jin', N'123');
SET IDENTITY_INSERT [dbo].[Admins] OFF;
GO

-- 3. 插入 Courses
SET IDENTITY_INSERT [dbo].[Courses] ON;
INSERT INTO [dbo].[Courses] ([CourseID], [Title], [Description], [VideoLink], [Category], [Thumbnail]) VALUES 
(3, N'Morning Yoga', N'Yoga Description', N'link3', N'Yoga', NULL),
(4, N'HIIT Training', N'HIIT Description', N'link4', N'Fitness', NULL);
SET IDENTITY_INSERT [dbo].[Courses] OFF;
GO

-- 4. 插入其他依赖数据
SET IDENTITY_INSERT [dbo].[QuizQuestions] ON;
INSERT INTO [dbo].[QuizQuestions] ([QuestionID], [CourseID], [QuestionText], [OptionA], [OptionB], [OptionC], [OptionD], [CorrectAnswer]) VALUES 
(1, 4, N'What is the best time for Morning Yoga?', N'Morning', N'Mid night', N'Afternoon', N'Night', N'A'),
(2, 3, N'Best time for morning yoga?', N'Morning', N'Mid night', N'Afternoon', N'Night', N'A'),
(3, 4, N'What does the acronym "HIIT" stand for in fitness?', N'High-Intensity Interval Training', N'Heavy-Impact Intensive Training', N'High-Impact Interval Therapy', N'Heart-Increasing Intense Training', N'A');
SET IDENTITY_INSERT [dbo].[QuizQuestions] OFF;
GO

SET IDENTITY_INSERT [dbo].[UserProgress] ON;
INSERT INTO [dbo].[UserProgress] ([ProgressID], [UserID], [CourseID], [DateCompleted]) VALUES 
(1, 3, 4, '2026-03-12 02:14:02'),
(2, 3, 4, '2026-03-12 02:14:46');
SET IDENTITY_INSERT [dbo].[UserProgress] OFF;
GO

SET IDENTITY_INSERT [dbo].[QuizResults] ON;
INSERT INTO [dbo].[QuizResults] ([ResultID], [UserID], [CourseID], [Score], [TotalQuestions], [AttemptDate], [ProgressID]) VALUES 
(1, 3, 4, 2, 2, '2026-03-12 02:35:38', 2);
SET IDENTITY_INSERT [dbo].[QuizResults] OFF;
GO

SET IDENTITY_INSERT [dbo].[Favorites] ON;
INSERT INTO [dbo].[Favorites] ([FavID], [UserID], [CourseID], [DateAdded]) VALUES 
(2, 3, 3, '2026-03-11 11:24:58'),
(3, 3, 4, '2026-03-11 11:25:38');
SET IDENTITY_INSERT [dbo].[Favorites] OFF;
GO