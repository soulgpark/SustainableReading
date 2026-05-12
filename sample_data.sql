-- 유저 삽입
INSERT INTO Users (Name, Email, Country, City, Preferences, PasswordHash)
VALUES ('Jay', 'jay@example.com', 'USA', 'New York', '["E-Book"]', 'hashed_password123');

-- 도서 삽입
INSERT INTO Books (Title, Author, Publisher, Year, ISBN)
VALUES ('The Vegetarian', 'Han Kang', 'Random House Publishing Group', 2016, '9781101906118');

-- 전자책 형식 삽입
INSERT INTO Formats (BookID, Type, Weight, DigitalFileSize, Attributes)
VALUES (1, 'E-Book', NULL, 6.562, '{"ASIN": "B00X2F7NRI", "TextToSpeech": true, "EnhancedTypesetting": true, "ScreenReader": true}');

-- 종이책 형식 삽입
INSERT INTO Formats (BookID, Type, Weight, DigitalFileSize, Attributes)
VALUES (1, 'Paper', 2.31, NULL, '{"ASIN": "1101906111", "Dimensions": "5.19 x 0.55 x 7.95", "Pages": 208}');

-- 전자책 환경 데이터 (FormatID=1)
INSERT INTO EnvironmentalImpact (FormatID, CarbonEmission, EnergyConsumption, WaterUsage, Recyclability)
VALUES (1, 0.8, 1.5, 0.0, 0);

-- 종이책 환경 데이터 (FormatID=2)
INSERT INTO EnvironmentalImpact (FormatID, CarbonEmission, EnergyConsumption, WaterUsage, Recyclability)
VALUES (2, 4.5, 0.0, 15.0, 1);
