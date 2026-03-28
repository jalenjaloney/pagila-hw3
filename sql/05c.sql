/* 
 * You also like the acting in the movies ACADEMY DINOSAUR and AGENT TRUMAN,
 * and so you'd like to see movies with actors that were in either of these movies or AMERICAN CIRCUS.
 *
 * Write a SQL query that lists all movies where at least 3 actors were in one of the above three movies.
 * (The actors do not necessarily have to all be in the same movie, and you do not necessarily need one actor from each movie.)
 */

SELECT f.title
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN film_actor fa_ref ON fa.actor_id = fa_ref.actor_id
JOIN film f_ref ON fa_ref.film_id = f_ref.film_id
WHERE f_ref.title IN ('ACADEMY DINOSAUR', 'AGENT TRUMAN', 'AMERICAN CIRCUS')
GROUP BY f.title
HAVING COUNT(*) >= 3
ORDER BY f.title;
