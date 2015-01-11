CREATE SEQUENCE uid;
CREATE SEQUENCE pid;
CREATE SEQUENCE cid;

CREATE TABLE users (
  uid INTEGER PRIMARY KEY DEFAULT NEXTVAL('uid'),
  login CHAR(64),
  password CHAR(64),
  email CHAR(64),
  status INTEGER,
  created INTEGER
);

CREATE TABLE photo (
  pid INTEGER PRIMARY KEY DEFAULT NEXTVAL('pid'),
  creator_id INTEGER,
  path CHAR(64),
  title CHAR(255),
  created INTEGER,
  status INTEGER
);

CREATE TABLE photo_relation (
  pid INTEGER,
  uid INTEGER,
  created INTEGER
);

CREATE TABLE comment (
  cid INTEGER PRIMARY KEY DEFAULT NEXTVAL('cid'),
  body CHAR(255),
  created INTEGER,
  updated INTEGER,
  status INTEGER,
);

CREATE TABLE comment_relation (
  cid INTEGER,
  uid INTEGER,
  pid INTEGER
);
