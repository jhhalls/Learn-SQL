# Copyright Content
# author : jhhalls



use sakila;

-- ================================================================================================
-- _____________________________________ Actor-Centric Analysis____________________________________
-- ================================================================================================

## List all actors along with the total number of films they've appeared in.
SELECT actor.actor_id, concat(actor.first_name, " " ,actor.last_name) as actor_name, COUNT(film_actor.film_id) AS film_count
FROM actor
LEFT JOIN film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id, actor.first_name, actor.last_name
ORDER BY film_count DESC;

/*Usefulness

- Helps the store understand which actors have been most active in films, allowing them to prioritize stocking films featuring popular actors. 
- This can attract customers who prefer films starring well-known actors, potentially increasing rental sales.

*/



## Find the top 10 actors with the highest number of film appearances
SELECT actor.actor_id, concat(actor.first_name, " " ,actor.last_name) as actor_name, COUNT(film_actor.film_id) AS film_count
FROM actor
LEFT JOIN film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id, actor.first_name, actor.last_name
ORDER BY film_count DESC
LIMIT 10;

/* Usefulness: 

- Allows the store to highlight films starring top actors in promotional materials or special rental offers. 
- Customers may be drawn to these films due to the popularity of the actors, leading to increased rentals and customer satisfaction.

*/



## Retrieve actors who have appeared in films released in a specific year (e.g., 2006)
SELECT actor.actor_id, concat(actor.first_name, " " ,actor.last_name) as actor_name, film.title AS movie_name, film.release_year
FROM actor
LEFT JOIN film_actor ON actor.actor_id = film_actor.actor_id
LEFT JOIN film ON film_actor.film_id = film.film_id
WHERE film.release_year = 2006;

/* Usefulness

- Allows the store to promote films released in a particular year as part of anniversary celebrations or themed rental events. 
- Highlighting films from a specific year can attract nostalgic customers and drive rentals during promotional periods.
*/



## List actors and the languages of the films they've appeared in
SELECT distinct actor.actor_id, concat(actor.first_name,' ', actor.last_name) as actor, language.name AS film_language
FROM actor
LEFT JOIN film_actor ON actor.actor_id = film_actor.actor_id
LEFT JOIN film ON film_actor.film_id = film.film_id
LEFT JOIN language ON film.language_id = language.language_id;

/* Usefulness

- Helps the store identify multilingual films to cater to customers with diverse language preferences.
- By stocking films in multiple languages, the store can serve a broader customer base and enhance customer satisfaction.
*/




## Retrieve actors who have appeared in films with a specific rating (e.g., PG)
SELECT actor.actor_id, concat(actor.first_name, " ", actor.last_name) as actor, film.title AS movie_name, film.rating
FROM actor
LEFT JOIN film_actor ON actor.actor_id = film_actor.actor_id
LEFT JOIN film ON film_actor.film_id = film.film_id
WHERE film.rating = 'PG';

/* Usefulness
- Enables the store to curate a family-friendly film selection by identifying films with specific content ratings. 
- This can attract families and parents seeking suitable entertainment options for children, fostering customer loyalty and repeat business.
*/


show tables;
select * from nicer_but_slower_film_list;


## List actors and their film appearances ordered by release year in descending order
SELECT actor.actor_id, concat(actor.first_name, " ", actor.last_name) as Actor_Name, film.title AS movie_name, film.release_year
FROM actor
LEFT JOIN film_actor ON actor.actor_id = film_actor.actor_id
LEFT JOIN film ON film_actor.film_id = film.film_id
ORDER BY film.release_year DESC;


/*
- Analyzing actor filmographies chronologically provides insights into their career trajectories and contributions to the evolving landscape of cinema. 
- It supports historical analysis, trend identification, and forecasting of actor performance, guiding decisions on talent management and resource allocation.
*/




## Total revenue based on category and store
SELECT category.name AS film_genre, store.store_id AS name_store, COUNT(*) AS numberof_rents
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
JOIN inventory ON film.film_id = inventory.film_id
JOIN store ON inventory.store_id = store.store_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY name_store, film_genre
ORDER BY film_genre;

/* Usefulness
- Helps understand the category-wise revenue generation based for wach store
*/




# Retrieve all actors and their corresponding films, including those actors who haven't acted in any films yet.
SELECT actor.actor_id, actor.first_name, actor.last_name, film.title AS movie_name
FROM actor
RIGHT JOIN film_actor ON actor.actor_id = film_actor.actor_id
LEFT JOIN film ON film_actor.film_id = film.film_id;

/* Usefulness

- This analysis provides a comprehensive view of the filmography of actors in the Sakila database.
- It allows stakeholders to identify actors who have acted in multiple films, as well as those who are yet to make their on-screen debut.
- This information can be valuable for casting decisions, talent management, and identifying opportunities for collaboration with emerging actors.
*/





## Identify actors who have appeared in films of a specific genre (e.g., Comedy)
SELECT actor.actor_id, actor.first_name, actor.last_name, film.title AS movie_name, category.name as Genre
FROM actor
LEFT JOIN film_actor ON actor.actor_id = film_actor.actor_id
LEFT JOIN film ON film_actor.film_id = film.film_id
INNER JOIN film_category ON film.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Comedy';

/* Usefulness

- Helps the store categorize films and create genre-specific sections, making it easier for customers to find films they enjoy. 
- By stocking a variety of films across different genres, the store can appeal to a broader customer base and increase rental diversity.
*/




