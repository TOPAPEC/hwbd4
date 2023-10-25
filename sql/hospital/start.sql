-- Создаем базу данных
CREATE DATABASE hospital;

-- Используем созданную базу данных
\c hospital;

CREATE TABLE "stations" (
  "id" INTEGER PRIMARY KEY,
  "name" VARCHAR(255)
);

CREATE TABLE "personnel" (
  "id" INTEGER PRIMARY KEY,
  "name" VARCHAR(255),
  "station_id" INTEGER
);

CREATE TABLE "doctors" (
  "id" INTEGER PRIMARY KEY,
  "name" VARCHAR(255),
  "area" VARCHAR(255),
  "rank" VARCHAR(255),
  "station_id" INTEGER
);

CREATE TABLE "caregivers" (
  "id" INTEGER PRIMARY KEY,
  "name" VARCHAR(255),
  "qualification" VARCHAR(255),
  "station_id" INTEGER
);

CREATE TABLE "patients" (
  "id" INTEGER PRIMARY KEY,
  "name" VARCHAR(255),
  "disease" VARCHAR(255),
  "room_id" INTEGER,
  "admission_from" DATE,
  "admission_to" DATE
);

CREATE TABLE "rooms" (
  "id" INTEGER PRIMARY KEY,
  "station_id" INTEGER,
  "room_number" INTEGER,
  "num_of_beds" INTEGER
);

CREATE TABLE "treats" (
  "id" INTEGER PRIMARY KEY,
  "patient_id" INTEGER,
  "person_id" INTEGER
);

ALTER TABLE "personnel" ADD FOREIGN KEY ("station_id") REFERENCES "stations" ("id");

ALTER TABLE "doctors" ADD FOREIGN KEY ("station_id") REFERENCES "stations" ("id");

ALTER TABLE "caregivers" ADD FOREIGN KEY ("station_id") REFERENCES "stations" ("id");

ALTER TABLE "patients" ADD FOREIGN KEY ("room_id") REFERENCES "rooms" ("id");

ALTER TABLE "rooms" ADD FOREIGN KEY ("station_id") REFERENCES "stations" ("id");

ALTER TABLE "treats" ADD FOREIGN KEY ("patient_id") REFERENCES "patients" ("id");

ALTER TABLE "treats" ADD FOREIGN KEY ("person_id") REFERENCES "personnel" ("id");

INSERT INTO "stations" ("id", "name")
VALUES (1, 'Hospital One'),
       (2, 'Hospital Two'),
       (3, 'Hospital Three');

INSERT INTO "personnel" ("id", "name", "station_id")
VALUES (1, 'John Smith', 1),
       (2, 'Jane Doe', 2),
       (3, 'Michael Johnson', 1),
       (4, 'Emily Brown', 3);

INSERT INTO "doctors" ("id", "name", "area", "rank", "station_id")
VALUES (1, 'Dr. Robert Jones', 'Cardiology', 'MD', 1),
       (2, 'Dr. Elizabeth Davis', 'Pediatrics', 'MD', 2),
       (3, 'Dr. William Wilson', 'Orthopedics', 'MD', 1),
       (4, 'Dr. Jennifer Taylor', 'Neurology', 'MD', 3);

INSERT INTO "caregivers" ("id", "name", "qualification", "station_id")
VALUES (1, 'Mary Moore', 'Certified Nurse Assistant', 1),
       (2, 'Lisa Harris', 'Licensed Practical Nurse', 2),
       (3, 'Joseph Clark', 'Registered Nurse', 1),
       (4, 'Barbara Jones', 'Registered Nurse', 3);

INSERT INTO "patients" ("id", "name", "disease", "room_id", "admission_from", "admission_to")
VALUES (1, 'Christopher Lewis', 'Flu', 1, '2022-01-12', '2022-01-17'),
       (2, 'Patricia Garcia', 'Appendicitis', 2, '2022-01-19', '2022-01-25'),
       (3, 'Thomas Young', 'Cholecystitis', 3, '2022-02-01', '2022-02-10'),
       (4, 'Sarah Walker', 'Malaria', 4, '2022-03-01', '2022-03-08');

INSERT INTO "rooms" ("id", "station_id", "room_number", "num_of_beds")
VALUES (1, 1, 101, 2),
       (2, 1, 102, 2),
       (3, 2, 201, 1),
       (4, 2, 202, 1),
       (5, 3, 301, 3),
       (6, 3, 302, 2);

INSERT INTO "treats" ("id", "patient_id", "person_id")
VALUES (1, 1, 1),
       (2, 1, 2),
       (3, 2, 3),
       (4, 2, 4),
       (5, 3, 1),
       (6, 3, 3),
       (7, 4, 1),
       (8, 4, 2);