CREATE TYPE "product_size" AS ENUM (
  'R',
  'L',
  'XL',
  '250gr'
);

CREATE TYPE "status" AS ENUM (
  'On Progress',
  'Shipping',
  'Done'
);

CREATE TYPE "shipping" AS ENUM (
  'Delivery',
  'Dine In',
  'Pick Up'
);

CREATE TYPE "temperature" AS ENUM (
  'Hot',
  'Ice'
);

CREATE TABLE "users" (
    "id" serial PRIMARY KEY,
    "first_name" varchar(100) NOT NULL,
    "last_name" varchar(100) NOT NULL,
    "email" varchar(100) UNIQUE NOT NULL,
    "role" varchar(20) NOT NULL DEFAULT 'costumer',
    "password" text NOT NULL,
    "created_at" timestamp DEFAULT (CURRENT_TIMESTAMP),
    "updated_at" timestamp DEFAULT (CURRENT_TIMESTAMP),
    "created_by" int,
    "updated_by" int
);

CREATE TABLE "profiles" (
    "id" serial PRIMARY KEY,
    "user_id" int,
    "image" text,
    "address" varchar(100),
    "phone_number" varchar(20),
    "created_at" timestamp DEFAULT (CURRENT_TIMESTAMP),
    "updated_at" timestamp DEFAULT (CURRENT_TIMESTAMP),
    "created_by" int,
    "updated_by" int
);

CREATE TABLE "carts" (
    "id" serial PRIMARY KEY,
    "user_id" int,
    "product_id" int,
    "amount" int,
    "subtotal" numeric(10, 2),
    "size" product_size DEFAULT 'R',
    "temperature" temperature DEFAULT 'Ice',
    "created_at" timestamp DEFAULT (CURRENT_TIMESTAMP),
    "updated_at" timestamp DEFAULT (CURRENT_TIMESTAMP),
    "created_by" int,
    "updated_by" int
);

CREATE TABLE "products" (
    "id" serial PRIMARY KEY,
    "name" varchar(100) UNIQUE NOT NULL,
    "description" text NOT NULL,
    "price" float NOT NULL,
    "discount" float,
    "rating" float DEFAULT 5,
    "isFlashSale" bool DEFAULT false,
    "stock" int,
    "is_active" bool DEFAULT true,
    "created_at" timestamp DEFAULT (CURRENT_TIMESTAMP),
    "updated_at" timestamp DEFAULT (CURRENT_TIMESTAMP),
    "created_by" int,
    "updated_by" int
);

CREATE TABLE "product_image" (
    "id" serial PRIMARY KEY,
    "image" text NOT NULL,
    "product_id" int,
    "created_at" timestamp DEFAULT (CURRENT_TIMESTAMP),
    "updated_at" timestamp DEFAULT (CURRENT_TIMESTAMP),
    "created_by" int,
    "updated_by" int
);

CREATE TABLE "size" (
    "id" serial PRIMARY KEY,
    "name" varchar(10) UNIQUE NOT NULL,
    "created_at" timestamp DEFAULT (CURRENT_TIMESTAMP),
    "updated_at" timestamp DEFAULT (CURRENT_TIMESTAMP),
    "created_by" int,
    "updated_by" int
);

CREATE TABLE "products_size" (
    "id" serial PRIMARY KEY,
    "product_id" int,
    "size_id" int,
    "created_at" timestamp DEFAULT (CURRENT_TIMESTAMP),
    "updated_at" timestamp DEFAULT (CURRENT_TIMESTAMP),
    "created_by" int,
    "updated_by" int
);

CREATE TABLE "testimonies" (
    "id" serial PRIMARY KEY,
    "user_id" int,
    "position" varchar(100),
    "rating" float DEFAULT 5,
    "testimonial" text,
    "created_at" timestamp DEFAULT (CURRENT_TIMESTAMP),
    "updated_at" timestamp DEFAULT (CURRENT_TIMESTAMP),
    "created_by" int,
    "updated_by" int
);

