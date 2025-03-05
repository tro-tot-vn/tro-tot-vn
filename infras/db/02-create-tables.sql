
CREATE TABLE [Account] (
  [accountId] INT PRIMARY KEY IDENTITY(1, 1),
  [phone] CHAR(12) UNIQUE NOT NULL,
  [password] VARCHAR(60) NOT NULL,
  [roleId] INT NOT NULL,
  [status] nvarchar(255) NOT NULL CHECK ([status] IN ('InActive', 'Active', 'Banned')) DEFAULT 'Active',
  [email] VARCHAR(60) UNIQUE NOT NULL
)
GO

CREATE TABLE [Role] (
  [roleId] INT PRIMARY KEY,
  [roleName] CHAR(20) NOT NULL
)
GO

CREATE TABLE [Permission] (
  [permissionId] INT PRIMARY KEY,
  [permissionName] CHAR(40) NOT NULL
)
GO

CREATE TABLE [RolePermission] (
  [permissionId] INT PRIMARY KEY,
  [roleId] INT NOT NULL
)
GO

CREATE TABLE [Admin] (
  [adminId] INT PRIMARY KEY IDENTITY(1, 1),
  [accountId] INT NOT NULL,
  [gender] nvarchar(255) NOT NULL CHECK ([gender] IN ('Female', 'Male')),
  [firstName] VARCHAR(30) NOT NULL,
  [lastName] VARCHAR(30) NOT NULL,
  [birthday] DATETIME NOT NULL
)
GO

CREATE TABLE [Customer] (
  [customerId] INT PRIMARY KEY IDENTITY(1, 1),
  [accountId] INT NOT NULL,
  [isVerified] tinyint DEFAULT (0),
  [gender] nvarchar(255) NOT NULL CHECK ([gender] IN ('Female', 'Male')),
  [bio] VARCHAR(150) DEFAULT '',
  [firstName] VARCHAR(30) NOT NULL,
  [lastName] VARCHAR(30) NOT NULL,
  [birthday] DATETIME
)
GO

CREATE TABLE [Post] (
  [postId] INT PRIMARY KEY IDENTITY(1, 1),
  [ownerId] INT,
  [status] nvarchar(255) NOT NULL CHECK ([status] IN ('Pending', 'Approved', 'Rejected', 'Hidden', 'Suspended')),
  [createdAt] DATETIME DEFAULT (CURRENT_TIMESTAMP),
  [title] VARCHAR(255),
  [description] TEXT,
  [price] INT,
  [streetNumber] VARCHAR(70) NOT NULL,
  [street] VARCHAR(70) NOT NULL,
  [ward] VARCHAR(70) NOT NULL,
  [district] VARCHAR(70) NOT NULL,
  [city] VARCHAR(70) NOT NULL,
  [latitude] DECIMAL(10,8),
  [longitude] DECIMAL(11,8),
  [interiorCondition] nvarchar(255) NOT NULL CHECK ([interiorCondition] IN ('Full', 'None')),
  [acreage] INT,
  [deposit] INT,
  [extendedAt] DATETIME,
  [version] INT NOT NULL
)
GO

CREATE TABLE [InfoEdition] (
  [infoId] INT PRIMARY KEY IDENTITY(1, 1),
  [postId] INT NOT NULL,
  [version] INT NOT NULL,
  [field] CHAR(100) NOT NULL,
  [value] VARCHAR(1500) NOT NULL,
  [changedAt] DATETIME DEFAULT (CURRENT_TIMESTAMP)
)
GO

CREATE TABLE [PostModerationHistory] (
  [historyId] INT PRIMARY KEY IDENTITY(1, 1),
  [postId] INT NOT NULL,
  [version] INT NOT NULL,
  [adminId] INT NOT NULL,
  [actionType] nvarchar(255) NOT NULL CHECK ([actionType] IN ('Approved', 'Rejected', 'Suspended')),
  [reason] VARCHAR(255) DEFAULT (null),
  [execAt] DATETIME DEFAULT (CURRENT_TIMESTAMP)
)
GO

CREATE TABLE [SavedPost] (
  [favoriteListId] INT PRIMARY KEY IDENTITY(1, 1),
  [customerId] INT NOT NULL,
  [postId] INT NOT NULL,
  [createdAt] DATETIME NOT NULL DEFAULT (CURRENT_TIMESTAMP)
)
GO

