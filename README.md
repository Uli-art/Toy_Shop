# Toy_Shop
Progect for subject "Data Models and Database Management Systems"
## Sidorova Ulyana, 153502

## Functionality:
* User authorization
* User management (CRUD)
* Role system
* Logging of user actions
* Product management (CRUD)
* Order management (CRUD)
* Customer management (CRUD)
* Search, sort and filter
* Write a comment
## Entities:
1. `User`
   - id (int, not null, pk, autoincrement)
   - name (string, unique, not null)
   - email (string, not null)
   - password (string, not null, unique)
   - is_superuser (bool, not null)
2. `Customers`
   - id (int, not null, pk, autoincrement)
   - name (string, not null, unique)
   - phone_number (string, not null)
   - city (string, not null)
   - address (string, not null)
3. `Products`
    - id (int, not null, pk, autoincrement)
    - name (string, not null, unique)
    - type_id (int, not null, fk) -> `Product_type`
    - price (double, not null)
    - in_production (bool, not null)
4.  `Product_types`
    - id (int, not null, pk, autoincrement)
    - name (string, not null, unique)
5.  `Orders`
    - id (int, not null, pk, autoincrement)
    - date (date, not null)
    - customer_id (int, not null, fk) -> `Customer`
    - manager_id (int, not null, fk) -> `Manager`
    - product_id (int, not null, fk) -> `Product`
    - quantity (int, not null)
    - completion_date (date)
6.  `Reviews`
    - id (int, not null, pk, autoincrement)
    - user_id (int, not null, fk) -> `User`
    - rating (int, not null)
    - text (string)
    - date (date, not null)
7. ``
8. ``
9. ``
10. ``

## Scheme:
