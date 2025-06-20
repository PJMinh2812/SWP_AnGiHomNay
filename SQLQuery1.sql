﻿-- 1. Roles Table
CREATE TABLE Roles (
RoleID INT PRIMARY KEY IDENTITY(1,1),
RoleName NVARCHAR(100) NOT NULL UNIQUE
);

-- 2. Users Table
CREATE TABLE Users (
UserID INT PRIMARY KEY IDENTITY(1,1),
Email NVARCHAR(255) NOT NULL UNIQUE,
Password NVARCHAR(255) NOT NULL,
FullName NVARCHAR(100),
PhoneNumber NVARCHAR(20),
Status NVARCHAR(50),
CreatedAt DATETIME DEFAULT GETDATE()
);

-- 3. UserRole Table
CREATE TABLE UserRole (
UserRoleID INT PRIMARY KEY IDENTITY(1,1),
UserID INT FOREIGN KEY REFERENCES Users(UserID),
RoleID INT FOREIGN KEY REFERENCES Roles(RoleID)
);

-- 4. Functions Table
CREATE TABLE Functions (
FunctionID INT PRIMARY KEY IDENTITY(1,1),
FunctionName NVARCHAR(255) NOT NULL,
Description NVARCHAR(500)
);

-- 5. AccessControl Table
CREATE TABLE AccessControl (
AccessID INT PRIMARY KEY IDENTITY(1,1),
RoleID INT FOREIGN KEY REFERENCES Roles(RoleID),
FunctionID INT FOREIGN KEY REFERENCES Functions(FunctionID)
);

-- 6. Categories Table
CREATE TABLE Categories (
CategoryID INT PRIMARY KEY IDENTITY(1,1),
CategoryName NVARCHAR(100) NOT NULL UNIQUE
);

-- 7. Foods Table
CREATE TABLE Foods (
FoodID INT PRIMARY KEY IDENTITY(1,1),
Name NVARCHAR(255) NOT NULL,
Description NVARCHAR(MAX),
FoodImage NVARCHAR(255),
Calories INT,
Protein DECIMAL(5,2),
Fat DECIMAL(5,2),
Carbohydrates DECIMAL(5,2),
Ingredients NVARCHAR(MAX),
PreparationMethod NVARCHAR(MAX),
Status NVARCHAR(50),
CreatedAt DATETIME DEFAULT GETDATE()
);

-- 8. FoodCategories Table (Many-to-Many between Foods and Categories)
CREATE TABLE FoodCategories (
FoodID INT FOREIGN KEY REFERENCES Foods(FoodID),
CategoryID INT FOREIGN KEY REFERENCES Categories(CategoryID),
PRIMARY KEY (FoodID, CategoryID)
);

-- 9. Recipes Table
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

-- 10. RecipeRatings Table
CREATE TABLE RecipeRatings (
RatingID INT PRIMARY KEY IDENTITY(1,1),
RecipeID INT FOREIGN KEY REFERENCES Recipes(RecipeID),
UserID INT FOREIGN KEY REFERENCES Users(UserID),
RatingValue INT CHECK (RatingValue BETWEEN 1 AND 5),
CreatedAt DATETIME DEFAULT GETDATE()
);

-- 11. FoodRatings Table
CREATE TABLE FoodRatings (
RatingID INT PRIMARY KEY IDENTITY(1,1),
FoodID INT FOREIGN KEY REFERENCES Foods(FoodID),
UserID INT FOREIGN KEY REFERENCES Users(UserID),
RatingValue INT CHECK (RatingValue BETWEEN 1 AND 5),
CreatedAt DATETIME DEFAULT GETDATE()
);

-- 12. RecipeComments Table
CREATE TABLE RecipeComments (
CommentID INT PRIMARY KEY IDENTITY(1,1),
RecipeID INT FOREIGN KEY REFERENCES Recipes(RecipeID),
UserID INT FOREIGN KEY REFERENCES Users(UserID),
Content NVARCHAR(MAX),
CreatedAt DATETIME DEFAULT GETDATE()
);

