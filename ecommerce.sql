CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;
CREATE TABLE brand (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description TEXT
) ENGINE=InnoDB;

CREATE TABLE product_category (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description TEXT
) ENGINE=InnoDB;

CREATE TABLE product (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  brand_id INT,
  category_id INT,
  base_price DECIMAL(10,2) NOT NULL,
  description TEXT,
  FOREIGN KEY (brand_id) REFERENCES brand(id),
  FOREIGN KEY (category_id) REFERENCES product_category(id)
) ENGINE=InnoDB;

CREATE TABLE color (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  hex_code VARCHAR(7)
) ENGINE=InnoDB;

CREATE TABLE size_category (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE size_option (
  id INT AUTO_INCREMENT PRIMARY KEY,
  size_category_id INT NOT NULL,
  value VARCHAR(50) NOT NULL,
  FOREIGN KEY (size_category_id) REFERENCES size_category(id)
) ENGINE=InnoDB;

CREATE TABLE product_variation (
  id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT NOT NULL,
  size_option_id INT,
  color_id INT,
  FOREIGN KEY (product_id) REFERENCES product(id),
  FOREIGN KEY (size_option_id) REFERENCES size_option(id),
  FOREIGN KEY (color_id) REFERENCES color(id)
) ENGINE=InnoDB;

CREATE TABLE product_item (
  id INT AUTO_INCREMENT PRIMARY KEY,
  variation_id INT NOT NULL,
  sku VARCHAR(50) UNIQUE NOT NULL,
  stock_quantity INT DEFAULT 0,
  price DECIMAL(10,2),
  FOREIGN KEY (variation_id) REFERENCES product_variation(id)
) ENGINE=InnoDB;

CREATE TABLE product_image (
  id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT NOT NULL,
  url VARCHAR(255) NOT NULL,
  FOREIGN KEY (product_id) REFERENCES product(id)
) ENGINE=InnoDB;

CREATE TABLE attribute_category (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE attribute_type (
  id INT AUTO_INCREMENT PRIMARY KEY,
  category_id INT NOT NULL,
  name VARCHAR(100) NOT NULL,
  data_type ENUM('text','number','boolean','date') DEFAULT 'text',
  FOREIGN KEY (category_id) REFERENCES attribute_category(id)
) ENGINE=InnoDB;

CREATE TABLE product_attribute (
  id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT NOT NULL,
  attribute_type_id INT NOT NULL,
  value TEXT,
  FOREIGN KEY (product_id) REFERENCES product(id),
  FOREIGN KEY (attribute_type_id) REFERENCES attribute_type(id)
) ENGINE=InnoDB;