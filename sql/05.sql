/*
 * You love the acting in the movie 'AMERICAN CIRCUS' and want to watch other movies with the same actors.
 *
 * Write a SQL query that lists the title of all movies that share at least 1 actor with 'AMERICAN CIRCUS'.
 *
 * HINT:
 * This can be solved with a self join on the film_actor table.
 */

SELECT f2.title
FROM film f1
JOIN film_actor fa1 on (f1.film_id = fa1.film_id)
JOIN actor on (fa1.actor_id = actor.actor_id)
JOIN film_actor fa2 on (actor.actor_id = fa2.actor_id)
JOIN film f2 on (fa2.film_id = f2.film_id)
WHERE f1.title = 'AMERICAN CIRCUS'
ORDER BY f2.title;


/*
SELECT f2.title
FROM film f1
JOIN film_actor fa1 on (f1.film_id = fa1.film_id)
JOIN actor on (fa1.actor_id = actor.actor_id)
JOIN film_actor fa2 on (actor.actor_id = fa2.actor_id)
JOIN film f2 on (fa2.film_id = f2.film_id)
WHERE f1.title = 'AMERICAN CIRCUS'
ORDER BY f2.title;

-- first wrote the query from film -> actors
-- then wrote query from actor -> film
-- then combined the two together
-- (just syntactic manipulation; but easy to get confused)

SELECT title, first_name, last_name
FROM film
JOIN film_actor using (film_id)
JOIN actor using(actor_id)
WHERE title = 'AMERICAN CIRCUS';

SELECT title, first_name, last_name
FROM actor
JOIN film_actor USING (actor_id)
JOIN film USING (film_id)
WHERE first_name = 'KEVIN' and last_name = 'BLOOM';
*/
