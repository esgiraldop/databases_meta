/*
# Creating the necessary tables to do the exercise
	
	CREATE DATABASE Lucky_Shrub;
    USE Lucky_Shrub;
    CREATE TABLE Products (ProductID VARCHAR(10), ProductName VARCHAR(100),BuyPrice DECIMAL(6,2), SellPrice DECIMAL(6,2), NumberOfItems INT);
    INSERT INTO Products (ProductID, ProductName, BuyPrice, SellPrice, NumberOfITems)
	VALUES ("P1", "Artificial grass bags ", 40, 50, 100),  
	("P2", "Wood panels", 15, 20, 250),  
	("P3", "Patio slates",35, 40, 60),  
	("P4", "Sycamore trees ", 7, 10, 50),  
	("P5", "Trees and Shrubs", 35, 50, 75),  
	("P6", "Water fountain", 65, 80, 15);
    CREATE TABLE Notifications (NotificationID INT AUTO_INCREMENT, Notification VARCHAR(255), DateTime TIMESTAMP NOT NULL, PRIMARY KEY(NotificationID));


# Task: 1. Creating a trigger that checks before inserting a new row if the SellPrice is less than BuyPrice.
#		If this occurs, then changes the SellPrice by the BuyPrice and inserts a notification
#		in another table.
        
	# Creating the trigger
	
    CREATE TRIGGER ProductSellPriceInsertCheck
	BEFORE INSERT ON Products
	FOR EACH ROW
	BEGIN
		DECLARE message VARCHAR(100);
		DECLARE crrntDate DATETIME;
		IF NEW.SellPrice < NEW.BuyPrice THEN
			SELECT CONCAT('A SellPrice less than the BuyPrice was inserted for ProductID ', NEW.ProductID) INTO message;
			SELECT NOW() INTO crrntDate;
			SET NEW.SellPrice = NEW.BuyPrice;
			INSERT INTO Notifications (Notification, DateTime) VALUES (message, crrntDate);
		END IF;
	END//
	DELIMITER ;
        
    # Testing the trigger
    SELECT * FROM Products;
	SELECT * FROM Notifications;
	INSERT INTO Products (ProductID, ProductName, BuyPrice, SellPrice, NumberOfItems) VALUES ('P7', 'test 1', 50, 48, 10);
	Select * FROM Products;
	Select * FROM Notifications;
    
    DROP TRIGGER IF EXISTS Lucky_Shrub.ProductSellPriceInsertCheck;
	
    
# Task: 2. Creating a trigger that checks before updating the SellPrice value. If it is less than BuyPrice,
#			then inserts a notification in another table.
        
	# Creating the trigger
        
	DELIMITER //
	CREATE TRIGGER ProductSellPriceUpdateCheck
	BEFORE UPDATE ON Products
	FOR EACH ROW
	BEGIN
		DECLARE message varchar(100);
		DECLARE currentTime DATE;
		IF NEW.SellPrice <=  OLD.BuyPrice THEN
			SET NEW.SellPrice =  OLD.BuyPrice;
			SET currentTime := NOW();
			SELECT CONCAT(NEW.ProductID,' was updated with a SellPrice of ', NEW.SellPrice,
			' which is the same or less than the BuyPrice of ', OLD.BuyPrice) INTO message;
			INSERT INTO Notifications (Notification, DateTime) VALUES (message, currentTime);
		END IF;
	END//
	DELIMITER ;
    
    # Testing the trigger
    SELECT * FROM Products;
	SELECT * FROM Notifications;
	UPDATE Products SET SellPrice = 60 WHERE ProductID = 'P6';
	SELECT * FROM Products;
	SELECT * FROM Notifications;
    
    DROP TRIGGER IF EXISTS Lucky_Shrub.ProductSellPriceUpdateCheck;*/
    
# Task 3. Creating a trigger that checks after deleting a record and inserts a message in the
		# Notifications table
	
    DELIMITER //
	CREATE TRIGGER NotifyProductDelete
    AFTER DELETE ON Products
    FOR EACH ROW
    BEGIN
		DECLARE message VARCHAR(100);
        DECLARE currntDate DATE;
        SET currntDate := NOW();
        SELECT CONCAT('The product with a ProductID ',OLD.ProductID, ' was deleted.') INTO message;
        INSERT INTO Notifications (Notification, DateTime) VALUES (message, currntDate);
    END//
    DELIMITER ;
    
    # Testing the trigger
    SELECT * FROM Products;
	SELECT * FROM Notifications;
    DELETE FROM Products WHERE ProductID = 'P6';
    SELECT * FROM Products;
	SELECT * FROM Notifications;
    
    DROP TRIGGER IF EXISTS Lucky_Shrub.NotifyProductDelete;