-- 13. FoodComments Table
CREATE TABLE FoodComments (
CommentID INT PRIMARY KEY IDENTITY(1,1),
FoodID INT FOREIGN KEY REFERENCES Foods(FoodID),
UserID INT FOREIGN KEY REFERENCES Users(UserID),
Content NVARCHAR(MAX),
CreatedAt DATETIME DEFAULT GETDATE()
);

-- 14. ChatMessages Table
CREATE TABLE ChatMessages (
ChatID INT PRIMARY KEY IDENTITY(1,1),
SenderID INT FOREIGN KEY REFERENCES Users(UserID),
ReceiverID INT FOREIGN KEY REFERENCES Users(UserID),
Message NVARCHAR(MAX),
SentAt DATETIME DEFAULT GETDATE()
);

-- 15. Subscriptions Table
CREATE TABLE Subscriptions (
SubscriptionID INT PRIMARY KEY IDENTITY(1,1),
UserID INT FOREIGN KEY REFERENCES Users(UserID),
PlanName NVARCHAR(100),
Price DECIMAL(10, 2),
StartDate DATETIME,
EndDate DATETIME,
IsActive BIT
);

-- 16. GroceryLists Table
CREATE TABLE GroceryLists (
ListID INT PRIMARY KEY IDENTITY(1,1),
UserID INT FOREIGN KEY REFERENCES Users(UserID),
Title NVARCHAR(255),
CreatedAt DATETIME DEFAULT GETDATE()
);

-- 17. GroceryListItems Table
CREATE TABLE GroceryListItems (
ItemID INT PRIMARY KEY IDENTITY(1,1),
ListID INT FOREIGN KEY REFERENCES GroceryLists(ListID),
Ingredient NVARCHAR(255),
Quantity DECIMAL(10,2),
Unit NVARCHAR(50),
Servings INT,
CalculatedAmount DECIMAL(10,2),
CreatedAt DATETIME DEFAULT GETDATE()
);

-- 18. Favorites Table
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

-- 19. Reports Table
CREATE TABLE Reports (
ReportID INT PRIMARY KEY IDENTITY(1,1),
RecipeID INT FOREIGN KEY REFERENCES Recipes(RecipeID),
UserID INT FOREIGN KEY REFERENCES Users(UserID),
Reason NVARCHAR(MAX),
CreatedAt DATETIME DEFAULT GETDATE()
);

-- 20. Notifications Table
CREATE TABLE Notifications (
NotificationID INT PRIMARY KEY IDENTITY(1,1),
UserID INT FOREIGN KEY REFERENCES Users(UserID),
Message NVARCHAR(MAX),
CreatedAt DATETIME DEFAULT GETDATE()
);

-- 21. AIsuggestions Table
CREATE TABLE AIsuggestions (
SuggestionID INT PRIMARY KEY IDENTITY(1,1),
FoodID INT FOREIGN KEY REFERENCES Foods(FoodID),
SuggestionText NVARCHAR(MAX),
CreatedAt DATETIME DEFAULT GETDATE()
);

-- 22. Payments Table
CREATE TABLE Payments (
PaymentID INT PRIMARY KEY IDENTITY(1,1),
UserID INT FOREIGN KEY REFERENCES Users(UserID),
Amount DECIMAL(10,2),
PaymentMethod NVARCHAR(100),
PaidAt DATETIME DEFAULT GETDATE()
);

-- 23. CalorieTracking Table
CREATE TABLE CalorieTracking (
TrackID INT PRIMARY KEY IDENTITY(1,1),
UserID INT FOREIGN KEY REFERENCES Users(UserID),
EstimatedCalories INT,
EstimatedServing NVARCHAR(100),
TrackedAt DATETIME DEFAULT GETDATE()
);

-- 24. ServingCalculations Table
CREATE TABLE ServingCalculations (
CalcID INT PRIMARY KEY IDENTITY(1,1),
RecipeID INT FOREIGN KEY REFERENCES Recipes(RecipeID),
UserID INT FOREIGN KEY REFERENCES Users(UserID),
CalculatedServing NVARCHAR(100),
CalculatedAt DATETIME DEFAULT GETDATE()
);

