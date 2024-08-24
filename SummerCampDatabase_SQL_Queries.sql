
CREATE TABLE Campers (
    CamperID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    MiddleName VARCHAR(50),
    DateOfBirth DATE,
    Email VARCHAR(100),
    Gender VARCHAR(10),
    PersonalPhone VARCHAR(15)
);

CREATE TABLE Camps (
    CampID INT AUTO_INCREMENT PRIMARY KEY,
    CampTitle VARCHAR(100),
    StartDate DATE,
    EndDate DATE,
    Price DECIMAL(10, 2),
    Capacity INT
);

CREATE TABLE CampAttendance (
    AttendanceID INT AUTO_INCREMENT PRIMARY KEY,
    CamperID INT,
    CampID INT,
    VisitDate DATE,
    FOREIGN KEY (CamperID) REFERENCES Campers(CamperID),
    FOREIGN KEY (CampID) REFERENCES Camps(CampID)
);

INSERT INTO Campers (FirstName, LastName, MiddleName, DateOfBirth, Email, Gender, PersonalPhone)
SELECT
    LEFT(MD5(RAND()), 5) AS FirstName,
    LEFT(MD5(RAND()), 5) AS LastName,
    LEFT(MD5(RAND()), 5) AS MiddleName,
    DATE_ADD('2005-01-01', INTERVAL RAND() * 7000 DAY) AS DateOfBirth,
    CONCAT(LEFT(MD5(RAND()), 5), '@example.com') AS Email,
    CASE
        WHEN RAND() <= 0.65 THEN 'Female'
        ELSE 'Male'
    END AS Gender,
    CONCAT('555-', FLOOR(1000000 + RAND() * 9000000)) AS PersonalPhone
FROM
    (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS LIMIT 5000) as tmp;

SELECT
    CASE
        WHEN DateOfBirth BETWEEN '1965-01-01' AND '1980-12-31' THEN 'Gen X'
        WHEN DateOfBirth BETWEEN '1981-01-01' AND '1996-12-31' THEN 'Millennials'
        WHEN DateOfBirth BETWEEN '1997-01-01' AND '2012-12-31' THEN 'Gen Z'
        ELSE 'Gen Alpha'
    END AS Generation,
    Gender,
    COUNT(*) AS Count
FROM
    Campers
GROUP BY
    Generation, Gender;
