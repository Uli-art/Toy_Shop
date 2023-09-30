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
   - name (varchar, unique, not null)
   - email (varchar, not null)
   - password (varchar, not null, unique)
2. `Status`
   - id (int, not null, pk, autoincrement)
   - status (varchar, not null)
3. `Product`
    - id (int, not null, pk, autoincrement)
    - name (varchar, not null, unique)
    - type_id (int, not null, fk) -> `Product_type`
    - price (double, not null)
    - in_production (bool, not null)
4.  `Product_type`
    - id (int, not null, pk, autoincrement)
    - name (varchar, not null, unique)
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
    - product_id (int, fk, not null) -> `Product`
    - rating (int, not null)
    - text (varchar)
    - date (date, not null)
7. `Article`
    - id (int, not null, pk, autoincrement)
    - title (varchar, not null)
    - short_description  (varchar, not null)
    - main_text  (varchar, not null)
    - image  (varchar, not null)
    - user_id (int, fk) -> `User`
8. `Manager`
   - id (int, not null, pk, autoincrement)
   - email (varchar. not null, unique)
   - password (strint, not null, unique)
   - manager_info_id  (int. not null) -> `Manager_info`
9. `Manager_info`
    - id (int, not null, pk, autoincrement)
    - name (varchar. not null)
    - surname  (varchar. not null)
    - phone_number (varchar. not null)
    - position_id (int. not null) -> `Position`
    - is_admin (bool, not null)
    - resume (varchar. not null)
10. `Position`
    - id (int, not null, pk, autoincrement)
    - position (varchar. not null)
11. `Log`
    - id (int, not null, pk, autoincrement)
    - activity (varchar, not null)
    - date (date, not null)
    - user_id (int, fk, not null) -> `User`


## Scheme:
![Diagram](https://github.com/Uli-art/Toy_Shop/assets/78424200/b631a8af-8242-4b4e-85d5-8c5ce359e59d)

