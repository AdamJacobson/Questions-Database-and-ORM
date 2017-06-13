CREATE TABLE users (
  user_id serial PRIMARY KEY,
  fname varchar (50) NOT NULL,
  lname varchar (50) NOT NUll
);

CREATE TABLE questions (
  question_id serial PRIMARY KEY,
  title varchar (140) NOT NULL,
  body text NOT NULL,
  user_id integer REFERENCES users(user_id) NOT NULL
);

CREATE TABLE question_follows (
  user_id integer REFERENCES users(user_id) NOT NULL,
  question_id integer REFERENCES questions(question_id) NOT NULL
);

CREATE TABLE replies (
  reply_id serial PRIMARY KEY,
  body TEXT NOT NULL,
  question_id INTEGER REFERENCES questions(question_id) NOT NULL,
  parent_id INTEGER REFERENCES replies(reply_id),
  user_id INTEGER REFERENCES users(user_id)
);

CREATE TABLE question_likes (
  user_id INTEGER REFERENCES users(user_id) NOT NULL,
  question_id INTEGER REFERENCES questions(question_id) NOT NULL
);

-- SEED DATA

INSERT INTO
  users (fname, lname)
VALUES
  ("Adam", "Jacobson"),
  ("Atom", "Crimi");

INSERT INTO
  questions(title, body, user_id)
VALUES
  ("Are we killing hack reactor students?", "^^^^^",
    SELECT user_id FROM users WHERE fname = "Atom"
  ),
  ("Hunting tips for HR students", "Bows vs guns?",
    SELECT user_id FROM users WHERE fname = "Adam"
  );

INSERT INTO
  replies (body, question_id, user_id)
VALUES
  ("No", 1, 1),
  ("Bows", 2, 2);

INSERT INTO
  question_follows (user_id, question_id)
VALUES
  (1, 1),
  (2, 2);

INSERT INTO
  question_likes (user_id, question_id)
VALUES
  (1, 1),
  (2, 2);
