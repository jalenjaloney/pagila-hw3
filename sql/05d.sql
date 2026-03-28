/* 
 * In the previous query, the actors could come from any combination of movies.
 * Unfortunately, you've found that if the actors all come from only 1 or 2 of the movies,
 * then there is not enough diversity in the acting talent.
 *
 * Write a SQL query that lists all of the movies where:
 * at least 1 actor was also in AMERICAN CIRCUS,
 * at least 1 actor was also in ACADEMY DINOSAUR,
 * and at least 1 actor was also in AGENT TRUMAN.
 *
 * HINT:
 * There are many ways to solve this problem,
 * but I personally found the INTERSECT operator to make a convenient solution.
 */

SELECT f.title
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN film_actor fa_ref ON fa.actor_id = fa_ref.actor_id
JOIN film f_ref ON fa_ref.film_id = f_ref.film_id
WHERE f_ref.title IN ('ACADEMY DINOSAUR', 'AGENT TRUMAN', 'AMERICAN CIRCUS')
GROUP BY f.title
HAVING COUNT(DISTINCT f_ref.title) = 3
ORDER BY f.title;
