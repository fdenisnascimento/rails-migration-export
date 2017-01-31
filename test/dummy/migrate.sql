CREATE TABLE "orders" ("id" serial primary key, "external_id" character varying, "number" character varying, "reference" character varying, "status" integer, "notes" character varying, "price" integer, "remaining" integer DEFAULT 0, "paid_amount" integer DEFAULT 0, "merchant_id" character varying(40), "uuid" character varying(40), "deleted_at" timestamp, "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL) ;
CREATE  INDEX  "index_orders_on_external_id" ON "orders"  ("external_id");
CREATE  INDEX  "index_orders_on_number" ON "orders"  ("number");
CREATE  INDEX  "index_orders_on_reference" ON "orders"  ("reference");
CREATE  INDEX  "index_orders_on_status" ON "orders"  ("status");
CREATE UNIQUE INDEX  "index_orders_on_uuid" ON "orders"  ("uuid");
CREATE  INDEX  "index_orders_on_deleted_at" ON "orders"  ("deleted_at");
CREATE TABLE "items" ("id" serial primary key, "sku" character varying, "name" character varying, "description" character varying, "unit_price" integer, "quantity" integer, "unit_of_measure" character varying, "details" character varying, "reference" character varying, "uuid" character varying, "order_id" integer, "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL) ;
CREATE  INDEX  "index_items_on_order_id" ON "items"  ("order_id");
ALTER TABLE "items" ADD CONSTRAINT "fk_rails_53153f3b4b"
FOREIGN KEY ("order_id")
  REFERENCES "orders" ("id")
;
CREATE  INDEX  "index_items_on_sku" ON "items"  ("sku");
CREATE UNIQUE INDEX  "index_items_on_uuid" ON "items"  ("uuid");
CREATE TABLE "payment_transactions" ("id" serial primary key, "uuid" character varying, "external_id" character varying, "transaction_type" character varying, "status" character varying, "description" character varying, "terminal_number" character varying, "number" character varying, "authorization_code" character varying, "amount" integer, "order_id" integer, "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL) ;
CREATE  INDEX  "index_payment_transactions_on_order_id" ON "payment_transactions"  ("order_id");
ALTER TABLE "payment_transactions" ADD CONSTRAINT "fk_rails_1ccedddf37"
FOREIGN KEY ("order_id")
  REFERENCES "orders" ("id")
;
CREATE UNIQUE INDEX  "index_payment_transactions_on_uuid" ON "payment_transactions"  ("uuid");
CREATE  INDEX  "index_payment_transactions_on_terminal_number" ON "payment_transactions"  ("terminal_number");
CREATE  INDEX  "index_payment_transactions_on_number" ON "payment_transactions"  ("number");
CREATE  INDEX  "index_payment_transactions_on_authorization_code" ON "payment_transactions"  ("authorization_code");
CREATE TABLE "cards" ("id" serial primary key, "brand" character varying, "mask" character varying, "payment_transaction_id" integer, "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL) ;
CREATE  INDEX  "index_cards_on_payment_transaction_id" ON "cards"  ("payment_transaction_id");
ALTER TABLE "cards" ADD CONSTRAINT "fk_rails_38a89d5f87"
FOREIGN KEY ("payment_transaction_id")
  REFERENCES "payment_transactions" ("id")
;
CREATE TABLE "payment_products" ("id" serial primary key, "number" integer, "name" character varying, "payment_transaction_id" integer, "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL) ;
CREATE  INDEX  "index_payment_products_on_payment_transaction_id" ON "payment_products"  ("payment_transaction_id");
ALTER TABLE "payment_products" ADD CONSTRAINT "fk_rails_2147054422"
FOREIGN KEY ("payment_transaction_id")
  REFERENCES "payment_transactions" ("id")
;
CREATE  INDEX  "index_payment_products_on_number" ON "payment_products"  ("number");
CREATE  INDEX  "index_payment_products_on_name" ON "payment_products"  ("name");
CREATE TABLE "payment_services" ("id" serial primary key, "number" integer, "name" character varying, "payment_product_id" integer, "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL) ;
CREATE  INDEX  "index_payment_services_on_payment_product_id" ON "payment_services"  ("payment_product_id");
ALTER TABLE "payment_services" ADD CONSTRAINT "fk_rails_43e6fbeb5f"
FOREIGN KEY ("payment_product_id")
  REFERENCES "payment_products" ("id")
;
CREATE  INDEX  "index_payment_services_on_number" ON "payment_services"  ("number");
CREATE  INDEX  "index_payment_services_on_name" ON "payment_services"  ("name");
CREATE TABLE "merchants" ("id" serial primary key, "name" character varying, "number" character varying, "email" character varying, "uuid" character varying(40), "notification_url" character varying, "deleted_at" timestamp, "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL) ;
CREATE  INDEX  "index_merchants_on_number" ON "merchants"  ("number");
CREATE  INDEX  "index_merchants_on_deleted_at" ON "merchants"  ("deleted_at");
CREATE UNIQUE INDEX  "index_merchants_on_uuid" ON "merchants"  ("uuid");
CREATE TABLE "terminals" ("id" serial primary key, "number" character varying, "uuid" character varying(40), "merchant_id" integer, "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL) ;
CREATE  INDEX  "index_terminals_on_merchant_id" ON "terminals"  ("merchant_id");
ALTER TABLE "terminals" ADD CONSTRAINT "fk_rails_279ea92902"
FOREIGN KEY ("merchant_id")
  REFERENCES "merchants" ("id")
;
CREATE  INDEX  "index_terminals_on_number" ON "terminals"  ("number");
CREATE UNIQUE INDEX  "index_terminals_on_uuid" ON "terminals"  ("uuid");
ALTER TABLE "items" ALTER COLUMN "quantity" SET DEFAULT 1;
ALTER TABLE "items" ADD "sku_type" character varying;
ALTER TABLE "orders" ADD "terminal_id" integer;
CREATE  INDEX  "index_orders_on_terminal_id" ON "orders"  ("terminal_id");
ALTER TABLE "orders" ADD CONSTRAINT "fk_rails_34f71ad554"
FOREIGN KEY ("terminal_id")
  REFERENCES "terminals" ("id")
;
INSERT INTO schema_migrations (version) VALUES ('20160804171954'); 
INSERT INTO schema_migrations (version) VALUES ('20160804172943'); 
INSERT INTO schema_migrations (version) VALUES ('20160804194544'); 
INSERT INTO schema_migrations (version) VALUES ('20160804195047'); 
INSERT INTO schema_migrations (version) VALUES ('20160804200434'); 
INSERT INTO schema_migrations (version) VALUES ('20160804200529'); 
INSERT INTO schema_migrations (version) VALUES ('20160806201036'); 
INSERT INTO schema_migrations (version) VALUES ('20160806201142'); 
INSERT INTO schema_migrations (version) VALUES ('20160822181952'); 
INSERT INTO schema_migrations (version) VALUES ('20161005174126'); 
INSERT INTO schema_migrations (version) VALUES ('20170113175858'); 
