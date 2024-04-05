--CREATE DATABASE SQLFundamentals

USE SQLFundamentals

CREATE TABLE [Roles](
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(30) NOT NULL,
	[Description] NVARCHAR(1000) NOT NULL,
)

CREATE TABLE [Users](
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(100) NOT NULL,
	[Age] INT NOT NULL, 
	[Gender] NVARCHAR(5),
	[Email] NVARCHAR(100) NOT NULL,
	[Bio] NVARCHAR(1000),
	[PhoneNumber] NVARCHAR(20) NOT NULL,
	[Weight] FLOAT,
	[Height] FLOAT,
	[Picture] NVARCHAR(500),
	[Rating] INT, 
	[RoleID] INT NOT NULL FOREIGN KEY REFERENCES [Roles]([Id])
)


CREATE TABLE [Locations](-- office floor 1 / office floor 2
	[Id] INT PRIMARY KEY IDENTITY,
	[City] NVARCHAR(100) NOT NULL,
	[Region] NVARCHAR(100) NOT NULL,
	[Street] NVARCHAR(100) NOT NULL,
	[Latitude] NVARCHAR(20) NOT NULL,
	[Longitude] NVARCHAR(20) NOT NULL,
	[Number] INT,
	[ZIPCode] NVARCHAR(100) NOT NULL
)

CREATE TABLE [Schedules](
	[Id] INT PRIMARY KEY IDENTITY,
	[Date] DATETIME NOT NULL,
	[UserId] INT NOT NULL FOREIGN KEY REFERENCES [Users]([Id]), --Trainer
	[LocationId] INT NOT NULL FOREIGN KEY REFERENCES [Locations]([Id]) -- office floor 2
)


CREATE TABLE [WorkoutCategories](
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(100) NOT NULL
)

CREATE TABLE [Workouts](
	[Id] INT PRIMARY KEY IDENTITY,
	[Title] NVARCHAR(100) NOT NULL,
	[Description] NVARCHAR(1000) NOT NULL,
	[EquipmentNeeded] NVARCHAR(100),
	[Duration] DATETIME NOT NULL,
	[Gender] NVARCHAR(20) NOT NULL,
	[IntensityLevel] INT NOT NULL,
	[MaxCapacity] INT NOT NULL,
	[Status] NVARCHAR NOT NULL,
	[Picture] NVARCHAR(200),
	[Price] MONEY NOT NULL,
	[RecommendedFrequency] NVARCHAR(50),
	[WorkoutCategoryId] INT NOT NULL FOREIGN KEY REFERENCES [WorkoutCategories]([Id])
)


CREATE TABLE [Ratings](
	[Id] INT PRIMARY KEY IDENTITY,
	[Date] DATETIME DEFAULT GETDATE(),
	[Rating] INT CHECK ([Rating] >= 1 AND [Rating] <= 5),
	[Comment] NVARCHAR(1000),
	[UserId] INT NOT NULL FOREIGN KEY REFERENCES [Users]([Id]),
	[WorkoutId] INT NOT NULL FOREIGN KEY REFERENCES [Workouts]([Id]),
)


CREATE TABLE [Tags](
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(30) NOT NULL
)

CREATE TABLE [Bookings](
	[Id] INT PRIMARY KEY IDENTITY,
	[CountPeople] INT NOT NULL,
	[WorkoutId] INT NOT NULL FOREIGN KEY REFERENCES [Workouts]([Id]),
	[LocationId] INT NOT NULL FOREIGN KEY REFERENCES [Locations]([Id]),
	[ScheduleId] INT NOT NULL FOREIGN KEY REFERENCES [Schedules]([Id]),
	[UserId] INT NOT NULL FOREIGN KEY REFERENCES [Users]([Id])
)

CREATE TABLE [BookingsUsersMapping](
	[BookingId] INT NOT NULL FOREIGN KEY REFERENCES [Bookings]([Id]),
	[UserId] INT NOT NULL FOREIGN KEY REFERENCES [Users]([Id]),
    PRIMARY KEY ([BookingId], [UserId])
)


--WorkoutTrainersMapping
CREATE TABLE [WorkoutsUsersMapping](
	[WorkoutId] INT NOT NULL FOREIGN KEY REFERENCES [Workouts]([Id]),
	[UserId] INT NOT NULL FOREIGN KEY REFERENCES [Users]([Id]),
    PRIMARY KEY ([WorkoutId], [UserId])
)

CREATE TABLE [WorkoutsSchedulesMapping](
	[WorkoutId] INT NOT NULL FOREIGN KEY REFERENCES [Workouts]([Id]),
	[ScheduleId] INT NOT NULL FOREIGN KEY REFERENCES [Schedules]([Id]),
    PRIMARY KEY ([WorkoutId], [ScheduleId])
)

CREATE TABLE [LocationsWorkoutsMapping](
	[WorkoutId] INT NOT NULL FOREIGN KEY REFERENCES [Workouts]([Id]),
	[LocationId] INT NOT NULL FOREIGN KEY REFERENCES [Locations]([Id]),
    PRIMARY KEY ([WorkoutId], [LocationId])
)

CREATE TABLE [WorkoutsTagsMapping](
	[WorkoutId] INT NOT NULL FOREIGN KEY REFERENCES [Workouts]([Id]),
	[TagId] INT NOT NULL FOREIGN KEY REFERENCES [Tags]([Id]),
    PRIMARY KEY ([WorkoutId], [TagId])
)


