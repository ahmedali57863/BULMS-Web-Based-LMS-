INSERT INTO CourseRegistrations (UserID, CourseID, Semester)
SELECT 1, CourseID, 'Spring-2025'
FROM Courses
WHERE CourseID NOT IN (
    SELECT CourseID FROM CourseRegistrations WHERE UserID = 1
);