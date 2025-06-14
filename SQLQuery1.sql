-- Create Roles Table
CREATE TABLE Roles (
RoleID INT PRIMARY KEY IDENTITY(1,1),
RoleName NVARCHAR(100) NOT NULL UNIQUE
);

-- Create Users Table
CREATE TABLE Users (
UserID INT PRIMARY KEY IDENTITY(1,1),
Email NVARCHAR(255) NOT NULL UNIQUE,
PasswordHash NVARCHAR(255) NOT NULL,
FullName NVARCHAR(100),
PhoneNumber NVARCHAR(20),
Status NVARCHAR(50),
CreatedAt DATETIME DEFAULT GETDATE()
);

-- Create UserRole Table
CREATE TABLE UserRole (
UserRoleID INT PRIMARY KEY IDENTITY(1,1),
UserID INT FOREIGN KEY REFERENCES Users(UserID),
RoleID INT FOREIGN KEY REFERENCES Roles(RoleID)
);

-- Create Functions Table
CREATE TABLE Functions (
FunctionID INT PRIMARY KEY IDENTITY(1,1),
FunctionName NVARCHAR(255) NOT NULL,
Description NVARCHAR(500)
);

-- Create AccessControl Table
CREATE TABLE AccessControl (
AccessID INT PRIMARY KEY IDENTITY(1,1),
RoleID INT FOREIGN KEY REFERENCES Roles(RoleID),
FunctionID INT FOREIGN KEY REFERENCES Functions(FunctionID)
);

-- Create Foods Table
CREATE TABLE Foods (
FoodID INT PRIMARY KEY IDENTITY(1,1),
Name NVARCHAR(255) NOT NULL,
Description NVARCHAR(MAX),
Calories INT,
Category NVARCHAR(100),
CreatedAt DATETIME DEFAULT GETDATE()
);

-- Create Recipes Table
CREATE TABLE Recipes (
RecipeID INT PRIMARY KEY IDENTITY(1,1),
FoodID INT FOREIGN KEY REFERENCES Foods(FoodID),
Title NVARCHAR(255),
Description NVARCHAR(MAX),
Ingredients NVARCHAR(MAX),
Instructions NVARCHAR(MAX),
CreatedAt DATETIME DEFAULT GETDATE(),
Status NVARCHAR(50),
UserID INT FOREIGN KEY REFERENCES Users(UserID)
);

-- Create Recipe Ratings Table
CREATE TABLE RecipeRatings (
RatingID INT PRIMARY KEY IDENTITY(1,1),
RecipeID INT FOREIGN KEY REFERENCES Recipes(RecipeID),
UserID INT FOREIGN KEY REFERENCES Users(UserID),
RatingValue INT CHECK (RatingValue BETWEEN 1 AND 5),
CreatedAt DATETIME DEFAULT GETDATE()
);

-- Create Food Ratings Table
CREATE TABLE FoodRatings (
RatingID INT PRIMARY KEY IDENTITY(1,1),
FoodID INT FOREIGN KEY REFERENCES Foods(FoodID),
UserID INT FOREIGN KEY REFERENCES Users(UserID),
RatingValue INT CHECK (RatingValue BETWEEN 1 AND 5),
CreatedAt DATETIME DEFAULT GETDATE()
);

-- Create Recipe Comments Table
CREATE TABLE RecipeComments (
CommentID INT PRIMARY KEY IDENTITY(1,1),
RecipeID INT FOREIGN KEY REFERENCES Recipes(RecipeID),
UserID INT FOREIGN KEY REFERENCES Users(UserID),
Content NVARCHAR(MAX),
CreatedAt DATETIME DEFAULT GETDATE()
);

-- Create Food Comments Table
CREATE TABLE FoodComments (
CommentID INT PRIMARY KEY IDENTITY(1,1),
FoodID INT FOREIGN KEY REFERENCES Foods(FoodID),
UserID INT FOREIGN KEY REFERENCES Users(UserID),
Content NVARCHAR(MAX),
CreatedAt DATETIME DEFAULT GETDATE()
);

-- Create ChatMessages Table
CREATE TABLE ChatMessages (
ChatID INT PRIMARY KEY IDENTITY(1,1),
SenderID INT FOREIGN KEY REFERENCES Users(UserID),
ReceiverID INT FOREIGN KEY REFERENCES Users(UserID),
Message NVARCHAR(MAX),
SentAt DATETIME DEFAULT GETDATE()
);

