--------------------------------TRIGGER----------------------------------------------

CREATE OR REPLACE FUNCTION check_product() RETURNS trigger AS $check_product$
    BEGIN

        IF NEW."name" IS NULL THEN
            RAISE EXCEPTION 'name cannot be null';
        END IF;
        IF NEW.price IS NULL THEN
            RAISE EXCEPTION '% cannot have null price', NEW."name";
        END IF;
        IF NEW.price < 0 THEN
            RAISE EXCEPTION '% cannot have a negative price', NEW."name";
        END IF;
        RETURN NEW;
    END;
$check_product$ LANGUAGE plpgsql;

CREATE TRIGGER check_product BEFORE INSERT OR UPDATE ON “product”
    FOR EACH ROW EXECUTE FUNCTION check_product();


CREATE OR REPLACE FUNCTION logging() RETURNS trigger AS $logging$
    BEGIN
        IF (TG_OP = 'DELETE') THEN
            INSERT INTO log(activity, “date”, user_id) SELECT 'DELETE' || TG_TABLE_NAME, now(), OLD.user_id;
            RETURN OLD;
        ELSIF (TG_OP = 'UPDATE') THEN
            INSERT INTO log SELECT 'UPDATE', now(), NEW.user_id;
            RETURN NEW;
        ELSIF (TG_OP = 'INSERT') THEN
            INSERT INTO log SELECT 'INSERT', now(), NEW.user_id;
            RETURN NEW;
        END IF;
        RETURN NULL;
    END;
$logging$ LANGUAGE plpgsql;


CREATE TRIGGER add_logging
AFTER INSERT OR UPDATE OR DELETE ON review, article, order
    FOR EACH ROW EXECUTE FUNCTION logging();


CREATE OR REPLACE FUNCTION changeCompletionDate() RETURNS TRIGGER AS $date_trigger$
	BEGIN
		IF (NEW.status_id == 4) THEN 
			UPDATE order SET completion_date = now() WHERE order.id = NEW.id;
		RETURN NEW;
	END;
$date_trigger$ LANGUAGE plpgsql;
	
CREATE OR REPLACE TRIGGER date_trigger
	AFTER UPDATE ON order
	FOR EACH ROW EXECUTE FUNCTION changeCompletionDate();	

--------------------------------PROCEDURE----------------------------------------------

CREATE OR REPLACE PROCEDURE update_user(
    "user_id" integer,
    new_name VARCHAR(50),
    new_email VARCHAR(255), 
    new_password VARCHAR(50)
)
AS $$
UPDATE "user" SET "name" = COALESCE(new_name, "name"),  email = COALESCE(new_email, email), "password" = COALESCE(new_password, "password") WHERE "id" = user_id;
$$
LANGUAGE SQL;

CREATE OR REPLACE PROCEDURE update_order(
	order_id integer,
	"new_date" DATE,
	new_completion_date DATE,
	new_quantity integer,
	new_manager_id integer,
	new_product_id integer,
	new_status_id integer,
	new_user_id integer
)
AS $$
	UPDATE "order"
	SET
	"date" = COALESCE(new_date, "date"),
	completion_date = COALESCE(new_completion_date, completion_date),
	quantity = COALESCE(new_quantity, quantity),
	manager_id = COALESCE(new_manager_id, manager_id), 
	product_id = COALESCE(new_product_id, product_id), 
	status_id = COALESCE(new_status_id, status_id),
	user_id = COALESCE(new_user_id, user_id)
	WHERE "id" = order_id;
$$
LANGUAGE SQL;

CREATE OR REPLACE PROCEDURE delete_article(
	article_id integer)
AS $$
DELETE from "article" WHERE "id"=article_id;
$$
LANGUAGE SQL;


CREATE OR REPLACE PROCEDURE delete_account(
	"deleted_user_id" integer
)
AS $$
	    DELETE from "article" WHERE user_id=deleted_user_id;
	    DELETE from "log" WHERE user_id=deleted_user_id;
	    DELETE from "review" WHERE user_id=deleted_user_id;
	    DELETE from "order" WHERE user_id=deleted_user_id;

	    DELETE from "user" WHERE "id"=deleted_user_id;
$$
LANGUAGE SQL;