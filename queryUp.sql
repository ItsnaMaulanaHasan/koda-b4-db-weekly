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
    "role" varchar(20) NOT NULL DEFAULT 'customer',
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
    "amount" int CHECK ("amount" > 0),
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
    "price" numeric(10, 2) NOT NULL CHECK ("price" > 0),
    "discount_percent" numeric(5, 2),
    "rating" numeric(2, 1) DEFAULT 5 CHECK (
        "rating" >= 0
        AND "rating" <= 5
    ),
    "is_flash_sale" bool DEFAULT false,
    "stock" int CHECK ("stock" >= 0),
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
    "rating" numeric(2, 1) DEFAULT 5 CHECK (
        "rating" >= 0
        AND "rating" <= 5
    ),
    "testimonial" text,
    "created_at" timestamp DEFAULT (CURRENT_TIMESTAMP),
    "updated_at" timestamp DEFAULT (CURRENT_TIMESTAMP),
    "created_by" int,
    "updated_by" int
);

CREATE TABLE "orders" (
    "id" serial PRIMARY KEY,
    "user_id" int,
    "date_order" timestamp DEFAULT (CURRENT_TIMESTAMP),
    "full_name" varchar(100) NOT NULL,
    "email" varchar(100) NOT NULL,
    "address" varchar(100) NOT NULL,
    "phone" varchar(20) NOT NULL,
    "payment_method" varchar(20),
    "shipping" shipping DEFAULT 'Dine In',
    "status" status DEFAULT 'On Progress',
    "total_transaction" numeric(10, 2) NOT NULL CHECK ("total_transaction" > 0),
    "delivery_fee" numeric(10, 2) DEFAULT 0,
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
    "product_name" varchar(100) NOT NULL,
    "product_price" numeric(10, 2) NOT NULL CHECK ("product_price" > 0),
    "discount_percent" numeric(5, 2),
    "amount" int NOT NULL CHECK ("amount" > 0),
    "subtotal" numeric(10, 2) NOT NULL,
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
    "expired_at" timestamp,
    "ip_address" varchar(20),
    "device" varchar(100),
    "is_active" bool DEFAULT true,
    "created_at" timestamp DEFAULT (CURRENT_TIMESTAMP),
    "updated_at" timestamp DEFAULT (CURRENT_TIMESTAMP),
    "created_by" int,
    "updated_by" int
);

CREATE TABLE "password_resets" (
    "id" serial PRIMARY KEY,
    "user_id" int,
    "token_reset" char(6) UNIQUE NOT NULL,
    "expired_at" timestamp NOT NULL DEFAULT (
        CURRENT_TIMESTAMP + INTERVAL '1 hour'
    ),
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
    "discount_percent" numeric(5, 2) NOT NULL,
    "min_purchase" numeric(10, 2),
    "image" text NOT NULL,
    "bg_color" varchar(20) NOT NULL,
    "valid_until" timestamp,
    "is_active" bool DEFAULT true,
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
ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE;

ALTER TABLE "profiles"
ADD FOREIGN KEY ("created_by") REFERENCES "users" ("id");

ALTER TABLE "profiles"
ADD FOREIGN KEY ("updated_by") REFERENCES "users" ("id");

ALTER TABLE "carts"
ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE;

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
ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE RESTRICT;

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

CREATE INDEX idx_products_name ON products (name);

CREATE INDEX idx_products_is_flash_sale ON products (is_flash_sale)
WHERE
    is_flash_sale = true;

CREATE INDEX idx_orders_user_date ON orders (user_id, date_order);

CREATE INDEX idx_carts_user ON carts (user_id);

CREATE INDEX idx_orders_status ON orders (status);

CREATE INDEX idx_products_active ON products (is_active)
WHERE
    is_active = true;

CREATE INDEX idx_product_images_product ON product_image (product_id);

CREATE INDEX idx_products_order_order ON products_order (order_id);

CREATE INDEX idx_sessions_token ON sessions (session_token);

CREATE INDEX idx_sessions_user_expired ON sessions (user_id, expired_at);

CREATE INDEX idx_sessions_active ON sessions (user_id, is_active)
WHERE
    is_active = true;

CREATE INDEX idx_password_resets_expired ON password_resets (expired_at);