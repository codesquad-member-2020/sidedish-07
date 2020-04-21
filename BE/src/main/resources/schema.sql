DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS badge;
DROP TABLE IF EXISTS delivery;
DROP TABLE IF EXISTS thumb_image;
DROP TABLE IF EXISTS detail_image;
DROP TABLE IF EXISTS product_category;
DROP TABLE IF EXISTS product_badge;
DROP TABLE IF EXISTS product_delivery;

CREATE TABLE product (
    hash INT auto_increment primary key ,
    menu enum ('main', 'soup', 'side') ,
    title varchar(64) not null ,
    description varchar(64) not null ,
    s_price INT ,
    n_price INT not null
);

CREATE TABLE category (
    id INT auto_increment primary key ,
    name varchar(64) not null
);

CREATE TABLE badge (
    id INT auto_increment primary key ,
    name varchar(64) not null
);

CREATE TABLE delivery (
    id INT auto_increment primary key ,
    name varchar(64) not null
);

CREATE TABLE thumb_image (
    id INT auto_increment primary key ,
    url varchar(128) not null ,
    product INT references product(hash)
);

CREATE TABLE detail_image (
    id INT auto_increment primary key ,
    url varchar(128) not null ,
    product INT references product(hash)
);

-- m:n 맵핑을 위한 테이블
CREATE TABLE product_category (
    product INT references product(hash) ,
    categroy INT references category(id) ,
    PRIMARY KEY (product, categroy)
);

CREATE TABLE product_badge (
    product INT references product(hash) ,
    badge INT references badge(id) ,
    PRIMARY KEY (product, badge)
);

CREATE TABLE product_delivery (
    product INT references product(hash) ,
    badge INT references badge(id) ,
    fee INT not null ,
    info varchar(62) not null ,
    PRIMARY KEY (product, badge)
);
