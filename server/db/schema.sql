CREATE DATABASE IF NOT EXISTS stockpilot CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE stockpilot;
CREATE TABLE IF NOT EXISTS products (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  sku VARCHAR(40) NOT NULL UNIQUE,
  name VARCHAR(120) NOT NULL,
  category VARCHAR(80) NOT NULL DEFAULT 'General',
  price DECIMAL(12,2) NOT NULL,
  stock_quantity INT UNSIGNED NOT NULL DEFAULT 0,
  reorder_level INT UNSIGNED NOT NULL DEFAULT 5,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_products_name (name),
  INDEX idx_products_stock (stock_quantity, reorder_level)
);
CREATE TABLE IF NOT EXISTS orders (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  product_id BIGINT UNSIGNED NOT NULL,
  quantity INT UNSIGNED NOT NULL,
  unit_price DECIMAL(12,2) NOT NULL,
  total_amount DECIMAL(14,2) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_orders_product FOREIGN KEY (product_id) REFERENCES products(id),
  INDEX idx_orders_created_at (created_at)
);
INSERT INTO products (sku,name,category,price,stock_quantity,reorder_level) VALUES
('EL-104','Wireless Keyboard','Electronics',1499,42,10),
('OF-220','A4 Notebook Pack','Office supplies',249,8,12),
('EL-116','USB-C Hub','Electronics',2199,6,8),
('FN-031','Desk Organizer','Furniture',799,31,10),
('OF-221','Whiteboard Markers','Office supplies',180,4,15)
ON DUPLICATE KEY UPDATE sku=VALUES(sku);