-- Create Subscriptions Table
CREATE TABLE Subscriptions (
SubscriptionID INT PRIMARY KEY IDENTITY(1,1),
UserID INT FOREIGN KEY REFERENCES Users(UserID),
PlanName NVARCHAR(100),
Price DECIMAL(10, 2),
StartDate DATETIME,
EndDate DATETIME,
IsActive BIT
);

-- Create GroceryLists Table
CREATE TABLE GroceryLists (
ListID INT PRIMARY KEY IDENTITY(1,1),
UserID INT FOREIGN KEY REFERENCES Users(UserID),
Title NVARCHAR(255),
CreatedAt DATETIME DEFAULT GETDATE()
);

-- Create GroceryListItems Table with Serving Calculation
CREATE TABLE GroceryListItems (
ItemID INT PRIMARY KEY IDENTITY(1,1),
ListID INT FOREIGN KEY REFERENCES GroceryLists(ListID),
IngredientName NVARCHAR(255),
BaseAmount NVARCHAR(100), -- e.g., "100g", "2 cups"
PerServingMultiplier FLOAT DEFAULT 1.0, -- quantity multiplier
NumberOfServings INT DEFAULT 1,
TotalAmount NVARCHAR(255), -- result of calculation like "300g"
CreatedAt DATETIME DEFAULT GETDATE()
);

-- Create Combined Favorites Table
CREATE TABLE Favorites (
FavoriteID INT PRIMARY KEY IDENTITY(1,1),
UserID INT FOREIGN KEY REFERENCES Users(UserID),
FavoriteType NVARCHAR(20) CHECK (FavoriteType IN ('Food', 'Recipe')) NOT NULL,
FoodID INT NULL FOREIGN KEY REFERENCES Foods(FoodID),
RecipeID INT NULL FOREIGN KEY REFERENCES Recipes(RecipeID),
CreatedAt DATETIME DEFAULT GETDATE(),
CHECK (
(FavoriteType = 'Food' AND FoodID IS NOT NULL AND RecipeID IS NULL) OR
(FavoriteType = 'Recipe' AND RecipeID IS NOT NULL AND FoodID IS NULL)
)
);

-- Create Reports Table
CREATE TABLE Reports (
ReportID INT PRIMARY KEY IDENTITY(1,1),
RecipeID INT FOREIGN KEY REFERENCES Recipes(RecipeID),
UserID INT FOREIGN KEY REFERENCES Users(UserID),
Reason NVARCHAR(MAX),
CreatedAt DATETIME DEFAULT GETDATE()
);

-- Create Notifications Table
CREATE TABLE Notifications (
NotificationID INT PRIMARY KEY IDENTITY(1,1),
UserID INT FOREIGN KEY REFERENCES Users(UserID),
Message NVARCHAR(MAX),
CreatedAt DATETIME DEFAULT GETDATE()
);

-- Create AIsuggestions Table (linked to Food)
CREATE TABLE AIsuggestions (
SuggestionID INT PRIMARY KEY IDENTITY(1,1),
FoodID INT FOREIGN KEY REFERENCES Foods(FoodID),
SuggestionText NVARCHAR(MAX),
CreatedAt DATETIME DEFAULT GETDATE()
);

-- Create Payments Table
CREATE TABLE Payments (
PaymentID INT PRIMARY KEY IDENTITY(1,1),
UserID INT FOREIGN KEY REFERENCES Users(UserID),
Amount DECIMAL(10,2),
PaymentMethod NVARCHAR(100),
PaidAt DATETIME DEFAULT GETDATE()
);

-- Create CalorieTracking Table
CREATE TABLE CalorieTracking (
TrackID INT PRIMARY KEY IDENTITY(1,1),
UserID INT FOREIGN KEY REFERENCES Users(UserID),
EstimatedCalories INT,
EstimatedServing NVARCHAR(100),
TrackedAt DATETIME DEFAULT GETDATE()
);

-- Create ServingCalculations Table
CREATE TABLE ServingCalculations (
CalcID INT PRIMARY KEY IDENTITY(1,1),
RecipeID INT FOREIGN KEY REFERENCES Recipes(RecipeID),
UserID INT FOREIGN KEY REFERENCES Users(UserID),
CalculatedServing NVARCHAR(100),
CalculatedAt DATETIME DEFAULT GETDATE()
);

-- Create Wheelspin Table
CREATE TABLE Wheelspin (
SpinID INT PRIMARY KEY IDENTITY(1,1),
UserID INT FOREIGN KEY REFERENCES Users(UserID),
Result NVARCHAR(255),
CreatedAt DATETIME DEFAULT GETDATE()
);