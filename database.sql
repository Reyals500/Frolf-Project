-- Creating the 'users' table
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    handicap INT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP
);

-- Creating the 'courses' table
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(255) NOT NULL,
    location VARCHAR(255) NOT NULL,
    total_holes INT,
    par INT,
    length INT,
    difficulty VARCHAR(255),
    amenities TEXT
);

-- Creating the 'scores' table
CREATE TABLE scores (
    score_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id) ON DELETE CASCADE,
    course_id INT REFERENCES courses(course_id) ON DELETE CASCADE,
    date_played DATE,
    total_score INT,
    scores_per_hole TEXT,  -- JSON or array format; ensure your DB supports this, or use a JSONB type in PostgreSQL
    weather_conditions VARCHAR(255)
);

-- Creating the 'discs' table
CREATE TABLE discs (
    disc_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id) ON DELETE CASCADE,
    type VARCHAR(255),
    weight FLOAT,
    color VARCHAR(255),
    brand VARCHAR(255)
);

-- Creating the 'events' table
CREATE TABLE events (
    event_id SERIAL PRIMARY KEY,
    event_name VARCHAR(255) NOT NULL,
    description TEXT,
    start_date DATE,
    end_date DATE,
    course_id INT REFERENCES courses(course_id) ON DELETE SET NULL
);

-- Creating the 'user_events' table
CREATE TABLE user_events (
    user_id INT REFERENCES users(user_id) ON DELETE CASCADE,
    event_id INT REFERENCES events(event_id) ON DELETE CASCADE,
    registered_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    score_id INT REFERENCES scores(score_id) ON DELETE SET NULL
);

-- Creating the 'reviews' table
CREATE TABLE reviews (
    review_id SERIAL PRIMARY KEY,
    course_id INT REFERENCES courses(course_id) ON DELETE CASCADE,
    user_id INT REFERENCES users(user_id) ON DELETE CASCADE,
    rating INT,
    comment TEXT,
    date_posted TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Creating the 'friendships' table
CREATE TABLE friendships (
    user1_id INT REFERENCES users(user_id) ON DELETE CASCADE,
    user2_id INT REFERENCES users(user_id) ON DELETE CASCADE,
    status VARCHAR(255),
    initiated_by INT REFERENCES users(user_id),
    established_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user1_id, user2_id)
);