-- 25. Wheelspin Table
CREATE TABLE Wheelspin (
SpinID INT PRIMARY KEY IDENTITY(1,1),
UserID INT FOREIGN KEY REFERENCES Users(UserID),
Result NVARCHAR(255),
CreatedAt DATETIME DEFAULT GETDATE()
);
insert into Users (Email, Password, FullName, PhoneNumber) values ('dcabbell0@toplist.cz', 'wC6)B\vM.r', 'Myrtia MacAne', 'Daniele Cabbell');
insert into Users (Email, Password, FullName, PhoneNumber) values ('ddepke1@ucoz.ru', 'zX4/Qcl_', 'Brooke Etheridge', 'Dyann Depke');
insert into Users (Email, Password, FullName, PhoneNumber) values ('mtoke2@google.com', 'lL3>Q%%Zbb', 'Randa Jeannel', 'Mauricio Toke');
insert into Users (Email, Password, FullName, PhoneNumber) values ('ccluderay3@cpanel.net', 'jP0,!wE>va>4', 'Kalila Petras', 'Cesare Cluderay');
insert into Users (Email, Password, FullName, PhoneNumber) values ('eplewman4@slideshare.net', 'dE6/DO9', 'Elisabetta Savoury', 'Emmey Plewman');
insert into Users (Email, Password, FullName, PhoneNumber) values ('lmoles5@drupal.org', 'bW9%<xW9#q', 'Chrissie Luis', 'Lew Moles');
insert into Users (Email, Password, FullName, PhoneNumber) values ('oowain6@businessinsider.com', 'iK8*1YJ2P', 'Xerxes Pryce', 'Ofilia Owain');
insert into Users (Email, Password, FullName, PhoneNumber) values ('cholde7@dion.ne.jp', 'sH2!rCEPK,z', 'Brooks Sarath', 'Clemente Holde');
insert into Users (Email, Password, FullName, PhoneNumber) values ('smcwilliam8@apple.com', 'rE3|l0C"A', 'Sherline Crockett', 'Stanleigh McWilliam');
insert into Users (Email, Password, FullName, PhoneNumber) values ('mstuchburie9@amazon.com', 'aN1,On', 'Keefer Grattan', 'Manfred Stuchburie');
insert into Users (Email, Password, FullName, PhoneNumber) values ('mbellwarda@cafepress.com', 'gG2=k+>F)zT', 'Lula Goggan', 'Mitchael Bellward');
insert into Users (Email, Password, FullName, PhoneNumber) values ('rbucknallc@buzzfeed.com', 'kC6"oa@qu#', 'Cherianne Spender', 'Reg Bucknall');
insert into Users (Email, Password, FullName, PhoneNumber) values ('bfellisd@redcross.org', 'mJ8?$1mvM@9', 'Jacynth Chamberlaine', 'Bridgette Fellis');
insert into Users (Email, Password, FullName, PhoneNumber) values ('aowtrame@mac.com', 'nU7|UeNP4#', 'Burl Henryson', 'Alexei Owtram');
insert into Users (Email, Password, FullName, PhoneNumber) values ('cswadlingf@spotify.com', 'hK1>!ZTQ', 'Mike Allibone', 'Clo Swadling');
insert into Users (Email, Password, FullName, PhoneNumber) values ('tdoldong@diigo.com', 'xV6>>9#pO', 'Gweneth Hatry', 'Teodoor Doldon');
insert into Users (Email, Password, FullName, PhoneNumber) values ('gblinth@rambler.ru', 'wR8_}cg*lm|', 'Wilfrid De Dantesie', 'Giffy Blint');
insert into Users (Email, Password, FullName, PhoneNumber) values ('mcantui@ft.com', 'kD7@Jbv', 'Roxine Napier', 'Maxi Cantu');
insert into Users (Email, Password, FullName, PhoneNumber) values ('aaugustinej@omniture.com', 'yD1.gk#8', 'Eudora Vosse', 'Ania Augustine');
insert into Users (Email, Password, FullName, PhoneNumber) values ('amacconchiek@feedburner.com', 'pN6.8C.', 'Clementina Grigaut', 'Arnold MacConchie');
insert into Users (Email, Password, FullName, PhoneNumber) values ('bhaytol@cdc.gov', 'hF5_IKfW3J+T', 'Amby Perot', 'Brinna Hayto');
insert into Users (Email, Password, FullName, PhoneNumber) values ('lmolloym@ow.ly', 'sN9=ri', 'Staford Wrench', 'Lesli Molloy');
insert into Users (Email, Password, FullName, PhoneNumber) values ('egoolyn@dedecms.com', 'yX8%WM#g@', 'Georgina Chittock', 'Elinore Gooly');
insert into Users (Email, Password, FullName, PhoneNumber) values ('epinwello@ow.ly', 'rS0?.tu', 'Alfie Rudge', 'Evelyn Pinwell');
insert into Users (Email, Password, FullName, PhoneNumber) values ('djanatkap@ebay.co.uk', 'yT9|zi=Jt0M', 'Hamlin Sallows', 'Dionisio Janatka');
insert into Users (Email, Password, FullName, PhoneNumber) values ('cgarterq@about.me', 'aH0$$&Ph{', 'Tessa Smewing', 'Cathee Garter');
insert into Users (Email, Password, FullName, PhoneNumber) values ('cmccafferyr@cornell.edu', 'nA3"<5(r', 'Rodrick Taylorson', 'Carmela McCaffery');
insert into Users (Email, Password, FullName, PhoneNumber) values ('cdownhams@hc360.com', 'oG1+Rw5!7/JH', 'Duky Moxley', 'Cele Downham');
insert into Users (Email, Password, FullName, PhoneNumber) values ('rgiovannellit@deliciousdays.com', 'dD5>Keq''g', 'Annabella Allcorn', 'Ree Giovannelli');
insert into Users (Email, Password, FullName, PhoneNumber) values ('satwoolu@topsy.com', 'rK5?T{V_6i', 'Sauncho Leeuwerink', 'Sibley Atwool');
insert into Users (Email, Password, FullName, PhoneNumber) values ('lmeachenv@sitemeter.com', 'uN3}/Q', 'Gibb Quin', 'Lauree Meachen');
insert into Users (Email, Password, FullName, PhoneNumber) values ('fperhamw@indiatimes.com', 'tD7*4r/8IB', 'Josh Paydon', 'Fritz Perham');
insert into Users (Email, Password, FullName, PhoneNumber) values ('ghowatx@wufoo.com', 'mI6$(Mi70', 'Giuditta Gretton', 'Gus Howat');
insert into Users (Email, Password, FullName, PhoneNumber) values ('nbeasanty@slideshare.net', 'nE9=So>r.!', 'Kenny Crossgrove', 'Nanine Beasant');
insert into Users (Email, Password, FullName, PhoneNumber) values ('bkhadirz@issuu.com', 'vQ4{~A87', 'Delphinia Lemmens', 'Brockie Khadir');
insert into Users (Email, Password, FullName, PhoneNumber) values ('ffenech10@eepurl.com', 'xE6"g~"lnb', 'Barnie Armin', 'Fredia Fenech');
insert into Users (Email, Password, FullName, PhoneNumber) values ('cmateescu11@github.io', 'nP5*y\Sq2K', 'Marsha Donn', 'Chelsea Mateescu');
insert into Users (Email, Password, FullName, PhoneNumber) values ('hshippey12@berkeley.edu', 'jK8>4Tb2N~', 'Mercedes Darco', 'Halsy Shippey');
insert into Users (Email, Password, FullName, PhoneNumber) values ('ebenjamin13@seattletimes.com', 'jO3!eHKv$', 'Marc Sipson', 'Ellswerth Benjamin');
insert into Users (Email, Password, FullName, PhoneNumber) values ('fmaccoveney14@illinois.edu', 'rJ0(TWy4+ee', 'Lou Edwick', 'Felike MacCoveney');
insert into Users (Email, Password, FullName, PhoneNumber) values ('dsyddie15@cornell.edu', 'zH0/4.F''%', 'Meir Allsep', 'Daisy Syddie');
insert into Users (Email, Password, FullName, PhoneNumber) values ('rblenkinsopp16@hugedomains.com', 'tX4~whI', 'Adelaide Lygoe', 'Ruddie Blenkinsopp');
insert into Users (Email, Password, FullName, PhoneNumber) values ('jslograve17@tinypic.com', 'eT6!odejB}', 'Crichton Crawshaw', 'Juline Slograve');
insert into Users (Email, Password, FullName, PhoneNumber) values ('ncampes18@amazon.co.jp', 'aR3.$VoQgho', 'Jany Parkey', 'Nap Campes');
insert into Users (Email, Password, FullName, PhoneNumber) values ('mceschelli19@networksolutions.com', 'dH9''ogZlrP"', 'Rhetta Jacobovitch', 'Marjie Ceschelli');
insert into Users (Email, Password, FullName, PhoneNumber) values ('dyurkov1a@wix.com', 'dS9&SB', 'Adams Delap', 'Danila Yurkov');
insert into Users (Email, Password, FullName, PhoneNumber) values ('wcoonihan1b@posterous.com', 'bZ5_bt"', 'Lindie Sarfas', 'Wandis Coonihan');
insert into Users (Email, Password, FullName, PhoneNumber) values ('nde1c@amazonaws.com', 'sU5>mNKH01v', 'Karisa Krimmer', 'Niki De Zuani');
insert into Users (Email, Password, FullName, PhoneNumber) values ('ybudnik1d@umn.edu', 'fJ8}P''bg$PNh', 'Bailie Kingsland', 'York Budnik');
insert into Users (Email, Password, FullName, PhoneNumber) values ('ybudn@umn.edu', 'fJ8}P''bg$PNh', 'Bailiee Kingssland', 'Yorrk Budnisk');

