-- USER is a reserved keyword with Postgres
-- You must use double quotes in every query that user is in:
-- ex. SELECT * FROM "user";
-- Otherwise you will have errors!
CREATE TABLE "user" (
    "id" SERIAL PRIMARY KEY,
    "username" VARCHAR (80) UNIQUE NOT NULL,
    "password" VARCHAR (1000) NOT NULL
);
CREATE TABLE "course" (
    "id" SERIAL PRIMARY KEY,
    "name" VARCHAR (255) UNIQUE NOT NULL,
    "location" VARCHAR (255) NOT NULL,
    "par" INTEGER NOT NULL
);

CREATE TABLE "score" (
    "id" SERIAL PRIMARY KEY,
    "user_id" INTEGER REFERENCES "user"("id"),
    "course_id" INTEGER REFERENCES "course"("id"),
    "score" INTEGER NOT NULL,
    "date_played" DATE NOT NULL
);
