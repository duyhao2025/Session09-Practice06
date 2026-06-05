CREATE DATABASE procedure_product_practice;

CREATE TABLE Products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price NUMERIC(10,2) NOT NULL,
    category_id INT NOT NULL
);

INSERT INTO Products (name, price, category_id)
VALUES
('Laptop A', 1000, 1),
('Laptop B', 1200, 1),
('Phone A', 500, 2),
('Phone B', 700, 2),
('Tablet A', 800, 3);

CREATE OR REPLACE PROCEDURE update_product_price(
    IN p_category_id INT,
    IN p_increase_percent NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_product_id INT;
    v_price NUMERIC;
    v_new_price NUMERIC;
BEGIN
    FOR v_product_id, v_price IN
        SELECT product_id, price
        FROM Products
        WHERE category_id = p_category_id
    LOOP
        v_new_price := v_price + (v_price * p_increase_percent / 100);

        UPDATE Products
        SET price = v_new_price
        WHERE product_id = v_product_id;
    END LOOP;
END;
$$;

SELECT * FROM Products;

CALL update_product_price(1, 10);

SELECT * FROM Products;