CREATE TABLE "orders" (
    "id" serial PRIMARY KEY,
    "user_id" int,
    "dateOrder" timestamp DEFAULT (CURRENT_TIMESTAMP),
    "fullName" varchar(100) NOT NULL,
    "email" varchar(100) NOT NULL,
    "address" varchar(100) NOT NULL,
    "phone" varchar(20) NOT NULL,
    "paymentMethod" varchar(20),
    "shipping" shipping DEFAULT 'Dine In',
    "status" status DEFAULT 'On Progress',
    "totalTransaction" numeric(10, 2) NOT NULL,
    "deliveryFee" numeric(10, 2) DEFAULT 0,
    "tax" numeric(10, 2) DEFAULT 0,
    "created_at" timestamp DEFAULT (CURRENT_TIMESTAMP),
    "updated_at" timestamp DEFAULT (CURRENT_TIMESTAMP),
    "created_by" int,
    "updated_by" int
);

CREATE TABLE "products_order" (
    "id" serial PRIMARY KEY,
    "order_id" int,
    "product_id" int,
    "amount" int,
    "subtotal" numeric(10, 2),
    "size" product_size DEFAULT 'L',
    "temperature" temperature DEFAULT 'Ice',
    "created_at" timestamp DEFAULT (CURRENT_TIMESTAMP),
    "updated_at" timestamp DEFAULT (CURRENT_TIMESTAMP),
    "created_by" int,
    "updated_by" int
);

CREATE TABLE "sessions" (
    "id" serial PRIMARY KEY,
    "user_id" int,
    "session_token" text UNIQUE NOT NULL,
    "login_time" timestamp DEFAULT (CURRENT_TIMESTAMP),
    "expired_time" timestamp,
    "ip_address" varchar(20),
    "device" varchar(100),
    "created_at" timestamp DEFAULT (CURRENT_TIMESTAMP),
    "updated_at" timestamp DEFAULT (CURRENT_TIMESTAMP),
    "created_by" int,
    "updated_by" int
);

CREATE TABLE "password_resets" (
    "id" serial PRIMARY KEY,
    "token_reset" char(6) UNIQUE NOT NULL,
    "user_id" int,
    "created_at" timestamp DEFAULT (CURRENT_TIMESTAMP),
    "updated_at" timestamp DEFAULT (CURRENT_TIMESTAMP),
    "created_by" int,
    "updated_by" int
);

CREATE TABLE "categories" (
    "id" serial PRIMARY KEY,
    "name" varchar(100) UNIQUE NOT NULL,
    "created_at" timestamp DEFAULT (CURRENT_TIMESTAMP),
    "updated_at" timestamp DEFAULT (CURRENT_TIMESTAMP),
    "created_by" int,
    "updated_by" int
);

CREATE TABLE "product_category" (
    "id" serial PRIMARY KEY,
    "product_id" int,
    "category_id" int,
    "created_at" timestamp DEFAULT (CURRENT_TIMESTAMP),
    "updated_at" timestamp DEFAULT (CURRENT_TIMESTAMP),
    "created_by" int,
    "updated_by" int
);

CREATE TABLE "coupons" (
    "id" serial PRIMARY KEY,
    "title" varchar(100) UNIQUE NOT NULL,
    "description" text NOT NULL,
    "image" text NOT NULL,
    "bgColor" varchar(20) NOT NULL,
    "validUntil" timestamp,
    "isActive" bool DEFAULT true,
    "created_at" timestamp DEFAULT (CURRENT_TIMESTAMP),
    "updated_at" timestamp DEFAULT (CURRENT_TIMESTAMP),
    "created_by" int,
    "updated_by" int
);

CREATE TABLE "coupon_usage" (
    "id" serial PRIMARY KEY,
    "user_id" int,
    "coupon_id" int,
    "order_id" int,
    "discount_amount" numeric(10, 2),
    "used_at" timestamp DEFAULT (CURRENT_TIMESTAMP),
    "updated_at" timestamp DEFAULT (CURRENT_TIMESTAMP),
    "created_by" int,
    "updated_by" int
);

ALTER TABLE "users"
ADD FOREIGN KEY ("created_by") REFERENCES "users" ("id");

ALTER TABLE "users"
ADD FOREIGN KEY ("updated_by") REFERENCES "users" ("id");

ALTER TABLE "profiles"
ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "profiles"
ADD FOREIGN KEY ("created_by") REFERENCES "users" ("id");

ALTER TABLE "profiles"
ADD FOREIGN KEY ("updated_by") REFERENCES "users" ("id");

ALTER TABLE "carts"
ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "carts"
ADD FOREIGN KEY ("product_id") REFERENCES "products" ("id");

ALTER TABLE "carts"
ADD FOREIGN KEY ("created_by") REFERENCES "users" ("id");

