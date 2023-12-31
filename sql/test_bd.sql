-- Создаем базу данных
CREATE DATABASE testdb;

-- Используем созданную базу данных
\c testdb;

CREATE TABLE "publishers" (
  "id" INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "name" VARCHAR(255),
  "address" VARCHAR(255)
);

CREATE TABLE "categories" (
  "id" INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "name" VARCHAR(255),
  "parent_category_id" INTEGER
);

CREATE TABLE "books" (
  "id" INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "isbn" VARCHAR(13) UNIQUE,
  "title" VARCHAR(255),
  "author" VARCHAR(255),
  "publication_year" INTEGER,
  "number_of_pages" INTEGER,
  "category_id" INTEGER,
  "publisher_id" INTEGER
);

CREATE TABLE "copies" (
  "id" INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "book_id" INTEGER,
  "shelf_position" VARCHAR(255)
);

CREATE TABLE "readers" (
  "id" INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "first_name" VARCHAR(255),
  "last_name" VARCHAR(255),
  "address" VARCHAR(255),
  "birth_date" DATE
);

CREATE TABLE "borrowings" (
  "id" INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "reader_id" INTEGER,
  "copy_id" INTEGER,
  "planned_return_date" DATE
);

ALTER TABLE "categories" ADD FOREIGN KEY ("parent_category_id") REFERENCES "categories" ("id");

ALTER TABLE "books" ADD FOREIGN KEY ("category_id") REFERENCES "categories" ("id");

ALTER TABLE "books" ADD FOREIGN KEY ("publisher_id") REFERENCES "publishers" ("id");

ALTER TABLE "copies" ADD FOREIGN KEY ("book_id") REFERENCES "books" ("id");

ALTER TABLE "borrowings" ADD FOREIGN KEY ("reader_id") REFERENCES "readers" ("id");

ALTER TABLE "borrowings" ADD FOREIGN KEY ("copy_id") REFERENCES "copies" ("id");

INSERT INTO "publishers" ("name", "address")
VALUES ('Penguin Random House', '1745 Broadway, New York, NY 10019'),
       ('HarperCollins Publishers', '195 Broadway, New York, NY 10007'),
       ('Simon & Schuster', '1230 Avenue of the Americas, New York, NY 10020'),
       ('Hachette Book Group', '1290 Avenue of the Americas, New York, NY 10104'),
       ('Macmillan Publishers', '120 Broadway, New York, NY 10271');

INSERT INTO "categories" ("name", "parent_category_id")
VALUES ('Fiction', NULL),
       ('Science fiction', 1),
       ('Mystery', 1),
       ('Non-fiction', NULL),
       ('Biography', 4),
       ('History', 4);

INSERT INTO "books" ("isbn", "title", "author", "publication_year", "number_of_pages", "category_id", "publisher_id")
VALUES ('9780451524935', '1984', 'George Orwell', 1949, 328, 2, 1),
       ('9780140449136', 'Crime and Punishment', 'Fyodor Dostoevsky', 1866, 480, 3, 1),
       ('9780064436229', 'The Wright Brothers', 'David McCullough', 2015, 320, 5, 2),
       ('9781501127944', 'The Art of War', 'Sun Tzu', 2017, 160, 6, 3),
       ('9780802124664', 'City on Fire', 'Garth Risk Hallberg', 2015, 944, 1, 4),
       ('9780316244205', 'The Providence of Fire', 'Brian Staveley', 2015, 608, 2, 4),
       ('9781780108743', 'The Wrong Man', 'Claire McGowan', 2017, 256, 3, 5),
       ('9780062301253', 'The Demon Under the Microscope', 'Thomas Hager', 2006, 352, 4, 2);

INSERT INTO "copies" ("book_id", "shelf_position")
VALUES (1, 'A1.1'),
       (1, 'A1.2'),
       (2, 'A2.1'),
       (2, 'A2.2'),
       (3, 'B1.1'),
       (3, 'B1.2'),
       (4, 'B2.1'),
       (4, 'B2.2'),
       (5, 'A3.1'),
       (6, 'A3.2'),
       (7, 'B3.1'),
       (8, 'B3.2');

INSERT INTO "readers" ("first_name", "last_name", "address", "birth_date")
VALUES ('Emily', 'Johnson', '123 Elm St, New York, NY 10001', '1990-06-15'),
       ('Olivia', 'Smith', '456 Oak St, New York, NY 10002', '1995-01-10'),
       ('Mason', 'Martinez', '789 Maple St, New York, NY 10003', '1986-08-20'),
       ('Li', 'Wong', '987 Cypress St, New York, NY 10004', '2002-04-15');

INSERT INTO "borrowings" ("reader_id", "copy_id", "planned_return_date")
VALUES (1, 1, '2022-09-17'),
       (2, 4, '2022-09-07'),
       (3, 5, '2022-09-10'),
       (4, 8, '2022-09-12');