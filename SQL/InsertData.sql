# Questions
INSERT INTO security_question(Question) VALUES ('Father?');
INSERT INTO security_question(Question) VALUES ('Mother?');
INSERT INTO security_question(Question) VALUES ('Birth City?');

# Admin
INSERT INTO user VALUES ('Mobin', 'abcd1234', 1, 'Ali', 'Admin');
INSERT INTO user VALUES ('Homa', 'abcd1234', 1, 'Ali', 'Admin');

# Driver User Samples
INSERT INTO user VALUES ('Soheil', 'abcd1234', 1, 'Nima', 'Driver');
INSERT INTO user VALUES ('Sobhan', 'abcd1234', 1, 'Hojat', 'Driver');
INSERT INTO user VALUES ('Qolam', 'abcd1234', 1, 'Mamad', 'Driver');
INSERT INTO user VALUES ('Ali', 'abcd1234', 1, 'Reza', 'Driver');
INSERT INTO user VALUES ('MrMx', 'abcd1234', 1, 'Soheil', 'Driver');
INSERT INTO user VALUES ('A.Reza', 'abcd1234', 1, 'Hormazd', 'Driver');
INSERT INTO user VALUES ('Hojat733', 'abcd1234', 1, 'Amin', 'Driver');
INSERT INTO user VALUES ('Soroush', 'abcd1234', 1, 'Tooraj', 'Driver');
INSERT INTO user VALUES ('Hssn', 'abcd1234', 1, 'Abbas', 'Driver');

# Driver Samples
INSERT INTO driver(ID, NationalID, FirstName, LastName, City, Region, Lat, Lng)
    VALUES ('Soheil', '0926754329', 'Soheil', 'Qolami', 'Mashhad', 'Khayam', 36.314265, 59.566522);
INSERT INTO driver(ID, NationalID, FirstName, LastName, City, Region, Lat, Lng)
    VALUES ('Sobhan', '0925648765', 'Sobhan', 'Rezayian', 'Mashhad', 'Moalem', 36.331830, 59.507473);
INSERT INTO driver(ID, NationalID, FirstName, LastName, City, Region, Lat, Lng)
    VALUES ('Qolam', '0914356786', 'Qolamreza', 'Takhti', 'Mashhad', 'NaderShahr', 36.350912, 59.485351);
INSERT INTO driver(ID, NationalID, FirstName, LastName, City, Region, Lat, Lng)
    VALUES ('Ali', '0924564327', 'Alimohammad', 'Molayi', 'Mashhad', 'Sajad', 36.318553, 59.550968);
INSERT INTO driver(ID, NationalID, FirstName, LastName, City, Region, Lat, Lng)
    VALUES ('MrMx', '0924356786', 'MohammadReza', 'Sabeqi', 'Mashhad', 'Sajad', 36.318953, 59.550068);
INSERT INTO driver(ID, NationalID, FirstName, LastName, City, Region, Lat, Lng)
    VALUES ('A.Reza', '0934567457', 'Alireza', 'Esfahani', 'Mashhad', 'NaderShahr', 36.351012, 59.485951);
INSERT INTO driver(ID, NationalID, FirstName, LastName, City, Region, Lat, Lng)
    VALUES ('Hojat733', '0108375643', 'Hojat', 'Sargol', 'Mashhad', 'Moalem', 36.331330, 59.509473);
INSERT INTO driver(ID, NationalID, FirstName, LastName, City, Region, Lat, Lng)
    VALUES ('Soroush', '0917654657', 'Soroush', 'Tahani', 'Mashhad', 'Moalem', 36.334830, 59.508573);
INSERT INTO driver(ID, NationalID, FirstName, LastName, City, Region, Lat, Lng)
    VALUES ('Hssn', '0936754565', 'Hossein', 'Niko', 'Mashhad', 'Khayam', 36.317265, 59.566822);