CREATE TABLE [Appointment] (
  [appointmentId] INT PRIMARY KEY IDENTITY(1, 1),
  [requesterId] INT NOT NULL,
  [postId] INT NOT NULL,
  [createdAt] DATETIME DEFAULT (CURRENT_TIMESTAMP),
  [appointment] DATETIME NOT NULL,
  [status] nvarchar(255) NOT NULL CHECK ([status] IN ('Pending', 'Reject', 'Accept'))
)
GO

CREATE TABLE [PostMultimediaFile] (
  [fileId] INT,
  [postId] INT NOT NULL,
  PRIMARY KEY ([fileId], [postId])
)
GO

CREATE TABLE [MultimediaFile] (
  [fileId] INT PRIMARY KEY,
  [fileUrl] CHAR(100) NOT NULL,
  [fileType] nvarchar(255) NOT NULL CHECK ([fileType] IN ('Video', 'Image')),
  [createdAt] DATETIME DEFAULT (CURRENT_TIMESTAMP)
)
GO

CREATE TABLE [Rate] (
  [rateId] INT PRIMARY KEY IDENTITY(1, 1),
  [raterId] INT NOT NULL,
  [numRate] INT NOT NULL,
  [comment] VARCHAR(100) DEFAULT (null),
  [createdAt] DATETIME DEFAULT (CURRENT_TIMESTAMP),
  [postId] INT NOT NULL
)
GO

CREATE TABLE [PostViewHistory] (
  [historyId] INT PRIMARY KEY IDENTITY(1, 1),
  [customerId] INT NOT NULL,
  [postId] INT NOT NULL,
  [viewedAt] DATETIME DEFAULT (CURRENT_TIMESTAMP)
)
GO

CREATE TABLE [SubscriptionAreaPost] (
  [subscriptionId] INT PRIMARY KEY IDENTITY(1, 1),
  [customerId] INT NOT NULL,
  [ward] VARCHAR(70),
  [district] VARCHAR(70) NOT NULL,
  [city] VARCHAR(70) NOT NULL,
  [createdAt] DATETIME NOT NULL DEFAULT 'CURRENT_TIMESTAMP'
)
GO

CREATE TABLE [Message] (
  [messageId] INT PRIMARY KEY IDENTITY(1, 1),
  [sender] INT NOT NULL,
  [senderEntityType] nvarchar(255) NOT NULL CHECK ([senderEntityType] IN ('Admin', 'Customer')),
  [receiver] INT NOT NULL,
  [receiverEntityType] nvarchar(255) NOT NULL CHECK ([receiverEntityType] IN ('Admin', 'Customer')),
  [content] varchar(150) NOT NULL,
  [createdAt] DATETIME NOT NULL DEFAULT 'CURRENT_TIMESTAMP'
)
GO

CREATE TABLE [Report] (
  [reportId] INT PRIMARY KEY IDENTITY(1, 1),
  [senderId] INT NOT NULL,
  [entityId] INT NOT NULL,
  [entityType] nvarchar(255) NOT NULL CHECK ([entityType] IN ('Post', 'Rate', 'User')),
  [status] nvarchar(255) NOT NULL CHECK ([status] IN ('Pending', 'Done')),
  [detail] VARCHAR NOT NULL,
  [createdAt] DATETIME NOT NULL DEFAULT 'CURRENT_TIMESTAMP',
  [handlerId] INT,
  [actionTaken] int NOT NULL,
  [resolutionMessage] VARCHAR(255) DEFAULT (null),
  [resolvedAt] DATETIME NOT NULL DEFAULT 'CURRENT_TIMESTAMP'
)
GO

CREATE TABLE [ActionTaken] (
  [actionId] int PRIMARY KEY,
  [description] varchar(70)
)
GO

CREATE TABLE [AccountPenalty] (
  [penaltyId] INT PRIMARY KEY IDENTITY(1, 1),
  [reportId] INT,
  [penaltyAccountId] INT NOT NULL,
  [penaltyType] nvarchar(255) NOT NULL CHECK ([penaltyType] IN ('Temporary Ban', 'Permanent Ban', 'Warning')),
  [reason] varchar(100) NOT NULL,
  [penaltyStart] DATETIME DEFAULT 'CURRENT_TIMESTAMP',
  [penaltyEnd] DATETIME DEFAULT (null)
)
GO

