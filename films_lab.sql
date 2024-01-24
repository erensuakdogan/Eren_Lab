USE sakila;

# Display all available tables in the Sakila database.
SHOW TABLES;

# Retrieve all the data from the tables actor, film and customer.
SELECT * FROM actor, film, customer;

# Retrieve the following columns from their respective tables:



-- 3.1 Titles of all films from the film table
SELECT title FROM film;

-- 3.2 List of languages used in films, with the column aliased as language from the language table
SELECT name as 'language' FROM language;

-- 3.3 List of first names of all employees from the staff table
SELECT first_name FROM staff;

# Retrieve unique release years.
SELECT release_year FROM film
GROUP BY release_year;

# Counting records for database insights:
-- 5.1 Determine the number of stores that the company has.
SELECT COUNT(store.store_id) as 'Store Count'
FROM store;
 
-- 5.2 Determine the number of employees that the company has.
SELECT COUNT(staff.staff_id) as 'Employee Count'
FROM staff;

-- 5.3 Determine how many films are available for rent and how many have been rented.
SELECT count(title) FROM film;
SELECT COUNT(rental_id) FROM rental;

-- 5.4 Determine the number of distinct last names of the actors in the database.
SELECT DISTINCT COUNT(last_name) as 'Number Unique Last names'
FROM actor;


# Retrieve the 10 longest films.
SELECT title, length FROM film
ORDER BY length DESC
LIMIT 10;

# 7.1 Retrieve all actors with the first name "SCARLETT".
SELECT first_name, last_name FROM actor 
WHERE first_name = 'SCARLETT';


 
