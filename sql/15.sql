/*
 * Find every documentary film that is rated PG.
 * Report the title and the actors.
 *
 * HINT:
 * Getting the formatting right on this query can be tricky.
 * You are welcome to try to manually get the correct formatting.
 * But there is also a view in the database that contains the correct formatting,
 * and you can SELECT from that VIEW instead of constructing the entire query manually.
 */
select title, string_agg(concat(initcap(split_part(first_name, ' ', 1)), initcap(split_part(last_name, ' ', 1))), ', ') as actors
from film
join film_actor using(film_id)
join actor using(actor_id)
join film_category on film.film_id=film_category.film_id
join category using(category_id)
where cast(rating as text) like 'G' and name like 'Documentary'
group by film.film_id;
