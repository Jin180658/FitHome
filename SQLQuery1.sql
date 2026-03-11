
CREATE TABLE QuizQuestions (
    QuestionID INT IDENTITY(1,1) PRIMARY KEY,
    CourseID INT NOT NULL FOREIGN KEY REFERENCES Courses(CourseID), 
    QuestionText NVARCHAR(MAX) NOT NULL,                            
    OptionA NVARCHAR(255) NOT NULL,                                 
    OptionB NVARCHAR(255) NOT NULL,                                 
    OptionC NVARCHAR(255) NOT NULL,                                 
    OptionD NVARCHAR(255) NOT NULL,                                 
    CorrectAnswer CHAR(1) NOT NULL                                 
);


CREATE TABLE QuizResults (
    ResultID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL FOREIGN KEY REFERENCES Users(UserID),       
    CourseID INT NOT NULL FOREIGN KEY REFERENCES Courses(CourseID), 
    Score INT NOT NULL,                                             
    TotalQuestions INT NOT NULL,                                    
    AttemptDate DATETIME DEFAULT GETDATE()                          
);