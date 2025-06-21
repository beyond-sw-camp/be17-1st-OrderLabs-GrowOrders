use test;

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS board;
DROP TABLE IF EXISTS comment;
DROP TABLE IF EXISTS notifications;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS delivery;
DROP TABLE IF EXISTS farm;
DROP TABLE IF EXISTS crops_state;
DROP TABLE IF EXISTS crops;
DROP TABLE IF EXISTS region;
DROP TABLE IF EXISTS weather;
DROP TABLE IF EXISTS region;
DROP TABLE IF EXISTS predictions;
DROP TABLE IF EXISTS inventory;

CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    email VARCHAR(20) NOT NULL UNIQUE,
    birth_date DATETIME NOT NULL,
    phone_number VARCHAR(13),
    created_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    home_number VARCHAR(20) UNIQUE,
    address VARCHAR(50) NOT NULL,
    role ENUM('User', 'Productor') NOT NULL,
    password_hash VARCHAR(100) NOT NULL
);

CREATE TABLE board (
    board_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    users_id BIGINT NOT NULL,
    updated_at TIMESTAMP NULL DEFAULT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    del_yn VARCHAR(1) DEFAULT 'N',
    title VARCHAR(255),
    contents VARCHAR(3000) NOT NULL,
    FOREIGN KEY (users_id) REFERENCES users(id)
);

CREATE TABLE comment (
    idx BIGINT AUTO_INCREMENT PRIMARY KEY,
    board_id BIGINT NOT NULL,
    comment VARCHAR(1000),
    comment_date DATE,
    FOREIGN KEY (board_id) REFERENCES board(board_id)
);

CREATE TABLE notifications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    status ENUM('sent', 'failed', 'read') NOT NULL,
    title VARCHAR(50),
    content VARCHAR(255),
    created_at DATE,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE farm (
    farm_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE crops (
    id INT NOT NULL,
    farm_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    item_name VARCHAR(50),
    start_date DATE,
    area DATE,
    status ENUM('growing', 'finished', 'discarded'),
    PRIMARY KEY (id, farm_id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (farm_id) REFERENCES farm(farm_id)
);

CREATE TABLE crops_state (
    idx INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    crops_id INT NOT NULL,
    farm_id BIGINT NOT NULL,
    crops_state VARCHAR(50),
    growth_size FLOAT,
    health_state VARCHAR(50),
    sow_start_date DATE,
    price FLOAT,
    FOREIGN KEY (crops_id) REFERENCES crops(id),
    FOREIGN KEY (farm_id) REFERENCES farm(farm_id)
);

CREATE TABLE orders (
    order_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    crop_id INT NOT NULL,
    quantity INT NOT NULL,
    price INT NOT NULL,
    status VARCHAR(50),
    request VARCHAR(50),
    date DATE,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (crop_id) REFERENCES crops(id)
);

CREATE TABLE delivery (
    id_delivery BIGINT AUTO_INCREMENT PRIMARY KEY,
    delivery_id BIGINT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    de_yn VARCHAR(1) DEFAULT 'N',
    courier VARCHAR(255),
    billing_number VARCHAR(255),
    delivery_at TIMESTAMP,
    delivery_status ENUM('ready', 'shipping', 'delivered', 'cancelled'),
    FOREIGN KEY (delivery_id) REFERENCES orders(order_id)
);


CREATE TABLE region (
    region_id VARCHAR(10) PRIMARY KEY,
    farm_id BIGINT NOT NULL,
    latitude DECIMAL(8,6) NOT NULL,
    longitude DECIMAL(9,6) NOT NULL,
    FOREIGN KEY (farm_id) REFERENCES farm(farm_id)
);

CREATE TABLE weather (
    observation_time DATETIME NOT NULL,
    region_id VARCHAR(10) NOT NULL,
    temp_avg FLOAT,
    humidity FLOAT,
    solar_radiation FLOAT,
    PRIMARY KEY (observation_time, region_id),
    FOREIGN KEY (region_id) REFERENCES region(region_id)
);

CREATE TABLE predictions (
    idx BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    crops_id INT NOT NULL,
    farm_id BIGINT,
    predicted_harvest_date DATE,
    predicted_quantity INT,
    created_at DATE,
    FOREIGN KEY (crops_id) REFERENCES crops(id),
    FOREIGN KEY (farm_id) REFERENCES farm(farm_id)
);

CREATE TABLE inventory (
    idx INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    crops_id INT NOT NULL,
    farm_id BIGINT NOT NULL,
    expected_harvest_date DATE,
    expected_quantity INT,
    FOREIGN KEY (crops_id) REFERENCES crops(id),
    FOREIGN KEY (farm_id) REFERENCES farm(farm_id)
);