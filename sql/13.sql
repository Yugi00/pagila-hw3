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
with topfilms as (
    select actor_id, first_name, last_name, film.film_id, title, rank() over(partition by actor_id order by sum(amount) desc, title) as rank, sum(amount) as revenue
    from actor
    join film_actor using(actor_id)
    join film using(film_id)
    join inventory on film.film_id=inventory.film_id
    join rental using(inventory_id)
    join payment using(rental_id)
    group by actor_id, first_name, last_name, film.film_id, title
)
select actor_id, first_name, last_name, film_id, title, rank, revenue
from topfilms
where rank<=3;
