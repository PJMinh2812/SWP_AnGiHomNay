
-- USERS
CREATE TABLE Users (
    ID INT PRIMARY KEY IDENTITY,
    UserName VARCHAR(50),
    Email VARCHAR(100),
    Password VARCHAR(255),
    PhoneNumber VARCHAR(20),
    Status VARCHAR(50),
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- ROLE
CREATE TABLE Role (
    ID INT PRIMARY KEY IDENTITY,
    RoleName VARCHAR(50)
);

-- USER-ROLE LINK
CREATE TABLE UserRole (
    UserID INT,
    RoleID INT,
    PRIMARY KEY (UserID, RoleID),
    FOREIGN KEY (UserID) REFERENCES Users(ID),
    FOREIGN KEY (RoleID) REFERENCES Role(ID)
);

-- RESTAURANT
CREATE TABLE Restaurant (
    ID INT PRIMARY KEY IDENTITY,
    Name VARCHAR(100),
    OwnerID INT,
    Address VARCHAR(255),
    FOREIGN KEY (OwnerID) REFERENCES Users(ID)
);

-- FOOD
CREATE TABLE Food (
    ID INT PRIMARY KEY IDENTITY,
    Name VARCHAR(100),
    Description TEXT,
    Price DECIMAL(10, 2)
);

-- CATEGORY
CREATE TABLE Category (
    ID INT PRIMARY KEY IDENTITY,
    Name VARCHAR(50)
);

-- FOOD-CATEGORY LINK
CREATE TABLE FoodCategory (
    FoodID INT,
    CategoryID INT,
    PRIMARY KEY (FoodID, CategoryID),
    FOREIGN KEY (FoodID) REFERENCES Food(ID),
    FOREIGN KEY (CategoryID) REFERENCES Category(ID)
);

-- FOOD-RESTAURANT LINK
CREATE TABLE FoodRestaurant (
    FoodID INT,
    RestaurantID INT,
    PRIMARY KEY (FoodID, RestaurantID),
    FOREIGN KEY (FoodID) REFERENCES Food(ID),
    FOREIGN KEY (RestaurantID) REFERENCES Restaurant(ID)
);

-- RESERVATION TABLE (Combined Booking + Order)
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

-- RESERVATION FOOD
CREATE TABLE ReservationFood (
    ReservationID INT,
    FoodID INT,
    Quantity INT,
    PRIMARY KEY (ReservationID, FoodID),
    FOREIGN KEY (ReservationID) REFERENCES Reservation(ID),
    FOREIGN KEY (FoodID) REFERENCES Food(ID)
);

-- RESERVATION PAYMENT
CREATE TABLE ReservationPayment (
    ID INT PRIMARY KEY IDENTITY,
    ReservationID INT,
    Amount DECIMAL(10, 2),
    PaymentTime DATETIME DEFAULT GETDATE(),
    PaymentStatus VARCHAR(50) DEFAULT 'Pending',
    PaymentMethod VARCHAR(50),
    FOREIGN KEY (ReservationID) REFERENCES Reservation(ID)
);

-- ADVERTISEMENT
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
