DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id INTEGER PRIMARY KEY,

  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NUll
);

DROP TABLE IF EXISTS questions;
CREATE TABLE questions (
  id INTEGER PRIMARY KEY,

  title VARCHAR(255) NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_follows;
CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,

  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

DROP TABLE IF EXISTS replies;
CREATE TABLE replies (
  id INTEGER PRIMARY KEY,

  question_id INTEGER NOT NULL,
  parent_id INTEGER,
  user_id INTEGER NOT NULL,
  body TEXT NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_id) REFERENCES replies(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_likes;
CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,

  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

-- SEED DATA

INSERT INTO
  users (fname, lname)
VALUES
  ("Adam", "Jacobson"),
  ("Atom", "Crimi");

INSERT INTO
  questions (title, body, user_id)
VALUES
  ("Are we killing hack reactor students?", "^^^^^",
    (SELECT id FROM users WHERE fname = "Atom")
  ),
  ("Hunting tips for HR students", "Bows vs guns?",
    (SELECT id FROM users WHERE fname = "Adam")
  );

INSERT INTO
  replies (body, question_id, parent_id, user_id)
VALUES
  ("No", 1, NULL, 1),
  ("Bows", 2, NULL, 2),
  ("LOL", 2, 2, 2);

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
