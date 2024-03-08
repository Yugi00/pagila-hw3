/* 
 * Finding movies with similar categories still gives you too many options.
 *
 * Write a SQL query that lists all movies that share 2 categories with AMERICAN CIRCUS and 1 actor.
 *
 * HINT:
 * It's possible to complete this problem both with and without set operations,
 * but I find the version using set operations much more intuitive.
 */
select f2.title
from film f1 
join film_actor fa1 on (f1.film_id = fa1.film_id)
join actor on (fa1.actor_id = actor.actor_id)
join film_actor fa2 on (actor.actor_id = fa2.actor_id) 
join film f2 on (f2.film_id = fa2.film_id)
where f1.title like 'AMERICAN CIRCUS' 
intersect
select distinct title from film
join film_category fc1 using(film_id)
join film_category fc2 using(category_id)
join (
    select film_id
    from film
    where title like 'AMERICAN CIRCUS'
) as f on fc2.film_id=f.film_id
group by title
having count(distinct category_id)=2
union all
select 'AMERICAN CIRCUS' as title
order by title;
