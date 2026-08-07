
USE SatelliteIDB;

CREATE TABLE IF NOT EXISTS User_Profile (
    User_ID       INT          PRIMARY KEY AUTO_INCREMENT,
    User_Name     VARCHAR(50)  NOT NULL UNIQUE,
    Email         VARCHAR(100) NOT NULL UNIQUE,
    Password      VARCHAR(255) NOT NULL,
    First_Name    VARCHAR(50)  NOT NULL,
    Last_Name     VARCHAR(50)  NOT NULL,
    Father_Name   VARCHAR(100) NOT NULL,
    Date_Of_Birth DATE         NOT NULL,
    Gender        CHAR(1)      DEFAULT NULL,
    CNIC          VARCHAR(15)  DEFAULT NULL UNIQUE,
    Phone_No      VARCHAR(15)  NOT NULL,
    Country       VARCHAR(100) NOT NULL,
    Full_Address  VARCHAR(255) DEFAULT NULL,
    Created_At    TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);