-- ================================================================================================
-- _________________________________Generic Actor Centric Analysis_________________________________
-- ================================================================================================ 


# Number of rents based on month and store
SELECT EXTRACT(YEAR_MONTH FROM rental_date) AS rental_month, store.store_id AS name_store, COUNT(*) AS numberof_rents
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
JOIN inventory ON film.film_id = inventory.film_id
JOIN store ON inventory.store_id = store.store_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY name_store, rental_month
ORDER BY rental_month;





# Total revenue based on category and store 
SELECT category.name AS film_genre, store.store_id AS name_store, COUNT(*) AS numberof_rents
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
JOIN inventory ON film.film_id = inventory.film_id
JOIN store ON inventory.store_id = store.store_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY name_store, film_genre
ORDER BY film_genre;






# Total revenue based on month and store
SELECT EXTRACT(YEAR_MONTH FROM rental_date) AS rental_month, store.store_id AS name_store, SUM(payment.amount) AS total_revenue
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
JOIN inventory ON film.film_id = inventory.film_id
JOIN store ON inventory.store_id = store.store_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY name_store, rental_month
ORDER BY rental_month;






# Total revenue based on category and store
SELECT category.name AS film_genre, store.store_id AS name_store, SUM(payment.amount) AS total_revenue
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
JOIN inventory ON film.film_id = inventory.film_id
JOIN store ON inventory.store_id = store.store_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY name_store, film_genre
ORDER BY film_genre;








# Number of rentals of the highest film genre per year month in store 1
SELECT rental_month, film_genre, MAX(numberof_rents) AS max_numberof_rents
FROM (SELECT EXTRACT(YEAR_MONTH FROM rental_date) AS rental_month, category.name AS film_genre, COUNT(*) AS numberof_rents
      FROM film
      JOIN film_category ON film.film_id = film_category.film_id
      JOIN category ON film_category.category_id = category.category_id
      JOIN inventory ON film.film_id = inventory.film_id
      JOIN store ON inventory.store_id = store.store_id
      JOIN rental ON inventory.inventory_id = rental.inventory_id
      WHERE store.store_id = '1'
      GROUP BY film_genre, rental_month
      ORDER BY rental_month) AS x
GROUP BY rental_month
ORDER BY rental_month;










# Popularity and Versatality of Actors
SELECT actor.actor_id, actor.first_name, actor.last_name, COUNT(*) as numberof_films, COUNT(DISTINCT category.name) as numberof_genres
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY actor.actor_id
ORDER by actor.actor_id;







# Least Popular Actor
SELECT actor.actor_id, actor.first_name, actor.last_name, COUNT(*) AS numberof_films, COUNT(DISTINCT category.name) AS numberof_genres
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY actor.actor_id
HAVING numberof_films = (SELECT MIN(x)
                         FROM (SELECT a.actor_id, a.first_name, a.last_name, COUNT(*) AS x
                               FROM film AS f
                               JOIN film_actor AS fa ON f.film_id = fa.film_id
                               JOIN actor AS a ON fa.actor_id = a.actor_id
                               GROUP BY a.actor_id) AS y)
ORDER by numberof_films desc, numberof_genres desc;








# Most Popular Actor
SELECT actor.actor_id, actor.first_name, actor.last_name, COUNT(*) AS numberof_films, COUNT(DISTINCT category.name) AS numberof_genres
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY actor.actor_id
HAVING numberof_films = (SELECT MAX(x)
                         FROM (SELECT a.actor_id, a.first_name, a.last_name, COUNT(*) AS x
                               FROM film AS f
                               JOIN film_actor AS fa ON f.film_id = fa.film_id
                               JOIN actor AS a ON fa.actor_id = a.actor_id
                               GROUP BY a.actor_id) AS y)
ORDER by numberof_films desc, numberof_genres desc;











# Least Versatile ACtors
SELECT actor.actor_id, actor.first_name, actor.last_name, COUNT(*) AS numberof_films, COUNT(DISTINCT category.name) AS numberof_genres
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY actor.actor_id
HAVING numberof_genres = (SELECT MIN(x)
                         FROM (SELECT a.actor_id, a.first_name, a.last_name, COUNT(DISTINCT c.name) AS x
                               FROM film AS f
                               JOIN film_actor AS fa ON f.film_id = fa.film_id
                               JOIN actor AS a ON fa.actor_id = a.actor_id
                               JOIN film_category AS fc ON f.film_id = fc.film_id
                               JOIN category AS c ON fc.category_id = c.category_id
                               GROUP BY a.actor_id) AS y)
ORDER by numberof_genres desc, numberof_films desc;







# Most Versatile Actors
SELECT actor.actor_id, actor.first_name, actor.last_name, COUNT(*) AS numberof_films, COUNT(DISTINCT category.name) AS numberof_genres
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY actor.actor_id
HAVING numberof_genres = (SELECT MAX(x)
                         FROM (SELECT a.actor_id, a.first_name, a.last_name, COUNT(DISTINCT c.name) AS x
                               FROM film AS f
                               JOIN film_actor AS fa ON f.film_id = fa.film_id
                               JOIN actor AS a ON fa.actor_id = a.actor_id
                               JOIN film_category AS fc ON f.film_id = fc.film_id
                               JOIN category AS c ON fc.category_id = c.category_id
                               GROUP BY a.actor_id) AS y)
ORDER by numberof_genres desc, numberof_films desc;
