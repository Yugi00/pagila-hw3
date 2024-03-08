/*
 * List the first and last names of all actors who:
 * 1. have appeared in at least one movie in the "Children" category,
 * 2. but that have never appeared in any movie in the "Horror" category.
 */
select distinct first_name, last_name
from actor
join film_actor using(actor_id)
join film using(film_id)
join film_category using(film_id)
join category using(category_id)
where category.name like 'Children' and actor.actor_id not in (
    select actor_id
    from actor
    join film_actor using(actor_id)
    join film using(film_id)
    join film_category using(film_id)
    join category using(category_id)
    where category.name like 'Horror'
)
order by last_name;