# Charity User Samples
INSERT INTO user VALUES ('Saeed', 'abcd1234', 1, 'Hesam', 'Charity');
INSERT INTO user VALUES ('Hamid', 'abcd1234', 1, 'Morteza', 'Charity');
INSERT INTO user VALUES ('Maryam', 'abcd1234', 1, 'Amir', 'Charity');
INSERT INTO user VALUES ('Reza', 'abcd1234', 1, 'Sina', 'Charity');
INSERT INTO user VALUES ('AliV', 'abcd1234', 1, 'Naqi', 'Charity');
INSERT INTO user VALUES ('Afshin75', 'abcd1234', 1, 'Taqi', 'Charity');
INSERT INTO user VALUES ('Sl.Javad', 'abcd1234', 1, 'Reza', 'Charity');
INSERT INTO user VALUES ('Nima3', 'abcd1234', 1, 'Mahdi', 'Charity');
INSERT INTO user VALUES ('MamadKhafan', 'abcd1234', 1, 'Hamidreza', 'Charity');

# Charity Samples
INSERT INTO charity(ID, Name, Population, City, Region, Lat, Lng, FoundationYear)
    VALUES ('Saeed', 'YaranX', 20, 'Mashhad', 'Khayam', 36.306934, 59.557659, 1970);
INSERT INTO charity(ID, Name, Population, City, Region, Lat, Lng, FoundationYear)
    VALUES ('Hamid', 'Mehrabona', 50, 'Mashhad', 'Ahmadabad', 36.296835, 59.580473, 1985);
INSERT INTO charity(ID, Name, Population, City, Region, Lat, Lng, FoundationYear)
    VALUES ('Maryam', 'HameKhoba', 100, 'Mashhad', 'Ahmadabad', 36.296935, 59.580073, 1990);
INSERT INTO charity(ID, Name, Population, City, Region, Lat, Lng, FoundationYear)
    VALUES ('Reza', 'XCharity', 200, 'Mashhad', 'NaderShahr', 36.350869, 59.489042, 1975);
INSERT INTO charity(ID, Name, Population, City, Region, Lat, Lng, FoundationYear)
    VALUES ('AliV', '13YareKhob', 45, 'Mashhad', 'NaderShahr', 36.350969, 59.490342, 1978);
INSERT INTO charity(ID, Name, Population, City, Region, Lat, Lng, FoundationYear)
    VALUES ('Afshin75', 'YCharity', 76, 'Mashhad', 'NaderShahr', 36.350769, 59.490682, 1982);
INSERT INTO charity(ID, Name, Population, City, Region, Lat, Lng, FoundationYear)
    VALUES ('Sl.Javad', 'ZCharity', 124, 'Mashhad', 'NaderShahr', 36.350469, 59.490982, 1987);
INSERT INTO charity(ID, Name, Population, City, Region, Lat, Lng, FoundationYear)
    VALUES ('Nima3', 'MohammadZade', 176, 'Mashhad', 'Ahmadabad', 36.296535, 59.580773, 1960);
INSERT INTO charity(ID, Name, Population, City, Region, Lat, Lng, FoundationYear)
    VALUES ('MamadKhafan', 'MolaAli', 23, 'Mashhad', 'Khayam', 36.306734, 59.557359, 1997);

# Restaurant User Samples
INSERT INTO user VALUES ('Sina', 'abcd1234', 1, 'Arash', 'Restaurant');
INSERT INTO user VALUES ('Akbar', 'abcd1234', 1, 'Qoli', 'Restaurant');
INSERT INTO user VALUES ('Ahmad', 'abcd1234', 1, 'Ali', 'Restaurant');
INSERT INTO user VALUES ('Mostafa', 'abcd1234', 1, 'Asqar', 'Restaurant');
INSERT INTO user VALUES ('Sara', 'abcd1234', 1, 'Javad', 'Restaurant');
INSERT INTO user VALUES ('Nilo', 'abcd1234', 1, 'Akbar', 'Restaurant');
INSERT INTO user VALUES ('Mahtab', 'abcd1234', 1, 'Qolam', 'Restaurant');
INSERT INTO user VALUES ('Nafiseh', 'abcd1234', 1, 'Mahdi', 'Restaurant');
INSERT INTO user VALUES ('KitKate', 'abcd1234', 1, 'Mahdi', 'Restaurant');

