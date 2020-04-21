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
    id INT auto_increment primary key ,
    hash varchar(5) unique not null ,
    menu enum ('MAIN', 'SOUP', 'SIDE') ,
    title varchar(64) ,
    description varchar(64) not null ,
    s_price INT ,
    n_price INT not null ,
    delivery_fee varchar(64) not null ,
    delivery_possible varchar(64) not null
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
    product varchar(5) references product(id)
);

CREATE TABLE detail_image (
    id INT auto_increment primary key ,
    url varchar(128) not null ,
    product varchar(5) references product(id)
);

-- m:n 맵핑을 위한 테이블
CREATE TABLE product_category (
    product INT references product(id) ,
    categroy INT references category(id) ,
    PRIMARY KEY (product, categroy)
);

CREATE TABLE product_badge (
    product INT references product(id) ,
    badge INT references badge(id) ,
    PRIMARY KEY (product, badge)
);

CREATE TABLE product_delivery (
    product INT references product(id) ,
    delivery INT references delivery(id) ,
    PRIMARY KEY (product, delivery)
);
