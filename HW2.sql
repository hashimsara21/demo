DROP TABLE Major_Student_Linking;
DROP TABLE Student_Address_Linking;
DROP TABLE Enrollment;
DROP TABLE Section;
DROP TABLE Major;
DROP TABLE Student;
DROP TABLE Address;
DROP TABLE Course;
DROP TABLE Teacher;
DROP TABLE Room;


CREATE TABLE Major
(
    Major_ID                NUMBER          NOT NULL,
    Major_Code              CHAR(3)         NOT NULL    UNIQUE,
    Major_Description       VARCHAR(50)     NOT NULL,
    CONSTRAINT Major_PK PRIMARY KEY (Major_ID)
);

CREATE TABLE Student
(
    UTEID                   NUMBER          NOT NULL,
    First_Name              VARCHAR(20)     NOT NULL,
    Middle_Name             VARCHAR(20),
    Last_Name               VARCHAR(40)     NOT NULL,
    Date_of_Birth           DATE            NOT NULL,            
    Classification_         CHAR(1)         NOT NULL
                            CHECK (Classification_ IN ('1', '2', '3', '4', 'G', 'P', 'C')),
    Email                   VARCHAR(10)     NOT NULL    UNIQUE,
    Phone                   CHAR(12)        NOT NULL,
    Primary_College_Code    CHAR(1)         NOT NULL,
    International_Flag      CHAR(1)         NOT NULL
                            CHECK (International_Flag IN ('Y', 'N')),
    cGPA                    NUMBER,
    CONSTRAINT Student_PK PRIMARY KEY (UTEID),
    CONSTRAINT Email_Length_Check CHECK (Email >=7)
);
 
CREATE TABLE Major_Student_Linking
(
    UTEID                   NUMBER          NOT NULL,
    Major_ID                NUMBER          NOT NULL,
    Date_Declared           DATE            DEFAULT SYSDATE,
    CONSTRAINT Major_Student_PK PRIMARY KEY (UTEID, Major_ID),
    CONSTRAINT UTEID_FK FOREIGN KEY (UTEID) REFERENCES Student (UTEID),
    CONSTRAINT Major_ID_FK FOREIGN KEY (Major_ID) REFERENCES Major (Major_ID)
);

CREATE TABLE Address
(
    Address_ID              NUMBER          NOT NULL,
    Address_Line_1          VARCHAR(40)     NOT NULL,
    Address_Line_2          VARCHAR(40),
    City                    VARCHAR(20)     NOT NULL,
    State_Region            CHAR(2)         NOT NULL,
    Zip_Postal_Code         CHAR(5)         NOT NULL,
    Country                 VARCHAR(20)     NOT NULL,
    CONSTRAINT Address_PK PRIMARY KEY (Address_ID)
);

CREATE TABLE Student_Address_Linking
(
    UTEID                   NUMBER          NOT NULL,
    Address_ID              NUMBER          NOT NULL,
    Address_Type_Code       CHAR(1)         NOT NULL
                            CHECK (Address_Type_Code IN ('H', 'L', 'O')),
    CONSTRAINT Student_Address_Linking_PK PRIMARY KEY (UTEID, Address_ID, Address_Type_Code),
    CONSTRAINT UTEID_FK2 FOREIGN KEY (UTEID) REFERENCES Student (UTEID),
    CONSTRAINT Address_ID_FK FOREIGN KEY (Address_ID) REFERENCES Address (Address_ID)
);

CREATE TABLE Course
(
    Course_ID               NUMBER          NOT NULL,
    Course_Code             VARCHAR(10)     NOT NULL,
    Course_Name             VARCHAR(30)     NOT NULL,
    Course_Description      VARCHAR(40)     NOT NULL,
    CONSTRAINT Course_PK PRIMARY KEY (Course_ID)
);

