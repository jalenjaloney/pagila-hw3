/*
 * Management also wants to create a "best sellers" list for each category.
 *
 * Write a SQL query that:
 * For each category, reports the five films that have been rented the most for each category.
 *
 * Note that in the last query, we were ranking films by the total amount of payments made,
 * but in this query, you are ranking by the total number of times the movie has been rented (and ignoring the price).
 */

SELECT name, title, "total rentals"
FROM (
    SELECT
        cat.name,
        f.title,
        COUNT(*) AS "total rentals",
        rank() OVER (
            PARTITION BY cat.category_id
            ORDER BY COUNT(*) DESC, f.title DESC
        ) AS rnk
    FROM category cat
    JOIN film_category fc ON cat.category_id = fc.category_id
    JOIN film f ON fc.film_id = f.film_id
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY cat.category_id, cat.name, f.film_id, f.title
) ranked
WHERE rnk <= 5
ORDER BY name, "total rentals" DESC, title ASC;
