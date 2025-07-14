-- USERS Table
CREATE TABLE Users (
    ID INT PRIMARY KEY IDENTITY,
    UserName VARCHAR(50) UNIQUE,  -- UNIQUE constraint added
    Email VARCHAR(100) UNIQUE,    -- UNIQUE constraint added
    Password VARCHAR(255),
    PhoneNumber VARCHAR(20) UNIQUE,  -- UNIQUE constraint added
    Status VARCHAR(50),
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- ROLE Table
CREATE TABLE Role (
    ID INT PRIMARY KEY IDENTITY,
    RoleName VARCHAR(50) UNIQUE -- Ensuring role names are unique
);

-- USER-ROLE LINK Table
CREATE TABLE UserRole (
    UserID INT,
    RoleID INT,
    PRIMARY KEY (UserID, RoleID),
    FOREIGN KEY (UserID) REFERENCES Users(ID),
    FOREIGN KEY (RoleID) REFERENCES Role(ID)
);

-- RESTAURANT Table
CREATE TABLE Restaurant (
    ID INT PRIMARY KEY IDENTITY,
    Name VARCHAR(100) UNIQUE,  -- Ensure restaurant names are unique
    OwnerID INT,
    Address VARCHAR(255),
    FOREIGN KEY (OwnerID) REFERENCES Users(ID)
);

-- FOOD Table
CREATE TABLE Food (
    ID INT PRIMARY KEY IDENTITY,
    Name VARCHAR(100) UNIQUE,  -- Ensure food names are unique
    Description TEXT,
    Price DECIMAL(10, 2)
);

-- CATEGORY Table
CREATE TABLE Category (
    ID INT PRIMARY KEY IDENTITY,
    Name VARCHAR(50) UNIQUE
);

-- FOOD-CATEGORY LINK Table
CREATE TABLE FoodCategory (
    FoodID INT,
    CategoryID INT,
    PRIMARY KEY (FoodID, CategoryID),
    FOREIGN KEY (FoodID) REFERENCES Food(ID),
    FOREIGN KEY (CategoryID) REFERENCES Category(ID)
);

-- FOOD-RESTAURANT LINK Table
CREATE TABLE FoodRestaurant (
    FoodID INT,
    RestaurantID INT,
    PRIMARY KEY (FoodID, RestaurantID),
    FOREIGN KEY (FoodID) REFERENCES Food(ID),
    FOREIGN KEY (RestaurantID) REFERENCES Restaurant(ID)
);

-- RESERVATION Table
CREATE TABLE Reservation (
    ID INT PRIMARY KEY IDENTITY,
    CustomerID INT,
    RestaurantID INT,
    ReservationTime DATETIME,
    HasOrder BIT DEFAULT 0,
    OrderTime DATETIME NULL,
    FOREIGN KEY (CustomerID) REFERENCES Users(ID),
    FOREIGN KEY (RestaurantID) REFERENCES Restaurant(ID)
);

-- RESERVATION FOOD Table
CREATE TABLE ReservationFood (
    ReservationID INT,
    FoodID INT,
    Quantity INT,
    PRIMARY KEY (ReservationID, FoodID),
    FOREIGN KEY (ReservationID) REFERENCES Reservation(ID),
    FOREIGN KEY (FoodID) REFERENCES Food(ID)
);

-- RESERVATION PAYMENT Table
CREATE TABLE ReservationPayment (
    ID INT PRIMARY KEY IDENTITY,
    ReservationID INT,
    Amount DECIMAL(10, 2),
    PaymentTime DATETIME DEFAULT GETDATE(),
    PaymentStatus VARCHAR(50) DEFAULT 'Pending',
    PaymentMethod VARCHAR(50),
    FOREIGN KEY (ReservationID) REFERENCES Reservation(ID)
);

-- ADVERTISEMENT Table
CREATE TABLE Advertisement (
    ID INT PRIMARY KEY IDENTITY,
    RestaurantID INT,
    Title VARCHAR(100),
    Content TEXT,
    PosterImagePath VARCHAR(255),
    Paid BIT DEFAULT 0,
    StartDate DATETIME,
    EndDate DATETIME,
    AdStatus VARCHAR(50) DEFAULT 'Active',
    FOREIGN KEY (RestaurantID) REFERENCES Restaurant(ID)
);

-- FEEDBACK
CREATE TABLE Feedback (
    ID INT PRIMARY KEY IDENTITY,
    UserID INT,
    RestaurantID INT,
    Comment TEXT,
    Rating INT,
    FeedbackType VARCHAR(50),
    FOREIGN KEY (UserID) REFERENCES Users(ID),
    FOREIGN KEY (RestaurantID) REFERENCES Restaurant(ID)
);

-- WHEEL HISTORY
CREATE TABLE UserWheelHistory (
    ID INT PRIMARY KEY IDENTITY,
    UserID INT,
    OptionsText TEXT,
    ChosenOption VARCHAR(100),
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(ID)
);

-- TIME SLOT
CREATE TABLE TimeSlot (
    ID INT PRIMARY KEY IDENTITY,
    RestaurantID INT,
    StartTime DATETIME,
    EndTime DATETIME,
    Available BIT DEFAULT 1,
    FOREIGN KEY (RestaurantID) REFERENCES Restaurant(ID)
);

-- NOTIFICATION
CREATE TABLE Notification (
    ID INT PRIMARY KEY IDENTITY,
    UserID INT,
    Message VARCHAR(255),
    Status VARCHAR(50) DEFAULT 'Unread',
    CreatedAt DATETIME DEFAULT GETDATE(),
    SentAt DATETIME,
    FOREIGN KEY (UserID) REFERENCES Users(ID)
);

-- FOOD SUGGESTION HISTORY
CREATE TABLE FoodSuggestionHistory (
    ID INT PRIMARY KEY IDENTITY,
    UserID INT,
    FoodID INT,
    SuggestionType VARCHAR(50),
    Timestamp DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(ID),
    FOREIGN KEY (FoodID) REFERENCES Food(ID)
);
-- Insert Users (Restaurant Owners, Admin, and Customer) with unique details
INSERT INTO Users (UserName, Email, Password, PhoneNumber, Status) VALUES
('restaurant_owner1', 'owner1@angi.com', 'password123', '0912345678', 'Active'),
('restaurant_owner2', 'owner2@angi.com', 'password123', '0919876543', 'Active'),
('restaurant_owner3', 'owner3@angi.com', 'password123', '0912345908', 'Active'),
('restaurant_owner4', 'owner4@angi.com', 'password123', '0919876123', 'Active'),
('admin_user', 'admin@angi.com', 'adminpassword', '0999887766', 'Active'),
('customer_user', 'customer@angi.com', 'customerpassword', '0922334455', 'Active');
-- Insert Roles
INSERT INTO Role (RoleName) VALUES
('Admin'),
('Customer'),
('Restaurant');
-- Assign Roles to Users
INSERT INTO UserRole (UserID, RoleID) VALUES
(5, 1),  -- Admin (ID = 5)
(6, 2),  -- Customer (ID = 6)
(1, 3),  -- Restaurant Owner 1 (ID = 1)
(2, 3),  -- Restaurant Owner 2 (ID = 2)
(3, 3),  -- Restaurant Owner 1 (ID = 3)
(4, 3);  -- Restaurant Owner 2 (ID = 4)
-- Insert Restaurants (with unique names)
INSERT INTO Restaurant (Name, OwnerID, Address) VALUES
('La Maison 1888', 1, 'Bà Nà Hills, Da Nang'),  -- Owner 1
('Madam Lan', 2, '124 Nguyen Tri Phuong, Da Nang'),  -- Owner 2
('The Rachel', 3, '58 Tran Phu, Da Nang'),  -- Owner 1
('Bếp 7', 4, '53 Le Duan, Da Nang');  -- Owner 2
INSERT INTO TimeSlot (RestaurantID, StartTime, EndTime, Available) VALUES
(1, '2025-01-15 12:00:00', '2025-01-15 14:00:00', 1),
(1, '2025-01-15 18:00:00', '2025-01-15 20:00:00', 1),
(2, '2025-01-15 11:30:00', '2025-01-15 13:30:00', 1),
(2, '2025-01-15 19:00:00', '2025-01-15 21:00:00', 1);