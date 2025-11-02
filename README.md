# ERD Daily Greens

```mermaid
erDiagram
    users {
        serial id PK
        varchar(255) first_name
        varchar(255) last_name
        varchar(255) email UK
        varchar(20) role
        text password
        timestamp created_at
        timestamp updated_at
        int created_by FK
        int updated_by FK
    }

    profiles {
        serial id PK
        int user_id FK
        text image
        varchar(255) address
        varchar(20) phone_number
        timestamp created_at
        timestamp updated_at
        int created_by FK
        int updated_by FK
    }

    carts {
        serial id PK
        int user_id FK
        int product_id FK
        int amount
        numeric(10,2) subtotal
        product_sizes size
        timestamp created_at
        timestamp updated_at
        int created_by FK
        int updated_by FK
    }

    products {
        serial id PK
        varchar(255) name UK
        text description
        numeric(10,2) price
        numeric(5,2) discount_percent
        numeric(2,1) rating
        bool is_flash_sale
        int stock
        bool is_active
        timestamp created_at
        timestamp updated_at
        int created_by FK
        int updated_by FK
    }

    product_image {
        serial id PK
        text image
        int product_id FK
        timestamp created_at
        timestamp updated_at
        int created_by FK
        int updated_by FK
    }

    sizes {
        serial id PK
        varchar(10) name UK
        timestamp created_at
        timestamp updated_at
        int created_by FK
        int updated_by FK
    }

    size_products {
        serial id PK
        int product_id FK
        int size_id FK
        timestamp created_at
        timestamp updated_at
        int created_by FK
        int updated_by FK
    }

    testimonies {
        serial id PK
        int user_id FK
        varchar(100) position
        numeric(2,1) rating
        text testimonial
        timestamp created_at
        timestamp updated_at
        int created_by FK
        int updated_by FK
    }

    orders {
        serial id PK
        int user_id FK
        timestamp date_order
        varchar(255) full_name
        varchar(255) email
        varchar(255) address
        varchar(20) phone
        varchar(50) payment_method
        shipping shipping
        status status
        numeric(10,2) total_transaction
        numeric(10,2) delivery_fee
        numeric(10,2) tax
        timestamp created_at
        timestamp updated_at
        int created_by FK
        int updated_by FK
    }

    products_order {
        serial id PK
        int order_id FK
        int product_id FK
        varchar(255) product_name
        numeric(10,2) product_price
        numeric(5,2) discount_percent
        int amount
        numeric(10,2) subtotal
        product_sizes size
        timestamp created_at
        timestamp updated_at
        int created_by FK
        int updated_by FK
    }

    sessions {
        serial id PK
        int user_id FK
        text session_token UK
        timestamp login_time
        timestamp expired_at
        varchar(30) ip_address
        varchar(255) device
        bool is_active
        timestamp created_at
        timestamp updated_at
        int created_by FK
        int updated_by FK
    }

    password_resets {
        serial id PK
        int user_id FK
        char(6) token_reset UK
        timestamp expired_at
        timestamp created_at
        timestamp updated_at
        int created_by FK
        int updated_by FK
    }

    categories {
        serial id PK
        varchar(100) name UK
        varchar description
        timestamp created_at
        timestamp updated_at
        int created_by FK
        int updated_by FK
    }

    product_category {
        serial id PK
        int product_id FK
        int category_id FK
        timestamp created_at
        timestamp updated_at
        int created_by FK
        int updated_by FK
    }

    coupons {
        serial id PK
        varchar(255) title UK
        text description
        numeric(5,2) discount_percent
        numeric(10,2) min_purchase
        text image
        varchar(20) bg_color
        timestamp valid_until
        bool is_active
        timestamp created_at
        timestamp updated_at
        int created_by FK
        int updated_by FK
    }

    coupon_usage {
        serial id PK
        int user_id FK
        int coupon_id FK
        int order_id FK
        numeric(10,2) discount_amount
        timestamp used_at
        timestamp updated_at
        int created_by FK
        int updated_by FK
    }

    users ||--o{ profiles : has
    users ||--o{ carts : creates
    users ||--o{ testimonies : writes
    users ||--o{ orders : places
    users ||--o{ sessions : has
    users ||--o{ password_resets : requests
    users ||--o{ coupon_usage : uses

    users ||--o{ products : manages
    users ||--o{ product_image : manages
    users ||--o{ products_order : manages
    users ||--o{ sizes : manages
    users ||--o{ size_products : manages
    users ||--o{ categories : manages
    users ||--o{ product_category : manages
    users ||--o{ coupons : manages

    products ||--o{ carts : added_to
    products ||--o{ product_image : has
    products ||--o{ size_products : has
    products ||--o{ products_order : ordered_in
    products ||--o{ product_category : belongs_to

    orders ||--o{ products_order : contains
    orders ||--o{ coupon_usage : applied_to

    sizes ||--o{ size_products : used_in

    categories ||--o{ product_category : includes

    coupons ||--o{ coupon_usage : applied_in
```
