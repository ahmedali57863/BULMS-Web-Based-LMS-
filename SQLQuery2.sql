-- Insert roles
INSERT INTO Roles (RoleName) VALUES ('Admin');
INSERT INTO Roles (RoleName) VALUES ('Faculty');
INSERT INTO Roles (RoleName) VALUES ('Student');

-- Insert test users (plain text passwords, since your code checks PasswordHash == txtPassword.Text)
INSERT INTO Users (Username, PasswordHash, FullName, Email, RoleID)
VALUES ('admin1', 'admin123', 'System Administrator', 'admin@example.com',
        (SELECT RoleID FROM Roles WHERE RoleName = 'Admin'));

INSERT INTO Users (Username, PasswordHash, FullName, Email, RoleID)
VALUES ('faculty1', 'faculty123', 'Prof. John Doe', 'faculty@example.com',
        (SELECT RoleID FROM Roles WHERE RoleName = 'Faculty'));

INSERT INTO Users (Username, PasswordHash, FullName, Email, RoleID)
VALUES ('student1', 'student123', 'Jane Student', 'student@example.com',
        (SELECT RoleID FROM Roles WHERE RoleName = 'Student'));
