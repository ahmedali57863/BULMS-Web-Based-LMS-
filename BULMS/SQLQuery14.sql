UPDATE Submissions
SET FilePath = REPLACE(FilePath, '/App_Data/Assignments/', '/Assignments/')
WHERE FilePath LIKE '%/App_Data/Assignments/%';