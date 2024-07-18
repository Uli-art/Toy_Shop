
--------------------------------CREATION----------------------------------------------
CREATE TABLE IF NOT EXISTS "user"(
	id integer PRIMARY KEY, 
	name VARCHAR(50) UNIQUE NOT NULL,
	email VARCHAR(255) UNIQUE NOT NULL,
	password VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS "status"(
	id integer PRIMARY KEY, 
	status VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS "product_type"(
	id integer PRIMARY KEY, 
	type VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS "product"(
	id integer PRIMARY KEY, 
	name VARCHAR(255) UNIQUE NOT NULL,
	type_id integer NOT NULL references product_type(id),
	price NUMERIC NOT NULL,
	in_production BOOL NOT NULL
);

CREATE TABLE IF NOT EXISTS "review"(
	id integer PRIMARY KEY, 
	user_id integer NOT NULL references "user"(id),
	product_id integer NOT NULL references product(id),
	rating integer NOT NULL,
	"text" VARCHAR,
	"date" DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS "article"(
	id integer PRIMARY KEY,
	title VARCHAR(255) NOT NULL,
	short_description VARCHAR NOT NULL,
	main_text VARCHAR NOT NULL,
	image VARCHAR NOT NULL,
	user_id integer NOT NULL,
  	FOREIGN KEY (user_id)
      REFERENCES "user" (id)
);

CREATE TABLE IF NOT EXISTS "position"(
	id integer PRIMARY KEY,
	"position" VARCHAR(50) NOT NULL 
);

CREATE TABLE IF NOT EXISTS "manager_info"(
	id integer PRIMARY KEY,
	"name" VARCHAR(255) NOT NULL,
	surname VARCHAR(255) NOT NULL,
	phone_number VARCHAR(50) NOT NULL,
	position_id integer NOT NULL references "position"(id),
	resume VARCHAR NOT NULL
);

CREATE TABLE IF NOT EXISTS "log"(
	id integer PRIMARY KEY,
	activity VARCHAR NOT NULL,
	"date" DATE NOT NULL,
	user_id integer NOT NULL references "user"(id)
);

CREATE TABLE IF NOT EXISTS "manager"(
	id integer PRIMARY KEY,
	email VARCHAR(255) UNIQUE NOT NULL,
	"password" VARCHAR(255) UNIQUE NOT NULL,
	manager_info_id integer NOT NULL references manager_info(id)
);

CREATE TABLE IF NOT EXISTS "order"(
	id integer PRIMARY KEY,
	"date" DATE NOT NULL,
	completion_date DATE,
	quantity integer NOT NULL,
	manager_id integer NOT NULL references manager(id),
	product_id integer NOT NULL references product(id),
	status_id integer NOT NULL references status(id),
	user_id integer NOT NULL references "user"(id)
);
--------------------------------MODIFICATION----------------------------------------------
ALTER TABLE product
ADD COLUMN image VARCHAR NOT NULL UNIQUE;
--------------------------------INSERTION----------------------------------------------
INSERT INTO "user" (id, name, email, password) 
	VALUES
		(1, 'John', 'john@example.com', 'password123'),
		(2, 'Emily', 'emily@example.com', 'pass123'),
		(3, 'Michael', 'michael@example.com', 'securepassword'),
		(4, 'Sarah', 'sarah@example.com', '12345678'),
		(5, 'David', 'david@example.com', 'p@ssw0rd');		

INSERT INTO status (id, status) 
	VALUES 
		(1, 'Issued'),
		(2, 'In progress'),
		(3, 'Delivery'),
		(4, 'Completed');
		
INSERT INTO product_type (id, type) 
	VALUES 
		(1, 'Constructor'),
		(2, 'Dolls'),
		(3, 'Soft toy'),
		(4, 'Cars');

INSERT INTO product (id, name, type_id, price, image, in_production) 
	VALUES 
		(1, 'LEGO DUPLO Town 10874: Steam Train', 1, 19.49,'/static/toyfactory/images/products/Lego_duplo_town.jpg', true),
		(2, 'Classic doll DISNEY Frozen Elsa', 2, 49.87, '/static/toyfactory/images/products/Elsa.jpg',true),
		(3, 'Soft toy FANCY Capybara Dracula', 3, 29.32, '/static/toyfactory/images/products/Capybara_Dracula.jpg',true),
		(4, 'Toy convertible Nordplast Nymph', 4, 9.64, '/static/toyfactory/images/products/convertible_Nymph.jpg',true),
		(5, 'LOL Surprise OMG doll New Years Queen', 2, 14.90, '/static/toyfactory/images/products/LOL_New_Years_Queen.jpg',true);

INSERT INTO review (id, user_id, product_id, rating, "text", "date") 
	VALUES 
		(1, 1, 1, 5, 'Great toy!', '2021-07-15'),
		(2, 1, 2, 4, 'Good quality', '2021-08-02'),
		(3, 3, 2, 3, 'Average toy', '2021-09-10'),
		(4, 3, 4, 2, 'Not satisfied', '2021-06-25'),
		(5, 5, 4, 1, 'Poor quality', '2021-10-05');

INSERT INTO article (id, title, short_description, main_text, image, user_id) 
	VALUES 
		(1, 'Toy Cars', 'A collection of miniature toy cars', 'These toy cars are perfect for children who love playing with cars.', 'car_image.jpg', 2),
		(2, 'Dolls', 'A variety of dolls for kids', 'These dolls come in different sizes and designs, perfect for imaginative play.', 'doll_image.jpg', 3),
		(3, 'Building Blocks', 'Colorful building blocks for creative play', 'These building blocks help enhance childrens problem-solving and motor skills.', 'blocks_image.jpg', 4),
		(4, 'Stuffed Animals', 'Soft and cuddly stuffed animals', 'These stuffed animals are great companions for kids, providing comfort and imaginative play.', 'stuffed_animals_image.jpg', 4),
		(5, 'Board Games', 'Fun and educational board games', 'These board games are designed to entertain and educate children, making learning enjoyable.', 'board_games_image.jpg', 2);

INSERT INTO "position" (id, "position") 
	VALUES 
		(1, 'Manager'),
		(2, 'Assistant Manager'),
		(3, 'General Manager'),
		(4, 'Store Manager'),
		(5, 'Operations Manager');


INSERT INTO manager_info (id, name, surname, phone_number, position_id, resume) 
	VALUES 
		(1, 'John', 'Doe', '123-456-7890', 1, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
		(2, 'Jane', 'Smith', '987-654-3210', 2, 'Nulla nec justo eget felis facilisis fermentum.'),
		(3, 'Michael', 'Johnson', '555-555-5555', 3, 'Etiam consequat mi et mi rhoncus rutrum.'),
		(4, 'Emily', 'Davis', '111-222-3333', 1, 'Praesent auctor quam nec orci aliquam, at commodo nisl pulvinar.'),
		(5, 'David', 'Wilson', '444-444-4444', 2, 'Sed sed mauris lacinia, imperdiet orci nec, congue tortor.');

INSERT INTO "log" (id, activity, date, user_id) 
	VALUES 
		(1, 'Received new toy order', '2022-01-01', 1),
		(2, 'Started production of toy', '2022-01-02', 2),
		(3, 'Completed packaging of toy', '2022-01-03', 3),
		(4, 'Shipped toy to customer', '2022-01-04', 5),
		(5, 'Delivered toy to customer', '2022-01-05', 5);

INSERT INTO manager (id, email, password, manager_info_id)
	VALUES 
		(1, 'John@gmail.com', 'password1', 1),
		(2, 'Jane@gmail.com', 'password2', 3),
		(3, 'Michael@gmail.com', 'password3', 3),
		(4, 'Emily@gmail.com', 'password4', 4),
		(5, 'David@gmail.com', 'password5', 5);

INSERT INTO "order" (id, "date", completion_date, quantity, manager_id, product_id, status_id, user_id) 
	VALUES 
		(1, '2023-01-01', null, 10, 1, 2, 1, 3),
		(2, '2023-02-01', '2023-02-05', 5, 1, 2, 2, 5),
		(3, '2023-03-01', '2023-03-05', 8, 5, 3, 3, 3),
		(4, '2023-04-01', null, 12, 4, 3, 2, 4),
		(5, '2023-05-01', '2023-05-05', 15, 5, 5, 1, 5);
--------------------------------SELECTION----------------------------------------------
SELECT * FROM "user";
SELECT * FROM "status";
SELECT * FROM "product_type";
SELECT * FROM "product";
SELECT * FROM "review";
SELECT * FROM "article";
SELECT * FROM "position";
SELECT * FROM "manager_info";
SELECT * FROM "log";
SELECT * FROM "manager";
SELECT * FROM "order";

SELECT "date" AS Дата, completion_date, quantity AS Количество FROM "order";

SELECT ROUND(price, 1) AS Rounded_price FROM "product";

SELECT "name", price, type_id
	FROM product
	WHERE type_id IN (1, 3);

SELECT "id", quantity
FROM "order"
WHERE completion_date IS NULL;

SELECT "name", price
	FROM product
	WHERE price BETWEEN 15 AND 20;

SELECT surname, "name", position_id
	FROM manager_info
	WHERE position_id = 1
	ORDER BY surname DESC, "name" DESC;

SELECT surname, "name", phone_number
	FROM manager_info
	WHERE phone_number LIKE '%4%';

SELECT "name", email
	FROM "user"
	WHERE "id" in (SELECT DISTINCT user_id FROM "order")
	ORDER BY "id";

SELECT type_id, MIN(price) AS min_price
	FROM product
	GROUP BY type_id
	ORDER BY min_price;

SELECT "type"
	FROM product_type
	WHERE "id" IN (SELECT type_id
			FROM product
			GROUP BY type_id
			HAVING MIN(price) > 15);
--------------------------------DELETION----------------------------------------------
DELETE FROM "order" USING "user"
WHERE user_id = "user".id and "user".name = 'Michael';
DROP TABLE IF EXISTS "order";
TRUNCATE "log";
--------------------------------INDEXING----------------------------------------------
CREATE INDEX type_index ON product_type("type");
CREATE INDEX position_index ON position("position");
DROP INDEX type_index;


UPDATE review SET rating = 2 WHERE "id" = 2;

--------------------------------Запросы с несколькими условиями----------------------------------------------

SELECT "id", quantity
FROM "order"
WHERE completion_date IS NOT NULL AND user_id = 5;

SELECT activity
FROM "log"
WHERE user_id = 5 AND "date" BETWEEN '2022-01-01' AND '2022-02-01';

SELECT "id", "name"
FROM "user"
WHERE "id" IN (SELECT user_id
		FROM article) AND "id" NOT IN (SELECT user_id
						FROM review);
--------------------------------Запросы с вложенными конструкциями----------------------------------------------

SELECT "id", "name"
FROM "product"
WHERE price = (SELECT MIN(price)
		FROM product);

SELECT "id", "name", email
FROM "user"
WHERE "id" IN (SELECT "user_id"
		FROM review
		GROUP BY user_id
		HAVING AVG(rating) > 3);

SELECT "id", "name"
FROM "product"
WHERE "id" IN (SELECT product_id
		FROM review
		GROUP BY product_id
		HAVING AVG(rating) > (SELECT AVG(rating) FROM review));

SELECT "id", "date", quantity*(SELECT price
				FROM product
				WHERE product.id = product_id) AS total_price
FROM "order";
--------------------------------JOIN-запросы различных видов----------------------------------------------

SELECT email, count(product_id) as "Count"
FROM manager LEFT JOIN "order"
ON manager.id = "order".manager_id
GROUP BY email
ORDER BY "Count" DESC, email;


SELECT "type", ROUND(AVG(price), 2) AS Average_price
FROM product INNER JOIN product_type
ON product.type_id = product_type.id
GROUP BY "type"
ORDER BY Average_price DESC;

--------------------------------Пул SQL запросов для получения сгруппированных данных----------------------------------------------
SELECT email, "password"
FROM "user"
UNION SELECT email, "password"
FROM manager
ORDER BY email;

--------------------------------Оконные функции----------------------------------------------

SELECT "name",rating, ROUND(AVG(rating) OVER (PARTITION BY product_id order by rating), 2)
FROM "review" INNER JOIN "product"
ON review.product_id = product.id
ORDER BY "name";
--------------------------------Пул SQL запросов для сложных операций с данными----------------------------------------------

SELECT "name"
FROM "user"
WHERE NOT EXISTS (
  SELECT user_id
  FROM "order"
  WHERE user_id = "user".id);

SELECT "name", CASE type_id WHEN 1 THEN ROUND(price*0.95, 2)
              		    WHEN 2 THEN ROUND(price*0.9, 2)
			    WHEN 3 THEN ROUND(price*0.85, 2)
                	    ELSE price END AS sale, price
FROM product;
