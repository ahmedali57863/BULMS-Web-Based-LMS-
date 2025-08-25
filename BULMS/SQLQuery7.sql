-- HAFSA QURESHI, no prereq
UPDATE Courses SET FacultyID = 4, PrerequisiteID = NULL WHERE CourseID = 1;

-- MADIHA JAVEED, prereq: DSA (CourseID 1)
UPDATE Courses SET FacultyID = 5, PrerequisiteID = 1 WHERE CourseID = 2;

-- USMAN SHAFIQUE, no prereq
UPDATE Courses SET FacultyID = 6, PrerequisiteID = NULL WHERE CourseID = 3;

-- MALIK UMAIR SAJJAD, prereq: Web Systems and Technologies (CourseID 3)
UPDATE Courses SET FacultyID = 7, PrerequisiteID = 3 WHERE CourseID = 4;

-- NOMAN AYAZ, no prereq
UPDATE Courses SET FacultyID = 8, PrerequisiteID = NULL WHERE CourseID = 5;

-- EJAZ AHMED MIAN, no prereq
UPDATE Courses SET FacultyID = 9, PrerequisiteID = NULL WHERE CourseID = 6;

-- MUHAMMAD ILYAS, no prereq
UPDATE Courses SET FacultyID = 10, PrerequisiteID = NULL WHERE CourseID = 7;

-- DR JAFAR HASNAIN, prereq: Multivariable Calculus (CourseID 7)
UPDATE Courses SET FacultyID = 11, PrerequisiteID = 7 WHERE CourseID = 8;