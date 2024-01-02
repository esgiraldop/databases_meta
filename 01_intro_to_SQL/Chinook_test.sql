CREATE DATABASE Chinook_test;

USE Chinook_test;

CREATE TABLE Employee (
	Employee INT NOT NULL, LastName VARCHAR(20), FirstName VARCHAR(20), Title VARCHAR(30), ReportsTo INT, BirthDateDATE DATE, HireDate DATE,
	address VARCHAR(70), PRIMARY KEY(Employee)
);

CREATE TABLE Customers (
	CustomerID INT NOT NULL, LastName VARCHAR(20), FirstName VARCHAR(20), Company VARCHAR(30), Phone VARCHAR(20), Email VARCHAR(100),
    SuportRepID INT NOT NULL, address VARCHAR(70), PRIMARY KEY(CustomerID), FOREIGN KEY(SuportRepID) REFERENCES employee(Employee)
);

CREATE TABLE Location (
	LocID INT NOT NULL, Location VARCHAR(120), PRIMARY KEY(LocID)
);
/* From now on, I have to create the rest of the tables and then update the references, or the script will not run*/

CREATE TABLE Invoices (
	InvoiceID INT NOT NULL, CustomerID INT NOT NULL, InvoiceDate DATE, BillingAddress VARCHAR(100),
    PRIMARY KEY (InvoiceID), FOREIGN KEY (CustomerID) REFERENCES customers(CustomerID)
);

CREATE TABLE Tracks (
	TrackID INT NOT NULL, Name VARCHAR(200), UnitPrice DECIMAL, PRIMARY KEY(TrackID)
);

CREATE TABLE Albums (
	AlbumID INT NOT NULL, Title VARCHAR(160), PRIMARY KEY (AlbumID)
);

CREATE TABLE Artists (
	ArtistID INT NOT NULL, Name VARCHAR(120), LocID INT NOT NULL, PRIMARY KEY(ArtistID), FOREIGN KEY (LocID) REFERENCES Location(LocID)
);

/* Adding the foreign keys I could not add when creating the tables as the parent tables of those foreign keys did not exist */
ALTER TABLE Invoices ADD (
	TrackID INT NOT NULL, FOREIGN KEY (TrackID) REFERENCES Tracks(TrackID)
);

ALTER TABLE Tracks ADD (
	AlbumID INT NOT NULL, FOREIGN KEY (AlbumID) REFERENCES Albums(AlbumID)
);

ALTER TABLE Albums ADD (
	ArtistID INT NOT NULL, FOREIGN KEY (ArtistID) REFERENCES Artists(ArtistID)
);

USE Chinook_test;
SHOW tables;