# Restaurant Samples
INSERT INTO restaurant(ID, Name, City, Region, Lat, Lng)
    VALUES ('Mostafa', 'PesaraneAsqar', 'Mashhad', 'Ahmadabad', 36.292269, 59.580245);
INSERT INTO restaurant(ID, Name, City, Region, Lat, Lng)
    VALUES ('Sina', 'AmmoSina', 'Mashhad', 'Eqbal', 36.331361, 59.473327);
INSERT INTO restaurant(ID, Name, City, Region, Lat, Lng)
    VALUES ('Akbar', 'AkbarAqa', 'Mashhad', 'Kosar', 36.310545, 59.509698);
INSERT INTO restaurant(ID, Name, City, Region, Lat, Lng)
    VALUES ('Ahmad', 'AhmadJoje', 'Mashhad', 'NaderShahr', 36.353484, 59.484480);
INSERT INTO restaurant(ID, Name, City, Region, Lat, Lng)
    VALUES ('Sara', 'SaraPaz', 'Mashhad', 'NaderShahr', 36.353684, 59.484180);
INSERT INTO restaurant(ID, Name, City, Region, Lat, Lng)
    VALUES ('Nilo', 'NiloKhane', 'Mashhad', 'NaderShahr', 36.353784, 59.484180);
INSERT INTO restaurant(ID, Name, City, Region, Lat, Lng)
    VALUES ('Mahtab', 'QazayeKhob', 'Mashhad', 'Kosar', 36.310845, 59.509998);
INSERT INTO restaurant(ID, Name, City, Region, Lat, Lng)
    VALUES ('Nafiseh', 'BehtarinQaza', 'Mashhad', 'Ahmadabad', 36.292569, 59.580745);
INSERT INTO restaurant(ID, Name, City, Region, Lat, Lng)
    VALUES ('Kitkate', 'Khoshpaz', 'Mashhad', 'Ahmadabad', 36.292669, 59.580382);

INSERT INTO contract(RestaurantID, CharityID)
    VALUES ('Ahmad', 'Saeed'), ('Ahmad', 'Reza'),
           ('Akbar', 'Saeed'), ('Akbar', 'Maryam'),
           ('Sina', 'Reza'), ('Akbar', 'Hamid');

INSERT INTO delivery(RestaurantID, DriverID, CharityID, Count, State, Rate)
    VALUES ('Ahmad', 'Sobhan', 'Saeed', 5, 'Done', 3);
INSERT INTO delivery(RestaurantID, DriverID, CharityID, Count, State, Rate)
    VALUES ('Akbar', 'MrMx', 'Hamid', 15, 'Done', 4);
INSERT INTO delivery(RestaurantID, DriverID, CharityID, Count, State, Rate)
    VALUES ('Akbar', 'Soheil', 'Maryam', 10, 'Done', 4);
INSERT INTO delivery(RestaurantID, DriverID, CharityID, Count, State, Rate)
    VALUES ('Sina', 'Soheil', 'Reza', 20, 'Done', 5);
INSERT INTO delivery(RestaurantID, DriverID, CharityID, Count, State, Rate)
    VALUES ('Sina', 'Qolam', 'Reza', 13, 'Done', 5);
INSERT INTO delivery(RestaurantID, CharityID, Count)
    VALUES ('Sina', 'Reza', 50);
INSERT INTO delivery(RestaurantID, CharityID, Count)
    VALUES ('Ahmad', 'Reza', 12);
INSERT INTO delivery(RestaurantID, CharityID, Count)
    VALUES ('Ahmad', 'Saeed', 12);