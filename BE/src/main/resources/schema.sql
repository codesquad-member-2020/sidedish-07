DROP TABLE IF EXISTS user;

CREATE TABLE user (
    id INT auto_increment primary key ,
    email varchar(64) not null
);
