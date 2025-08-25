-- 1. Roles Table
CREATE TABLE Roles (
    RoleID INT PRIMARY KEY IDENTITY(1,1),
    RoleName NVARCHAR(50) NOT NULL
);

-- 2. Users Table
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Username NVARCHAR(50) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    FullName NVARCHAR(100),
    Email NVARCHAR(100),
    RoleID INT FOREIGN KEY REFERENCES Roles(RoleID)
);

-- 3. Courses Table
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY IDENTITY(1,1),
    CourseName NVARCHAR(100) NOT NULL,
    PrerequisiteID INT NULL,
    FacultyID INT NULL,
    FOREIGN KEY (PrerequisiteID) REFERENCES Courses(CourseID),
    FOREIGN KEY (FacultyID) REFERENCES Users(UserID)
);

-- 4. CourseRegistrations Table
CREATE TABLE CourseRegistrations (
    RegistrationID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT,
    CourseID INT,
    Semester NVARCHAR(20),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- 5. Assignments Table
CREATE TABLE Assignments (
    AssignmentID INT PRIMARY KEY IDENTITY(1,1),
    CourseID INT,
    Title NVARCHAR(100),
    Description NVARCHAR(MAX),
    DueDate DATETIME,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- 6. Submissions Table
CREATE TABLE Submissions (
    SubmissionID INT PRIMARY KEY IDENTITY(1,1),
    AssignmentID INT,
    UserID INT,
    FilePath NVARCHAR(255),
    SubmissionDate DATETIME,
    Grade NVARCHAR(10),
    FOREIGN KEY (AssignmentID) REFERENCES Assignments(AssignmentID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- 7. Announcements Table
CREATE TABLE Announcements (
    AnnouncementID INT PRIMARY KEY IDENTITY(1,1),
    CourseID INT,
    FacultyID INT,
    Message NVARCHAR(MAX),
    DatePosted DATETIME,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
    FOREIGN KEY (FacultyID) REFERENCES Users(UserID)
);

-- 8. Fees Table
CREATE TABLE Fees (
    FeeID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT,
    Amount DECIMAL(10,2),
    Status NVARCHAR(20),
    DueDate DATETIME,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);