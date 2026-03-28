/* 
 * Finding movies with similar categories still gives you too many options.
 *
 * Write a SQL query that lists all movies that share 2 categories with AMERICAN CIRCUS and 1 actor.
 *
 * HINT:
 * It's possible to complete this problem both with and without set operations,
 * but I find the version using set operations much more intuitive.
 */

SELECT f.title
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN film_category fc_ref ON fc.category_id = fc_ref.category_id
JOIN film f_ref ON fc_ref.film_id = f_ref.film_id
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN film_actor fa_ref ON fa.actor_id = fa_ref.actor_id
WHERE f_ref.title = 'AMERICAN CIRCUS'
AND fa_ref.film_id = f_ref.film_id
GROUP BY f.title
HAVING COUNT(DISTINCT fc.category_id) >= 2
ORDER BY f.title;
