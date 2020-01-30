CREATE TABLE security_question(
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Question VARCHAR(100)
);

CREATE TABLE user (
    Username VARCHAR(30) PRIMARY KEY,
    Password VARCHAR(30) CHECK ( Password RLIKE '.*[0-9].*' AND Password RLIKE '.*[A-z].*' AND CHAR_LENGTH(Password) >= 8),
    SecurityQuestion INT,
    SecurityAnswer VARCHAR(40),
    Role VARCHAR(10) CHECK ( Role IN ('Restaurant', 'Driver', 'Charity', 'Admin')),
    FOREIGN KEY (SecurityQuestion) REFERENCES security_question(ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE restaurant(
    ID VARCHAR(30) PRIMARY KEY,
    Name VARCHAR(30),
    City VARCHAR(30),
    Region VARCHAR(50),
    Lat DOUBLE,
    Lng DOUBLE,

    FOREIGN KEY (ID) REFERENCES user(Username) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE driver (
    ID VARCHAR(30) PRIMARY KEY,
    NationalID VARCHAR(15),
    FirstName VARCHAR(30),
    LastName VARCHAR(30),
    Region VARCHAR(50),
    City VARCHAR(30),
    State VARCHAR(20) DEFAULT 'Free' CHECK ( State IN ('Free', 'Busy', 'NotAvailable') ),
    Lat DOUBLE,
    Lng DOUBLE,


    FOREIGN KEY (ID) REFERENCES user(Username) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE driver_log (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    EventName VARCHAR(30),
    Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    DriverID varchar(30),

    FOREIGN KEY (DriverID) REFERENCES driver(ID) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE charity (
    ID VARCHAR(30) PRIMARY KEY,
    Name VARCHAR(30),
    Population INTEGER,
    City VARCHAR(30),
    Region VARCHAR(50),
    Lat DOUBLE,
    Lng DOUBLE,
    FoundationYear INTEGER CHECK ( FoundationYear > 1800 AND FoundationYear < 2200 ),
    DailyUsage INT DEFAULT Population,

    FOREIGN KEY (ID) REFERENCES user(Username) ON DELETE CASCADE ON UPDATE CASCADE

);

CREATE TABLE delivery(
    DeliveryID INT AUTO_INCREMENT PRIMARY KEY,
    RestaurantID VARCHAR(30),
    DriverID VARCHAR(30),
    CharityID VARCHAR(30),

    Count INT DEFAULT 1,
    State VARCHAR(20) DEFAULT 'Not Send' CHECK ( State IN ('Not Send', 'In Progress', 'Done') ),
    Date DATE DEFAULT CURRENT_DATE,
    Rate INTEGER DEFAULT 0 CHECK ( Rate >= 0 AND Rate <= 5 ),

    FOREIGN KEY (RestaurantID) REFERENCES restaurant(ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (DriverID) REFERENCES driver(ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (CharityID) REFERENCES charity(ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE contract(
    RestaurantID VARCHAR(30),
    CharityID VARCHAR(30),
    Date DATE DEFAULT CURRENT_DATE,

    PRIMARY KEY (RestaurantID, CharityID),
    FOREIGN KEY (RestaurantID) REFERENCES restaurant(ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (CharityID) REFERENCES charity(ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TRIGGER after_driver_status_update AFTER UPDATE ON driver
    FOR EACH ROW
    BEGIN
      IF NEW.State != OLD.State THEN
          INSERT INTO driver_log(EventName, DriverID) VALUES ('ChangeState', NEW.ID);
      END IF;
    END;

CREATE TRIGGER after_delivery_status_update AFTER UPDATE ON delivery
    FOR EACH ROW
    BEGIN
      IF NEW.State != OLD.State AND NEW.State = 'In Progress' THEN
          UPDATE driver SET State = 'Busy' WHERE ID = NEW.DriverID;
      END IF;

      IF NEW.State != OLD.State AND NEW.State = 'Done' THEN
          UPDATE driver SET State = 'Free' WHERE ID = NEW.DriverID;
      END IF;
    END;