PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "schema_migrations" ("version" varchar NOT NULL PRIMARY KEY);
INSERT INTO schema_migrations VALUES('20230323063644');
INSERT INTO schema_migrations VALUES('20230327005219');
INSERT INTO schema_migrations VALUES('20230405074109');
INSERT INTO schema_migrations VALUES('20230408082357');
CREATE TABLE IF NOT EXISTS "ar_internal_metadata" ("key" varchar NOT NULL PRIMARY KEY, "value" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
INSERT INTO ar_internal_metadata VALUES('environment','development','2023-03-23 06:37:07.395798','2023-03-23 06:37:07.395798');
CREATE TABLE IF NOT EXISTS "stocks" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "ticker" varchar, "name" varchar, "last_price" decimal, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
INSERT INTO stocks VALUES(1,'GOOG','Alphabet',1300,'2023-03-27 00:55:05.925936','2023-03-27 00:55:05.925936');
INSERT INTO stocks VALUES(2,'AAPL','Apple inc.',NULL,'2023-04-05 07:57:49.035455','2023-04-05 07:57:49.035455');
INSERT INTO stocks VALUES(4,'AMZN','Amazon inc.',NULL,'2023-04-05 08:04:45.559165','2023-04-05 08:04:45.559165');
INSERT INTO stocks VALUES(5,'TSLA','Tesla Inc',NULL,'2023-04-06 05:48:17.425789','2023-04-06 05:48:17.425789');
INSERT INTO stocks VALUES(6,'C','Citigroup Inc',NULL,'2023-04-06 06:21:35.098787','2023-04-06 06:21:35.098787');
INSERT INTO stocks VALUES(7,'MSFT','Microsoft Corporation',NULL,'2023-04-06 06:22:12.805787','2023-04-06 06:22:12.805787');
INSERT INTO stocks VALUES(8,'AL','Air Lease Corporation',NULL,'2023-04-06 06:24:31.359297','2023-04-06 06:24:31.359297');
INSERT INTO stocks VALUES(9,'JPM','JPMorgan Chase & Co',NULL,'2023-04-06 06:32:16.454646','2023-04-06 06:32:16.454646');
INSERT INTO stocks VALUES(10,'NFLX','Netflix Inc',NULL,'2023-04-06 06:40:18.671693','2023-04-06 06:40:18.671693');
INSERT INTO stocks VALUES(11,'GS','Goldman Sachs Group Inc',NULL,'2023-04-06 06:43:53.062361','2023-04-06 06:43:53.062361');
INSERT INTO stocks VALUES(12,'AP','Ampco-Pittsburgh Corporation',NULL,'2023-04-06 06:46:51.424984','2023-04-06 06:46:51.424984');
INSERT INTO stocks VALUES(13,'a','Agilent Technologies Inc',NULL,'2023-04-06 07:00:20.354912','2023-04-06 07:00:20.354912');
INSERT INTO stocks VALUES(14,'AA','Alcoa Corp',NULL,'2023-04-06 07:46:57.134579','2023-04-06 07:46:57.134579');
INSERT INTO stocks VALUES(15,'al','Air Lease Corporation',NULL,'2023-04-06 07:48:14.274866','2023-04-06 07:48:14.274866');
INSERT INTO stocks VALUES(16,'A','Agilent Technologies Inc',NULL,'2023-04-06 08:02:16.939542','2023-04-06 08:02:16.939542');
CREATE TABLE IF NOT EXISTS "user_stocks" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer NOT NULL, "stock_id" integer NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, CONSTRAINT "fk_rails_15a036aef2"
FOREIGN KEY ("user_id")
  REFERENCES "users" ("id")
, CONSTRAINT "fk_rails_62699afff5"
FOREIGN KEY ("stock_id")
  REFERENCES "stocks" ("id")
);
CREATE TABLE IF NOT EXISTS "users" ("id" integer NOT NULL PRIMARY KEY, "email" varchar DEFAULT '' NOT NULL, "encrypted_password" varchar DEFAULT '' NOT NULL, "reset_password_token" varchar DEFAULT NULL, "reset_password_sent_at" datetime(6) DEFAULT NULL, "remember_created_at" datetime(6) DEFAULT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, "first_name" varchar, "last_name" varchar);
INSERT INTO users VALUES(1,'momo@momo.com','$2a$12$WVS5XdeTbuqBCpaNfSf7ceUSnSLHFM.HTY5ZbLC4nkkvdIKJTK.G6',NULL,NULL,NULL,'2023-03-23 06:41:03.478291','2023-03-23 06:41:03.478291',NULL,NULL);
INSERT INTO users VALUES(2,'momo1@momo.com','$2a$12$zCJkZJMeLALZ7NvY/MciJOuvInt0uFQBmCzsCPFGeHDUCJu17Ff8W',NULL,NULL,NULL,'2023-04-05 07:54:03.213534','2023-04-05 07:54:03.213534',NULL,NULL);
INSERT INTO users VALUES(3,'momo2@momo.com','$2a$12$brYqKykpDRKSe7Sxwy.RZuIvX7/ze8YNm.eDZ525gjcIv41SeE22a',NULL,NULL,NULL,'2023-04-05 07:54:35.624301','2023-04-05 07:54:35.624301',NULL,NULL);
DELETE FROM sqlite_sequence;
INSERT INTO sqlite_sequence VALUES('stocks',16);
CREATE INDEX "index_user_stocks_on_user_id" ON "user_stocks" ("user_id");
CREATE INDEX "index_user_stocks_on_stock_id" ON "user_stocks" ("stock_id");
CREATE UNIQUE INDEX "index_users_on_email" ON "users" ("email");
CREATE UNIQUE INDEX "index_users_on_reset_password_token" ON "users" ("reset_password_token");
COMMIT;
