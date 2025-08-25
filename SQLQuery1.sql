-- USERS TABLE
CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL UNIQUE,
    Password NVARCHAR(100) NOT NULL,
    UserType NVARCHAR(20) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    CreatedDate DATETIME DEFAULT GETDATE()
);

-- COURSES TABLE
CREATE TABLE Courses (
    CourseID INT IDENTITY(1,1) PRIMARY KEY,
    CourseCode NVARCHAR(20) NOT NULL UNIQUE,
    CourseName NVARCHAR(100) NOT NULL,
    Credits INT NOT NULL,
    Prerequisites NVARCHAR(MAX),
    Description NVARCHAR(MAX)
);

-- COURSE ENROLLMENTS TABLE
CREATE TABLE CourseEnrollments (
    EnrollmentID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT FOREIGN KEY REFERENCES Users(UserID),
    CourseID INT FOREIGN KEY REFERENCES Courses(CourseID),
    EnrollmentDate DATETIME DEFAULT GETDATE(),
    Status NVARCHAR(20) DEFAULT 'Active'
);

-- ASSIGNMENTS TABLE
CREATE TABLE Assignments (
    AssignmentID INT IDENTITY(1,1) PRIMARY KEY,
    CourseID INT FOREIGN KEY REFERENCES Courses(CourseID),
    Title NVARCHAR(100) NOT NULL,
    Description NVARCHAR(MAX),
    DueDate DATETIME NOT NULL,
    CreatedBy INT FOREIGN KEY REFERENCES Users(UserID),
    CreatedDate DATETIME DEFAULT GETDATE()
);

-- SUBMISSIONS TABLE
CREATE TABLE Submissions (
    SubmissionID INT IDENTITY(1,1) PRIMARY KEY,
    AssignmentID INT FOREIGN KEY REFERENCES Assignments(AssignmentID),
    UserID INT FOREIGN KEY REFERENCES Users(UserID),
    SubmissionDate DATETIME DEFAULT GETDATE(),
    Grade DECIMAL(5,2),
    Feedback NVARCHAR(MAX),
    Status NVARCHAR(20) DEFAULT 'Submitted'
);

-- ANNOUNCEMENTS TABLE
CREATE TABLE Announcements (
    AnnouncementID INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(100) NOT NULL,
    Content NVARCHAR(MAX) NOT NULL,
    CreatedBy INT FOREIGN KEY REFERENCES Users(UserID),
    CreatedDate DATETIME DEFAULT GETDATE(),
    IsActive BIT DEFAULT 1
);

-- INSERT DEFAULT USERS
INSERT INTO Users (Username, Password, UserType, Email, FirstName, LastName)
VALUES 
('admin', 'admin', 'Admin', 'admin@university.edu', 'Admin', 'User'),
('faculty', 'faculty', 'Faculty', 'faculty@university.edu', 'Faculty', 'User'),
('student', 'student', 'Student', 'student@university.edu', 'Student', 'User');