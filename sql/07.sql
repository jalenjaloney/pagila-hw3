/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */
WITH bacall_number_1 AS (
    SELECT DISTINCT fa2.actor_id
    FROM film_actor fa1
    JOIN film_actor fa2 ON fa1.film_id = fa2.film_id
    WHERE fa1.actor_id = (
        SELECT actor_id FROM actor
        WHERE first_name = 'RUSSELL' AND last_name = 'BACALL'
    )
    AND fa2.actor_id <> fa1.actor_id
)
SELECT DISTINCT a.first_name || ' ' || a.last_name AS "Actor Name"
FROM film_actor fa
JOIN film_actor fa_bn1 ON fa.film_id = fa_bn1.film_id
JOIN bacall_number_1 bn1 ON fa_bn1.actor_id = bn1.actor_id
JOIN actor a ON fa.actor_id = a.actor_id
WHERE a.actor_id <> (
    SELECT actor_id FROM actor
    WHERE first_name = 'RUSSELL' AND last_name = 'BACALL'
)
AND a.actor_id NOT IN (SELECT actor_id FROM bacall_number_1)
ORDER BY "Actor Name";
