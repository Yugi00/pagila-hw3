/* 
 * In the previous query, the actors could come from any combination of movies.
 * Unfortunately, you've found that if the actors all come from only 1 or 2 of the movies,
 * then there is not enough diversity in the acting talent.
 *
 * Write a SQL query that lists all of the movies where:
 * at least 1 actor was also in AMERICAN CIRCUS,
 * at least 1 actor was also in ACADEMY DINOSAUR,
 * and at least 1 actor was also in AGENT TRUMAN.
 *
 * HINT:
 * There are many ways to solve this problem,
 * but I personally found the INTERSECT operator to make a convenient solution.
 */
select title
from (
    select f2.title
    from film f1 
    join film_actor fa1 on (f1.film_id = fa1.film_id)
    join actor on (fa1.actor_id = actor.actor_id)
    join film_actor fa2 on (actor.actor_id = fa2.actor_id) 
    join film f2 on (f2.film_id = fa2.film_id)
    where f1.title like 'AMERICAN CIRCUS' 
    intersect
    select f2.title
    from film f1 
    join film_actor fa1 on (f1.film_id = fa1.film_id)
    join actor on (fa1.actor_id = actor.actor_id)
    join film_actor fa2 on (actor.actor_id = fa2.actor_id) 
    join film f2 on (f2.film_id = fa2.film_id)
    where f1.title like 'ACADEMY DINOSAUR' 
    intersect
    select f2.title
    from film f1 
    join film_actor fa1 on (f1.film_id = fa1.film_id)
    join actor on (fa1.actor_id = actor.actor_id)
    join film_actor fa2 on (actor.actor_id = fa2.actor_id) 
    join film f2 on (f2.film_id = fa2.film_id)
    where f1.title like 'AGENT TRUMAN' 
) as f
order by title;
