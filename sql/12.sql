/* 
 * A new James Bond movie will be released soon, and management wants to send promotional material to "action fanatics".
 * They've decided that an action fanatic is any customer where at least 4 of their 5 most recently rented movies are action movies.
 *
 * Write a SQL query that finds all action fanatics.
 */
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
JOIN LATERAL (
    -- For each of the 5 most recent rentals, check if the film is an Action film
    SELECT COUNT(*) FILTER (WHERE EXISTS (
        SELECT 1
        FROM film_category fc
        JOIN category cat ON fc.category_id = cat.category_id
        WHERE fc.film_id = recent.film_id
        AND cat.name = 'Action'
    )) AS action_count
    FROM (
        SELECT i.film_id
        FROM rental r
        JOIN inventory i ON r.inventory_id = i.inventory_id
        WHERE r.customer_id = c.customer_id
        ORDER BY r.rental_date DESC
        LIMIT 5
    ) recent
) counts ON counts.action_count >= 4
ORDER BY c.customer_id;