insert into Roles (RoleName) values ('User');
insert into Roles (RoleName) values ('Admin');
insert into Roles (RoleName) values ('Premium');

insert into UserRole (UserID, RoleID) values (1, 1);
insert into UserRole (UserID, RoleID) values (2, 1);
insert into UserRole (UserID, RoleID) values (3, 1);
insert into UserRole (UserID, RoleID) values (4, 1);
insert into UserRole (UserID, RoleID) values (5, 1);
insert into UserRole (UserID, RoleID) values (6, 1);
insert into UserRole (UserID, RoleID) values (7, 1);
insert into UserRole (UserID, RoleID) values (8, 1);
insert into UserRole (UserID, RoleID) values (9, 1);
insert into UserRole (UserID, RoleID) values (10, 1);
insert into UserRole (UserID, RoleID) values (11, 1);
insert into UserRole (UserID, RoleID) values (13, 1);
insert into UserRole (UserID, RoleID) values (14, 1);
insert into UserRole (UserID, RoleID) values (15, 1);
insert into UserRole (UserID, RoleID) values (16, 1);
insert into UserRole (UserID, RoleID) values (17, 1);
insert into UserRole (UserID, RoleID) values (18, 1);
insert into UserRole (UserID, RoleID) values (19, 1);
insert into UserRole (UserID, RoleID) values (20, 2);
insert into UserRole (UserID, RoleID) values (21, 2);
insert into UserRole (UserID, RoleID) values (22, 2);
insert into UserRole (UserID, RoleID) values (23, 2);
insert into UserRole (UserID, RoleID) values (24, 2);
insert into UserRole (UserID, RoleID) values (25, 2);
insert into UserRole (UserID, RoleID) values (26, 1);
insert into UserRole (UserID, RoleID) values (27, 1);
insert into UserRole (UserID, RoleID) values (28, 1);
insert into UserRole (UserID, RoleID) values (29, 1);
insert into UserRole (UserID, RoleID) values (30, 1);
insert into UserRole (UserID, RoleID) values (31, 1);
insert into UserRole (UserID, RoleID) values (32, 1);
insert into UserRole (UserID, RoleID) values (33, 1);
insert into UserRole (UserID, RoleID) values (34, 1);
insert into UserRole (UserID, RoleID) values (35, 1);
insert into UserRole (UserID, RoleID) values (36, 1);
insert into UserRole (UserID, RoleID) values (37, 3);
insert into UserRole (UserID, RoleID) values (38, 3);
insert into UserRole (UserID, RoleID) values (39, 3);
insert into UserRole (UserID, RoleID) values (40, 3);
insert into UserRole (UserID, RoleID) values (41, 3);
insert into UserRole (UserID, RoleID) values (42, 3);
insert into UserRole (UserID, RoleID) values (43, 3);
insert into UserRole (UserID, RoleID) values (44, 3);
insert into UserRole (UserID, RoleID) values (45, 3);
insert into UserRole (UserID, RoleID) values (46, 3);
insert into UserRole (UserID, RoleID) values (47, 3);
insert into UserRole (UserID, RoleID) values (48, 3);
insert into UserRole (UserID, RoleID) values (49, 3);
insert into UserRole (UserID, RoleID) values (12, 3);

