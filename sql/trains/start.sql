-- Создаем базу данных
CREATE DATABASE trains;

-- Используем созданную базу данных
\c trains;

CREATE TABLE City (
  Name VARCHAR(255) NOT NULL,
  Region VARCHAR(255) NOT NULL,
  PRIMARY KEY (Name),
  UNIQUE (Name, Region)
);

CREATE TABLE Station (
  Name VARCHAR(255) PRIMARY KEY,
  Tracks INTEGER NOT NULL,
  CityName VARCHAR(255) NOT NULL,
  Region VARCHAR(255) NOT NULL,
  FOREIGN KEY (CityName, Region) REFERENCES City(Name, Region)
);

CREATE TABLE Train (
  TrainNr INTEGER PRIMARY KEY,
  Length INTEGER NOT NULL,
  StartStationName VARCHAR(255) NOT NULL,
  EndStationName VARCHAR(255) NOT NULL,
  FOREIGN KEY (StartStationName) REFERENCES Station(Name),
  FOREIGN KEY (EndStationName) REFERENCES Station(Name)
);

CREATE TABLE Connection (
  FromStation VARCHAR(255) NOT NULL,
  ToStation VARCHAR(255) NOT NULL,
  TrainNr INTEGER NOT NULL,
  Departure TIMESTAMP NOT NULL,
  Arrival TIMESTAMP NOT NULL,
  FOREIGN KEY (FromStation) REFERENCES Station(Name),
  FOREIGN KEY (ToStation) REFERENCES Station(Name),
  FOREIGN KEY (TrainNr) REFERENCES Train(TrainNr),
  PRIMARY KEY (FromStation, ToStation, TrainNr)
);

INSERT INTO City (Name, Region) VALUES
  ('Moscow', 'Central'),
  ('Saint-Petersburg', 'Northwestern'),
  ('Kazan', 'Volga'),
  ('Nizhny Novgorod', 'Volga'),
  ('Samara', 'Volga');

INSERT INTO Station (Name, Tracks, CityName, Region) VALUES
  ('MoscowCentral', 10, 'Moscow', 'Central'),
  ('Saint-PetersburgCentral', 8, 'Saint-Petersburg', 'Northwestern'),
  ('KazanCentral', 5, 'Kazan', 'Volga'),
  ('NizhnyNovgorodCentral', 6, 'Nizhny Novgorod', 'Volga'),
  ('SamaraCentral', 4, 'Samara', 'Volga');

INSERT INTO Train (TrainNr, Length, StartStationName, EndStationName) VALUES
  (1, 15, 'MoscowCentral', 'Saint-PetersburgCentral'),
  (2, 10, 'Saint-PetersburgCentral', 'KazanCentral'),
  (3, 20, 'KazanCentral', 'NizhnyNovgorodCentral'),
  (4, 30, 'NizhnyNovgorodCentral', 'SamaraCentral'),
  (5, 25, 'SamaraCentral', 'MoscowCentral');

INSERT INTO Connection (FromStation, ToStation, TrainNr, Departure, Arrival) VALUES
  ('MoscowCentral', 'Saint-PetersburgCentral', 1, '2022-08-01 10:00:00', '2022-08-01 16:00:00'),
  ('Saint-PetersburgCentral', 'KazanCentral', 2, '2022-08-01 12:00:00', '2022-08-01 22:00:00'),
  ('KazanCentral', 'NizhnyNovgorodCentral', 3, '2022-08-01 15:00:00', '2022-08-01 19:00:00'),
  ('NizhnyNovgorodCentral', 'SamaraCentral', 4, '2022-08-01 17:00:00', '2022-08-01 23:00:00'),
  ('SamaraCentral', 'MoscowCentral', 5, '2022-08-01 20:00:00', '2022-08-02 02:00:00');