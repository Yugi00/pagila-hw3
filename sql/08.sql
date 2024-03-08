/*
 * The film 'BUCKET BROTHERHOOD' is your favorite movie, but you're tired of watching it.
 * You want to find something new to watch that is still similar to 'BUCKET BROTHERHOOD'.
 * To find a similar movie, you decide to search the history of movies that other people have rented.
 * Your idea is that if a lot of people have rented both 'BUCKET BROTHERHOOD' and movie X,
 * then movie X must be similar and something you'd like to watch too.
 * Your goal is to create a SQL query that finds movie X.
 * Specifically, write a SQL query that returns all films that have been rented by at least 3 customers who have also rented 'BUCKET BROTHERHOOD'.
 *
 * HINT:
 * This query is very similar to the query from problem 06,
 * but you will have to use joins to connect the rental table to the film table.
 *
 * HINT:
 * If your query is *almost* getting the same results as mine, but off by 1-2 entries, ensure that:
 * 1. You are not including 'BUCKET BROTHERHOOD' in the output.
 * 2. Some customers have rented movies multiple times.
 *    Ensure that you are not counting a customer that has rented a movie twice as 2 separate customers renting the movie.
 *    I did this by using the SELECT DISTINCT clause.
 */
select distinct f.title
from rental r
join customer c using(customer_id)
join inventory i on r.inventory_id=i.inventory_id
join film f on i.film_id=f.film_id
where f.title not like 'BUCKET BROTHERHOOD'
and r.customer_id in (
    select distinct r2.customer_id
    from rental r2
    join inventory as i2 on r2.inventory_id=i2.inventory_id
    join film as f2 on i2.film_id=f2.film_id
    where f2.title = 'BUCKET BROTHERHOOD'
)
group by f.film_id, f.title
having count(distinct r.customer_id)>=3
order by title;