-- Insert Food Categories
INSERT INTO Categories (CategoryName) VALUES
-- By Cuisine
(N'Vietnamese'),
(N'Chinese'),
(N'Japanese'),
(N'Korean'),
(N'Thai'),
(N'Indian'),
(N'Italian'),
(N'French'),
(N'Mexican'),
(N'American'),
(N'Mediterranean'),
(N'Middle Eastern'),

-- By Taste / Spice Level
(N'Spicy'),
(N'Mild'),
(N'Sweet'),
(N'Savory'),
(N'Sour'),
(N'Bitter'),
(N'Umami'),

-- By Cooking Method
(N'Grilled'),
(N'Fried'),
(N'Steamed'),
(N'Boiled'),
(N'Roasted'),
(N'Stir-Fried'),
(N'Baked'),
(N'Raw'),

-- By Meal Type
(N'Breakfast'),
(N'Lunch'),
(N'Dinner'),
(N'Snack'),
(N'Dessert'),
(N'Supper'),
(N'Brunch'),

-- By Dietary / Health Preference
(N'Vegetarian'),
(N'Vegan'),
(N'Gluten-Free'),
(N'Low-Carb'),
(N'High-Protein'),
(N'Keto'),
(N'Paleo'),
(N'Dairy-Free'),
(N'Nut-Free'),
(N'Sugar-Free'),

