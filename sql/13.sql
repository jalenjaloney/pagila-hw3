/*
 * Management wants to create a "best sellers" list for each actor.
 *
 * Write a SQL query that:
 * For each actor, reports the three films that the actor starred in that have brought in the most revenue for the company.
 * (The revenue is the sum of all payments associated with that film.)
 *
 * HINT:
 * For correct output, you will have to rank the films for each actor.
 * My solution uses the `rank` window function.
 */
SELECT
    a.actor_id,
    a.first_name,
    a.last_name,
    f.film_id,
    f.title,
    ranked.rank,
    ranked.revenue
FROM actor a
JOIN LATERAL (
    SELECT
        fa.film_id,
        SUM(p.amount) AS revenue,
        rank() OVER (ORDER BY SUM(p.amount) DESC, fa.film_id ASC) AS rank
    FROM film_actor fa
    JOIN inventory i ON fa.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    JOIN payment p ON r.rental_id = p.rental_id
    WHERE fa.actor_id = a.actor_id
    GROUP BY fa.film_id
    ORDER BY revenue DESC, fa.film_id ASC
    LIMIT 3
) ranked ON true
JOIN film f ON f.film_id = ranked.film_id
ORDER BY a.actor_id, ranked.rank;
