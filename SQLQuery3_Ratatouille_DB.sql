--USE [master]
--GO
-- drop DATABASE [Ratatouille]
--CREATE DATABASE [Ratatouille]
--USE [Ratatouille]
--GO

CREATE TABLE [dbo].[Restaurant_table](
    [restaurant_id] [int]  PRIMARY KEY identity(1,1),
    [restaurant_title] [nvarchar](255) NOT NULL
)

CREATE TABLE [dbo].[Chef_table](
    [chef_id] [int] PRIMARY KEY identity(1,1),
    [chef_title] [nvarchar](255) NOT NULL
)

CREATE TABLE [dbo].[Food_table](
    [food_id] [int] PRIMARY KEY identity(1,1),
    [food_title] [nvarchar](255) NOT NULL,
    [restaurant_id] [int] NOT NULL,
    [project_year] [int] NOT NULL
)

----------------------------------------------------------------------------
CREATE TABLE [dbo].[Food_chef_table](
    [food_id] [int] NOT NULL,
    [chef_id] [int] NOT NULL
)

CREATE TABLE [dbo].[Restaurant_chef_table](
    [restaurant_id] [int] NOT NULL,
    [chef_id] [int] NOT NULL
)

GO
ALTER TABLE [dbo].[Food_chef_table] WITH CHECK ADD FOREIGN KEY([chef_id])
REFERENCES [dbo].[Chef_table] ([chef_id])
GO
ALTER TABLE [dbo].[Food_chef_table] WITH CHECK ADD FOREIGN KEY([food_id])
REFERENCES [dbo].[Food_table] ([food_id])
GO
ALTER TABLE [dbo].[Food_table] WITH CHECK ADD FOREIGN KEY([restaurant_id])
REFERENCES [dbo].[Restaurant_table] ([restaurant_id])
GO
ALTER TABLE [dbo].[Restaurant_chef_table] WITH CHECK ADD FOREIGN KEY([chef_id])
REFERENCES [dbo].[Chef_table] ([chef_id])
GO
ALTER TABLE [dbo].[Restaurant_chef_table] WITH CHECK ADD FOREIGN KEY([restaurant_id])
REFERENCES [dbo].[Restaurant_table] ([restaurant_id])
GO

--USE [master]
--GO
--ALTER DATABASE [Ratatouille] SET READ_WRITE 
--GO


-----------------------------------------------------------------
--Å— ò—œ‰ ÃœÊ· —” Ê—«‰ùÂ« (Restaurant_table)

SET IDENTITY_INSERT [Restaurant_table] ON
INSERT [dbo].[Restaurant_table] ([restaurant_id], [restaurant_title]) VALUES (1, N'Noma')
INSERT [dbo].[Restaurant_table] ([restaurant_id], [restaurant_title]) VALUES (2, N'Per Se')
INSERT [dbo].[Restaurant_table] ([restaurant_id], [restaurant_title]) VALUES (3, N'Gaggan')
SET IDENTITY_INSERT [Restaurant_table] OFF
GO
--Å— ò—œ‰ ÃœÊ· ¬‘Å“Â« (Chef_table)
SET IDENTITY_INSERT [Chef_table] ON
INSERT [dbo].[Chef_table] ([chef_id], [chef_title]) VALUES (1, N'Gordon Ramsay')
INSERT [dbo].[Chef_table] ([chef_id], [chef_title]) VALUES (2, N'Julia Child')
INSERT [dbo].[Chef_table] ([chef_id], [chef_title]) VALUES (3, N'Alain Ducasse')
INSERT [dbo].[Chef_table] ([chef_id], [chef_title]) VALUES (4, N'Thomas Keller')
INSERT [dbo].[Chef_table] ([chef_id], [chef_title]) VALUES (5, N'Martin Berasategui')
SET IDENTITY_INSERT [Chef_table] OFF
GO
--Å— ò—œ‰ ÃœÊ· €–«Â« (Food_table)
SET IDENTITY_INSERT [Food_table] ON
INSERT [dbo].[Food_table] ([food_id], [food_title], [restaurant_id], [project_year]) VALUES (1, N'Pasta Alfredo', 1, 2025)
INSERT [dbo].[Food_table] ([food_id], [food_title], [restaurant_id], [project_year]) VALUES (2, N'Flamenco', 2, 2025)
INSERT [dbo].[Food_table] ([food_id], [food_title], [restaurant_id], [project_year]) VALUES (3, N'Steak', 3, 2025)
INSERT [dbo].[Food_table] ([food_id], [food_title], [restaurant_id], [project_year]) VALUES (4, N'Chocolate Dessert', 1, 2024)
INSERT [dbo].[Food_table] ([food_id], [food_title], [restaurant_id], [project_year]) VALUES (5, N'Sushi', 3, 2024)
INSERT [dbo].[Food_table] ([food_id], [food_title], [restaurant_id], [project_year]) VALUES (6, N'Pizza', 1, 2025)
SET IDENTITY_INSERT [Food_table] OFF
GO
--Å— ò—œ‰ Ãœ«Ê· Ê«”ÿ



INSERT [dbo].[Food_chef_table] ([food_id], [chef_id]) VALUES (1, 1)
INSERT [dbo].[Food_chef_table] ([food_id], [chef_id]) VALUES (1, 2)
INSERT [dbo].[Food_chef_table] ([food_id], [chef_id]) VALUES (2, 3)
INSERT [dbo].[Food_chef_table] ([food_id], [chef_id]) VALUES (3, 4)
GO
--ÃœÊ· Restaurant_chef_table

INSERT [dbo].[Restaurant_chef_table] ([restaurant_id], [chef_id]) VALUES (1, 1)
INSERT [dbo].[Restaurant_chef_table] ([restaurant_id], [chef_id]) VALUES (1, 2)
INSERT [dbo].[Restaurant_chef_table] ([restaurant_id], [chef_id]) VALUES (1, 5)
INSERT [dbo].[Restaurant_chef_table] ([restaurant_id], [chef_id]) VALUES (2, 3)
INSERT [dbo].[Restaurant_chef_table] ([restaurant_id], [chef_id]) VALUES (2, 4)
INSERT [dbo].[Restaurant_chef_table] ([restaurant_id], [chef_id]) VALUES (3, 1)
GO