CREATE TABLE Teacher
(
    Instructor_UTEID        NUMBER,
    First_Name              VARCHAR(20)     NOT NULL,
    Last_Name               VARCHAR(40)     NOT NULL,
    Primary_Dept            VARCHAR(20)     NOT NULL,
    Primary_Title           VARCHAR(20),
    Email                   VARCHAR(10)     NOT NULL    UNIQUE,
    Office_Phone            CHAR(12)        NOT NULL,
    Office_Location         VARCHAR(40)     NOT NULL,
    Office_Address_1        VARCHAR(40)     NOT NULL,
    Office_Address_2        VARCHAR(40)     NOT NULL,
    Office_City             VARCHAR(20)     NOT NULL,
    Office_State            CHAR(2)         NOT NULL,
    Office_Zip              CHAR(5)         NOT NULL,
    Campus_Mail_Code        CHAR(5)         NOT NULL,
    CONSTRAINT Teacher_PK PRIMARY KEY (Instructor_UTEID)
);

CREATE TABLE Room
(
    Room_ID                 NUMBER,
    Building_Code           CHAR(3)         NOT NULL,
    Floor                   VARCHAR(2)      NOT NULL,
    Room_Number             VARCHAR(5)      NOT NULL,
    Max_Seats               VARCHAR(10)     NOT NULL,
    CONSTRAINT Room_PK PRIMARY KEY (Room_ID)
);

CREATE TABLE Section
(
    Section_ID              NUMBER          NOT NULL,
    Course_ID               NUMBER          NOT NULL, 
    Instructor_UTEID        NUMBER,
    Room_ID                 NUMBER,
    Unique_Number           NUMBER          NOT NULL,
    Semester_Code           CHAR(4)         NOT NULL,
    Section_Days            VARCHAR(10),
    Starting_Hour           VARCHAR(5),
    Length_Minutes          VARCHAR(10),
    Mode_                   CHAR(1)         NOT NULL,
    Seat_Limit              VARCHAR(10)     NOT NULL,
    Status                  CHAR(1)         DEFAULT 'O'
                            CHECK (Status IN ('O', 'W', 'C', 'X')),
    CONSTRAINT Section_PK PRIMARY KEY (Section_ID),
    CONSTRAINT Course_ID_FK FOREIGN KEY (Course_ID) REFERENCES Course (Course_ID),
    CONSTRAINT Instructor_UTEID_FK FOREIGN KEY (Instructor_UTEID) REFERENCES Teacher (Instructor_UTEID),
    CONSTRAINT Room_ID_FK FOREIGN KEY (Room_ID) REFERENCES Room (Room_ID)
);

CREATE TABLE Enrollment
(
    UTEID                   NUMBER          NOT NULL,
    Section_ID              NUMBER          NOT NULL,
    Grade_Code              VARCHAR(2)
                            CHECK (Grade_Code IN ('A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D+', 'D', 'D-', 'F', 'P', 'W', 'Q', 'X')),
    CONSTRAINT Enrollment_PK PRIMARY KEY (UTEID, Section_ID),
    CONSTRAINT UTEID_FK3 FOREIGN KEY (UTEID) REFERENCES Student (UTEID),
    CONSTRAINT Section_ID_FK FOREIGN KEY (Section_ID) REFERENCES Section (Section_ID)
);

INSERT INTO Student
VALUES ('fd4548', 'Fizza', 'Dhanani', '11-DEC-00', '4', 'fd4548@utexas.edu', '832-282-3295', 'B', 'N', '3.96');

INSERT INTO Student
VALUES ('sm1234', 'Sarah', 'Manjee', '23-JUN-01', '4', 'sm1234@utexas.edu', '512-111-2222', 'C', 'N', '4.00');

COMMIT;

INSERT INTO Major
VALUES ('123', 'BIO', 'Biology');

INSERT INTO Major
VALUES ('456', 'BUS', 'Business');

INSERT INTO Major
VALUES ('789', 'MEC', 'Mechanical Engineering');

COMMIT;

INSERT INTO Major_Student_Linking
VALUES ('fd4548', '123');

INSERT INTO Major_Student_Linking
VALUES ('sm1234', '456' AND '789);

