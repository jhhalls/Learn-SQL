-- Select the Database
use sakila;


-- 1. Retrieve all columns from the `actor` table.
SELECT * FROM sakila.actor;
  
-- HW -  Return all the columns  from all the tables in the database. (basic exploration - get a flavour of the details present in all the tables)

select actor_id from actor;
-- HW -  Return all the columns one by one from all the tables in the database. (basic exploration - get a flavour of the details present in all the tables)





/* 2. Retrieve distinct values of the `language_id` column from the `film` table.
aka
Retrieve the unique language IDs present in the FILM table.
*/
show columns from film;
SELECT DISTINCT language_id FROM film;

-- HW - Return all the unique categories from the columns, of all the tables, with datatype as VARCHAR







-- 3. Retrieve the first and last name, email id of all customers from the `customer` table.
SELECT first_name, last_name, email FROM customer;


-- order by- to sort data
SELECT first_name, last_name, email FROM customer order by first_name desc;

# get the count of values
select count(first_name) from customer;
select count(customer_id) from customer;

# rename the columns using alias (as)
SELECT first_name as forename, last_name as surname FROM customer;




## SELF WORK - PRACTICE SELECT
/*1. Retrieve all columns from the `actor` table.
   SELECT * FROM actor;
*/    
/*2. Retrieve the first and last names from the `customer` table.
   SELECT first_name, last_name FROM customer;
  */  
/*3. Retrieve the film title and rental duration from the `film` table.
   SELECT title, rental_duration FROM film;
  */ 
/*4. Retrieve the film titles from the `film` table sorted alphabetically.
   SELECT title FROM film ORDER BY title;
  */  
/*5. Retrieve the unique film categories from the `category` table.
   SELECT DISTINCT name FROM category;
  */  
/*6. Retrieve the total number of films from the `film` table.
    SELECT COUNT(*) AS total_films FROM film;
  */  
/*7. Retrieve the rental rate and replacement cost of films from the `film` table.
   SELECT rental_rate, replacement_cost FROM film;
*/
/*8. Retrieve the names of staff members from the `staff` table.
   SELECT first_name, last_name FROM staff;
  */  
/*9. Retrieve the film titles and their descriptions from the `film` table.
   SELECT title, description FROM film;
  */  
/*10. Retrieve the customer email addresses from the `customer` table. 
    SELECT email FROM customer;
  */   
/*11. Retrieve the rental dates from the `rental` table.
    SELECT rental_date FROM rental;
  */   
/*12. Retrieve the city names from the `city` table.
    SELECT city FROM city;
  */   
/*13. Retrieve the actor names from the `actor` table sorted by last name.
    SELECT first_name, last_name FROM actor ORDER BY last_name;
*/     
/*14. Retrieve the film titles and their release years from the `film` table.
    SELECT title, release_year FROM film;
  */   
/*15. Retrieve the film titles and their rental durations where the rental duration is greater than 5 days.
    SELECT title, rental_duration FROM film WHERE rental_duration > 5;
  */   
/*16. Retrieve the film titles and their lengths in minutes from the `film` table.
    SELECT title, length FROM film;
  */   
/*17. Retrieve the staff IDs and their emails from the `staff` table.
    SELECT staff_id, email FROM staff;
  */   
/*18. Retrieve the film titles and their ratings from the `film` table.
    SELECT title, rating FROM film;
  */   
/*19. Retrieve the customer IDs and their addresses from the `customer` table.
    SELECT customer_id, address FROM customer;
  */   
/*20. Retrieve the film titles and their language IDs from the `film` table.
    SELECT title, language_id FROM film;
     
*/


