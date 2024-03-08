/* 
 * A new James Bond movie will be released soon, and management wants to send promotional material to "action fanatics".
 * They've decided that an action fanatic is any customer where at least 4 of their 5 most recently rented movies are action movies.
 *
 * Write a SQL query that finds all action fanatics.
 */
select customer_id, first_name, last_name
from customer
join (
    select customer_id, row_number() over(partition by customer_id order by rental_date desc) as row_num, count(*) filter(where name like 'Action') over(partition by customer_id) as action_count
    from rental
    join inventory using(inventory_id)
    join film using(film_id)
    join film_category on film.film_id=film_category.film_id
    join category using(category_id)
) as c using(customer_id)
where row_num<=5 and action_count>=4
group by customer_id, first_name, last_name
having count(*)=5
order by customer_id;