ALTER TABLE [Account] ADD FOREIGN KEY ([roleId]) REFERENCES [Role] ([roleId])
GO

ALTER TABLE [RolePermission] ADD FOREIGN KEY ([permissionId]) REFERENCES [Permission] ([permissionId])
GO

ALTER TABLE [RolePermission] ADD FOREIGN KEY ([roleId]) REFERENCES [Role] ([roleId])
GO

ALTER TABLE [Admin] ADD FOREIGN KEY ([accountId]) REFERENCES [Account] ([accountId])
GO

ALTER TABLE [Customer] ADD FOREIGN KEY ([accountId]) REFERENCES [Account] ([accountId])
GO

ALTER TABLE [InfoEdition] ADD FOREIGN KEY ([postId]) REFERENCES [Post] ([postId])
GO

ALTER TABLE [PostModerationHistory] ADD FOREIGN KEY ([postId]) REFERENCES [Post] ([postId])
GO

ALTER TABLE [PostModerationHistory] ADD FOREIGN KEY ([adminId]) REFERENCES [Admin] ([adminId])
GO

ALTER TABLE [SavedPost] ADD FOREIGN KEY ([customerId]) REFERENCES [Customer] ([customerId])
GO

ALTER TABLE [SavedPost] ADD FOREIGN KEY ([postId]) REFERENCES [Post] ([postId])
GO

ALTER TABLE [Appointment] ADD FOREIGN KEY ([requesterId]) REFERENCES [Customer] ([customerId])
GO

ALTER TABLE [Appointment] ADD FOREIGN KEY ([postId]) REFERENCES [Post] ([postId])
GO

ALTER TABLE [Post] ADD FOREIGN KEY ([ownerId]) REFERENCES [Customer] ([customerId])
GO

ALTER TABLE [PostMultimediaFile] ADD FOREIGN KEY ([fileId]) REFERENCES [MultimediaFile] ([fileId])
GO

ALTER TABLE [PostMultimediaFile] ADD FOREIGN KEY ([postId]) REFERENCES [Post] ([postId])
GO

ALTER TABLE [Rate] ADD FOREIGN KEY ([raterId]) REFERENCES [Customer] ([customerId])
GO

ALTER TABLE [Rate] ADD FOREIGN KEY ([postId]) REFERENCES [Post] ([postId])
GO

ALTER TABLE [PostViewHistory] ADD FOREIGN KEY ([customerId]) REFERENCES [Customer] ([customerId])
GO

ALTER TABLE [PostViewHistory] ADD FOREIGN KEY ([postId]) REFERENCES [Post] ([postId])
GO

ALTER TABLE [SubscriptionAreaPost] ADD FOREIGN KEY ([customerId]) REFERENCES [Customer] ([customerId])
GO

ALTER TABLE [Message] ADD FOREIGN KEY ([sender]) REFERENCES [Customer] ([customerId])
GO

ALTER TABLE [Message] ADD FOREIGN KEY ([sender]) REFERENCES [Admin] ([adminId])
GO

ALTER TABLE [Report] ADD FOREIGN KEY ([entityId]) REFERENCES [Customer] ([customerId])
GO

ALTER TABLE [Report] ADD FOREIGN KEY ([entityId]) REFERENCES [Post] ([postId])
GO

ALTER TABLE [Report] ADD FOREIGN KEY ([entityId]) REFERENCES [Rate] ([rateId])
GO

ALTER TABLE [Report] ADD FOREIGN KEY ([actionTaken]) REFERENCES [ActionTaken] ([actionId])
GO

ALTER TABLE [Report] ADD FOREIGN KEY ([handlerId]) REFERENCES [Admin] ([adminId])
GO

ALTER TABLE [Report] ADD FOREIGN KEY ([senderId]) REFERENCES [Customer] ([customerId])
GO

ALTER TABLE [AccountPenalty] ADD FOREIGN KEY ([reportId]) REFERENCES [Report] ([reportId])
GO

ALTER TABLE [AccountPenalty] ADD FOREIGN KEY ([penaltyAccountId]) REFERENCES [Account] ([accountId])
GO