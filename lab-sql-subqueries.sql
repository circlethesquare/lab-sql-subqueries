-- 1.Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

SELECT f.title, 
    (SELECT COUNT(*) 
    FROM sakila.inventory 
    AS i 
    WHERE i.film_id = f.film_id) 
    AS nr_of_copies
FROM 
    sakila.film AS f
WHERE 
    f.title = 'Hunchback Impossible';

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT title
FROM sakila.film
WHERE length > (SELECT AVG(length) FROM sakila.film)
;

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT a.first_name, a.last_name
FROM sakila.actor AS a
WHERE a.actor_id IN 
(SELECT actor_id FROM sakila.film_actor WHERE film_id IN 
(SELECT film_id FROM sakila.film WHERE title = 'Alone Trip'));
-- Bonus:
-- 4.Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.

SELECT f.title 
FROM sakila.film AS f
WHERE f.film_id IN 
    (SELECT fc.film_id 
     FROM sakila.film_category AS fc
     WHERE fc.category_id IN 
         (SELECT c.category_id 
          FROM sakila.category AS c
          WHERE c.name = 'Family'));

-- 5.Retrieve the name and email of customers from Canada using both subqueries and joins. 
-- To use joins, you will need to identify the relevant tables and their primary and foreign keys.

SELECT first_name, last_name, email
FROM sakila.customer
WHERE address_id IN
    (SELECT address_id
     FROM sakila.address
     WHERE city_id IN
         (SELECT city_id
          FROM sakila.city
          WHERE country_id IN
              (SELECT country_id
               FROM sakila.country
               WHERE country = 'Canada')));


-- 6.Determine which films were starred by the most prolific actor in the Sakila database. 
-- A prolific actor is defined as the actor who has acted in the most number of films. 
-- First, you will need to find the most prolific actor and then use that 
-- actor_id to find the different films that he or she starred in.

SELECT f.title
FROM sakila.film AS f
WHERE f.film_id IN (
    SELECT fa.film_id
    FROM sakila.film_actor AS fa
    WHERE fa.actor_id = (
        SELECT actor_id
        FROM sakila.film_actor
        GROUP BY actor_id
        ORDER BY COUNT(*) DESC
        LIMIT 1));

 
-- 7.Find the films rented by the most profitable customer in the Sakila database.
--  You can use the customer and payment tables to find the most profitable customer, i.e., 
 -- the customer who has made the largest sum of payments.
 
 
-- 8. Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. You can use subqueries to accomplish this.