ALTER TABLE "carts"
ADD FOREIGN KEY ("updated_by") REFERENCES "users" ("id");

ALTER TABLE "products"
ADD FOREIGN KEY ("created_by") REFERENCES "users" ("id");

ALTER TABLE "products"
ADD FOREIGN KEY ("updated_by") REFERENCES "users" ("id");

ALTER TABLE "product_image"
ADD FOREIGN KEY ("product_id") REFERENCES "products" ("id");

ALTER TABLE "product_image"
ADD FOREIGN KEY ("created_by") REFERENCES "users" ("id");

ALTER TABLE "product_image"
ADD FOREIGN KEY ("updated_by") REFERENCES "users" ("id");

ALTER TABLE "size"
ADD FOREIGN KEY ("created_by") REFERENCES "users" ("id");

ALTER TABLE "size"
ADD FOREIGN KEY ("updated_by") REFERENCES "users" ("id");

ALTER TABLE "products_size"
ADD FOREIGN KEY ("product_id") REFERENCES "products" ("id");

ALTER TABLE "products_size"
ADD FOREIGN KEY ("size_id") REFERENCES "size" ("id");

ALTER TABLE "products_size"
ADD FOREIGN KEY ("created_by") REFERENCES "users" ("id");

ALTER TABLE "products_size"
ADD FOREIGN KEY ("updated_by") REFERENCES "users" ("id");

ALTER TABLE "testimonies"
ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "testimonies"
ADD FOREIGN KEY ("created_by") REFERENCES "users" ("id");

ALTER TABLE "testimonies"
ADD FOREIGN KEY ("updated_by") REFERENCES "users" ("id");

ALTER TABLE "orders"
ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "orders"
ADD FOREIGN KEY ("created_by") REFERENCES "users" ("id");

ALTER TABLE "orders"
ADD FOREIGN KEY ("updated_by") REFERENCES "users" ("id");

ALTER TABLE "products_order"
ADD FOREIGN KEY ("order_id") REFERENCES "orders" ("id");

ALTER TABLE "products_order"
ADD FOREIGN KEY ("product_id") REFERENCES "products" ("id");

ALTER TABLE "products_order"
ADD FOREIGN KEY ("created_by") REFERENCES "users" ("id");

ALTER TABLE "products_order"
ADD FOREIGN KEY ("updated_by") REFERENCES "users" ("id");

ALTER TABLE "sessions"
ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "sessions"
ADD FOREIGN KEY ("created_by") REFERENCES "users" ("id");

ALTER TABLE "sessions"
ADD FOREIGN KEY ("updated_by") REFERENCES "users" ("id");

ALTER TABLE "password_resets"
ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "password_resets"
ADD FOREIGN KEY ("created_by") REFERENCES "users" ("id");

ALTER TABLE "password_resets"
ADD FOREIGN KEY ("updated_by") REFERENCES "users" ("id");

ALTER TABLE "categories"
ADD FOREIGN KEY ("created_by") REFERENCES "users" ("id");

ALTER TABLE "categories"
ADD FOREIGN KEY ("updated_by") REFERENCES "users" ("id");

ALTER TABLE "product_category"
ADD FOREIGN KEY ("product_id") REFERENCES "products" ("id");

ALTER TABLE "product_category"
ADD FOREIGN KEY ("category_id") REFERENCES "categories" ("id");

ALTER TABLE "product_category"
ADD FOREIGN KEY ("created_by") REFERENCES "users" ("id");

ALTER TABLE "product_category"
ADD FOREIGN KEY ("updated_by") REFERENCES "users" ("id");

ALTER TABLE "coupons"
ADD FOREIGN KEY ("created_by") REFERENCES "users" ("id");

ALTER TABLE "coupons"
ADD FOREIGN KEY ("updated_by") REFERENCES "users" ("id");

ALTER TABLE "coupon_usage"
ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "coupon_usage"
ADD FOREIGN KEY ("coupon_id") REFERENCES "coupons" ("id");

ALTER TABLE "coupon_usage"
ADD FOREIGN KEY ("order_id") REFERENCES "orders" ("id");

ALTER TABLE "coupon_usage"
ADD FOREIGN KEY ("created_by") REFERENCES "users" ("id");

ALTER TABLE "coupon_usage"
ADD FOREIGN KEY ("updated_by") REFERENCES "users" ("id");