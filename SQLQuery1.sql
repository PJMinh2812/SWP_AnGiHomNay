-- 1. Roles Table
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

