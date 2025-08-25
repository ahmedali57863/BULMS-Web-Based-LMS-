-- If Users table already exists, drop it
IF OBJECT_ID('dbo.Users', 'U') IS NOT NULL
    DROP TABLE dbo.Users;
GO

-- Create Users table with columns your code expects
CREATE TABLE dbo.Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    FullName NVARCHAR(100) NULL,
    Email NVARCHAR(100) NULL,
    RoleID NVARCHAR(20) NOT NULL
);
GO

-- Insert demo users
INSERT INTO dbo.Users (Username, PasswordHash, FullName, Email, RoleID)
VALUES 
('admin', 'admin123', 'System Admin', 'admin@bulms.com', 'Admin'),
('faculty1', 'faculty123', 'Dr. Smith', 'smith@bulms.com', 'Faculty'),
('student1', 'student123', 'Alice Student', 'alice@bulms.com', 'Student');
