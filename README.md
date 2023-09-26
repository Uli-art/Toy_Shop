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
* Article management (CRUD)
* Search, sort and filter
* Write a comment
## Entities:
1. `User`
   - id (int, not null, pk, autoincrement)
   - name (string, unique, not null)
   - email (string, not null)
   - password (string, not null, unique)
2. `Status`
   - id (int, not null, pk, autoincrement)
   - status (string, not null)
3. `Product`
    - id (int, not null, pk, autoincrement)
    - name (string, not null, unique)
    - type_id (int, not null, fk) -> `Product_type`
    - price (double, not null)
    - in_production (bool, not null)
4.  `Product_type`
    - id (int, not null, pk, autoincrement)
    - name (string, not null, unique)
5.  `Order`
    - id (int, not null, pk, autoincrement)
    - date (date, not null)
    - user_id (int, not null, fk) -> `User`
    - manager_id (int, not null, fk) -> `Manager`
    - product_id (int, not null, fk) -> `Product`
    - quantity (int, not null)
    - completion_date (date)
    - status_id - `Status`
6.  `Review`
    - id (int, not null, pk, autoincrement)
    - user_id (int, not null, fk) -> `User`
    - rating (int, not null)
    - text (string)
    - date (date, not null)
7. `Article`
    - id (int, not null, pk, autoincrement)
    - title (string, not null)
    - short_description  (string, not null)
    - main_text  (string, not null)
    - image  (string, not null)
    - user_id (int, fk) -> `User`
8. `Manager`
   - id (int, not null, pk, autoincrement)
   - name (string. not null)
   - surname  (string. not null)
   - password (strint, not null)
   - manager_info_id  (int. not null) -> `Manager_info`
9. `Manager_info`
    - id (int, not null, pk, autoincrement)
    - email (string. not null)
    - phone_number (string. not null)
    - position_id (int. not null) -> `Position`
    - is_admin (bool, not null)
    - resume (string. not null)
10. `Position`
    - id (int, not null, pk, autoincrement)
    - position (string. not null)
11. `Log`
    - id (int, not null, pk, autoincrement)
    - activity (string, not null)
    - date (date, not null)
    - user_id (int, fk, not null) -> `User`

## Scheme:
![DIagr](https://github.com/Uli-art/Toy_Shop/assets/78424200/b16a82b3-93c3-471b-acf6-53299d3a08cf)