-- By Food Group
(N'Meat'),
(N'Seafood'),
(N'Poultry'),
(N'Vegetables'),
(N'Fruits'),
(N'Grains'),
(N'Dairy'),
(N'Legumes'),
(N'Nuts & Seeds'),

-- By Audience / Use Case
(N'Kids-Friendly'),
(N'Party Food'),
(N'Street Food'),
(N'Quick & Easy'),
(N'Comfort Food'),
(N'Festive'),

-- By Preparation Time
(N'Under 15 minutes'),
(N'Under 30 minutes'),
(N'1-hour meals'),
(N'Slow Cooked');

-- Insert Categories used for Vietnamese food
INSERT INTO Categories (CategoryName)
VALUES
(N'Noodles'), (N'Sandwich'), (N'Spring Roll'), (N'Pork'), (N'Rice'), (N'Soup');

-- Insert Vietnamese Foods
INSERT INTO Foods (Name, Category, Description, FoodImage, Calories, Protein, Fat, Carbohydrates, Ingredients, PreparationMethod, Status)
VALUES
(N'Phở Bò', N'Vietnamese', N'Noodle soup with beef.', N'pho_bo.jpg', 350, 25.0, 10.0, 40.0, N'Rice noodles, beef, herbs, broth', N'Simmer beef bones for broth, cook noodles, serve with herbs', N'Active'),
(N'Bún Chả', N'Vietnamese', N'Grilled pork with noodles.', N'bun_cha.jpg', 500, 30.0, 20.0, 45.0, N'Pork, rice noodles, fish sauce, herbs', N'Grill pork, serve with noodles and dipping sauce', N'Active'),
(N'Cơm Tấm', N'Vietnamese', N'Broken rice with grilled pork.', N'com_tam.jpg', 600, 35.0, 25.0, 50.0, N'Broken rice, grilled pork, egg, vegetables', N'Grill pork, cook rice, serve with toppings', N'Active'),
(N'Gỏi Cuốn', N'Vietnamese', N'Fresh spring rolls.', N'goi_cuon.jpg', 200, 10.0, 5.0, 25.0, N'Rice paper, shrimp, pork, vegetables, noodles', N'Wrap ingredients in rice paper, serve with sauce', N'Active'),
(N'Bánh Mì', N'Vietnamese', N'Vietnamese baguette sandwich.', N'banh_mi.jpg', 400, 15.0, 18.0, 40.0, N'Baguette, pork, pate, pickled vegetables', N'Assemble sandwich with fillings', N'Active');



