/*
 * Management also wants to create a "best sellers" list for each category.
 *
 * Write a SQL query that:
 * For each category, reports the five films that have been rented the most for each category.
 *
 * Note that in the last query, we were ranking films by the total amount of payments made,
 * but in this query, you are ranking by the total number of times the movie has been rented (and ignoring the price).
 */
with topfilms2 as (
    select name as category, title as title, count(rental_id) as total_rentals, row_number() over(partition by name order by count(rental_id) desc, title desc) as rank
    from film
    join film_category using(film_id)
    join category using(category_id)
    join inventory on film.film_id=inventory.film_id
    join rental using(inventory_id)
    group by name, title
)
select category as name, title, total_rentals as "total rentals"
from topfilms2
where rank<=5
order by category, "total rentals" desc, title;