-- Insert Categories
INSERT INTO Categories (CategoryName) VALUES (N'Vietnamese');
INSERT INTO Categories (CategoryName) VALUES (N'Soup');
INSERT INTO Categories (CategoryName) VALUES (N'Noodle');
INSERT INTO Categories (CategoryName) VALUES (N'Grilled');
INSERT INTO Categories (CategoryName) VALUES (N'Rice');
INSERT INTO Categories (CategoryName) VALUES (N'Salad');
INSERT INTO Categories (CategoryName) VALUES (N'Sandwich');
INSERT INTO Categories (CategoryName) VALUES (N'Seafood');
INSERT INTO Categories (CategoryName) VALUES (N'Snack');

-- Insert Foods
INSERT INTO Foods (Name, Description, Calories, Protein, Fat, Carbohydrates, Ingredients, PreparationMethod, Status)
VALUES (N'Phở Bò', N'Beef noodle soup with herbs', 350, 25.0, 10.0, 45.0, N'Beef, rice noodles, herbs', N'Simmer broth, add noodles and beef', N'Active');

INSERT INTO Foods (Name, Description, Calories, Protein, Fat, Carbohydrates, Ingredients, PreparationMethod, Status)
VALUES (N'Bún Chả', N'Grilled pork with vermicelli', 500, 30.0, 20.0, 40.0, N'Pork, vermicelli, herbs', N'Grill pork, serve with noodles and dipping sauce', N'Active');

INSERT INTO Foods (Name, Description, Calories, Protein, Fat, Carbohydrates, Ingredients, PreparationMethod, Status)
VALUES (N'Cơm Tấm', N'Broken rice with grilled meat', 600, 35.0, 25.0, 55.0, N'Broken rice, pork, egg, pickles', N'Grill pork, fry egg, serve with rice', N'Active');

INSERT INTO Foods (Name, Description, Calories, Protein, Fat, Carbohydrates, Ingredients, PreparationMethod, Status)
VALUES (N'Gỏi Cuốn', N'Fresh spring rolls', 200, 15.0, 5.0, 25.0, N'Shrimp, pork, vermicelli, vegetables, rice paper', N'Wrap ingredients in rice paper', N'Active');

INSERT INTO Foods (Name, Description, Calories, Protein, Fat, Carbohydrates, Ingredients, PreparationMethod, Status)
VALUES (N'Bánh Mì', N'Vietnamese sandwich', 400, 18.0, 15.0, 45.0, N'Baguette, pork, vegetables, pâté', N'Assemble ingredients in baguette', N'Active');

-- Map Foods to Categories (FoodCategories)
-- Note: This assumes FoodIDs are 1 to 5 in order
INSERT INTO FoodCategories (FoodID, CategoryID) VALUES (1, 1); -- Phở Bò - Vietnamese
INSERT INTO FoodCategories (FoodID, CategoryID) VALUES (1, 2); -- Soup
INSERT INTO FoodCategories (FoodID, CategoryID) VALUES (1, 3); -- Noodle

INSERT INTO FoodCategories (FoodID, CategoryID) VALUES (2, 1); -- Bún Chả - Vietnamese
INSERT INTO FoodCategories (FoodID, CategoryID) VALUES (2, 3); -- Noodle
INSERT INTO FoodCategories (FoodID, CategoryID) VALUES (2, 4); -- Grilled

INSERT INTO FoodCategories (FoodID, CategoryID) VALUES (3, 1); -- Cơm Tấm - Vietnamese
INSERT INTO FoodCategories (FoodID, CategoryID) VALUES (3, 4); -- Grilled
INSERT INTO FoodCategories (FoodID, CategoryID) VALUES (3, 5); -- Rice

INSERT INTO FoodCategories (FoodID, CategoryID) VALUES (4, 1); -- Gỏi Cuốn - Vietnamese
INSERT INTO FoodCategories (FoodID, CategoryID) VALUES (4, 6); -- Salad
INSERT INTO FoodCategories (FoodID, CategoryID) VALUES (4, 8); -- Seafood

INSERT INTO FoodCategories (FoodID, CategoryID) VALUES (5, 1); -- Bánh Mì - Vietnamese
INSERT INTO FoodCategories (FoodID, CategoryID) VALUES (5, 7); -- Sandwich
INSERT INTO FoodCategories (FoodID, CategoryID) VALUES (5, 9); -- Snack

INSERT INTO Categories (CategoryName) VALUES
(N'Noodle'),
(N'Traditional'),
(N'Fusion'),
(N'Appetizer'),
(N'Healthy'),
(N'Pancake'),
(N'Southern'),
(N'Hue Cuisine'),
(N'Central Vietnam'),
(N'Rice Cake'),
(N'Northern'),
(N'Summer'),
(N'Curry'),
(N'Mini Pancake');

INSERT INTO Foods (Name, Description, FoodImage, Calories, Protein, Fat, Carbohydrates, Ingredients, PreparationMethod, Status)
VALUES
(N'Chả Giò', N'Deep-fried rolls with pork, mushrooms, and noodles.', NULL, 300, 18.0, 12.0, 30.0, N'Rice paper, pork, mushrooms, vermicelli', N'Wrap and fry the rolls.', 'Available'),
(N'Bánh Xèo', N'Crispy turmeric crepe with pork, shrimp, and bean sprouts.', NULL, 350, 20.0, 14.0, 35.0, N'Rice flour, turmeric, pork, shrimp, sprouts', N'Pan-fry the batter and fillings.', 'Available'),
(N'Bún Bò Huế', N'Spicy beef noodle soup with lemongrass and pork hock.', NULL, 480, 28.0, 12.0, 52.0, N'Beef, noodles, lemongrass, chili', N'Simmer soup, serve with noodles.', 'Available'),
(N'Mì Quảng', N'Turmeric-yellow noodles with shrimp, pork, herbs, and broth.', NULL, 400, 22.0, 8.0, 45.0, N'Noodles, turmeric, shrimp, pork, herbs', N'Mix ingredients and top with broth.', 'Available'),
(N'Bánh Cuốn', N'Steamed rice rolls filled with minced pork and mushrooms.', NULL, 280, 14.0, 5.0, 32.0, N'Rice flour, pork, mushrooms', N'Steam and fill rice rolls.', 'Available'),
(N'Hủ Tiếu', N'Clear noodle soup with pork, shrimp, and sometimes quail eggs.', NULL, 420, 20.0, 10.0, 45.0, N'Noodles, pork, shrimp, quail eggs', N'Simmer broth and add toppings.', 'Available'),
(N'Chè Ba Màu', N'Layers of jelly, mung bean paste, and coconut milk.', NULL, 350, 5.0, 10.0, 60.0, N'Jelly, mung bean, coconut milk', N'Layer ingredients in glass.', 'Available'),
(N'Cà Ri Gà', N'Chicken curry with potatoes, carrots, and baguette or rice.', NULL, 500, 28.0, 15.0, 45.0, N'Chicken, curry powder, veggies', N'Simmer curry and serve.', 'Available'),
(N'Bánh Bèo', N'Steamed rice discs topped with dried shrimp and scallion oil.', NULL, 150, 6.0, 3.0, 18.0, N'Rice flour, dried shrimp, scallions', N'Steam cakes and top with toppings.', 'Available'),
(N'Bánh Khọt', N'Mini savory pancakes with shrimp, mung beans, and herbs.', NULL, 320, 15.0, 12.0, 30.0, N'Flour, shrimp, mung beans', N'Fry mini pancakes with toppings.', 'Available');


INSERT INTO FoodCategories (FoodID, CategoryID) VALUES
(6, 9), (6, 11), (6, 4), -- Chả Giò
(7, 12), (7, 4), (7, 13), -- Bánh Xèo
(8, 1), (8, 2), (8, 14), (8, 15), -- Bún Bò Huế
(9, 1), (9, 16), -- Mì Quảng
(10, 17), (10, 18), (10, 19), -- Bánh Cuốn
(11, 1), (11, 2), (11, 13), -- Hủ Tiếu
(12, 20), (12, 21), (12, 22), -- Chè Ba Màu
(13, 23), (13, 24), -- Cà Ri Gà
(14, 17), (14, 25), -- Bánh Bèo
(15, 12), (15, 26); -- Bánh Khọt