/* 
 * A new James Bond movie will be released soon, and management wants to send promotional material to "action fanatics".
 * They've decided that an action fanatic is any customer where at least 4 of their 5 most recently rented movies are action movies.
 *
 * Write a SQL query that finds all action fanatics.
 */
/*SELECT c.customer_id, c.first_name, c.last_name
from customer c
join (
    select customer_id, row_number() over(partition by customer_id order by rental_date desc) as row_num, count(*) filter(where c.name='Action') over(partition by customer_id) as action_count
    from rental as r
    join inventory as i on r.inventory_id=i.inventory_id
    join film as f on i.film_id=f.film_id
    join film_category as fc on f.film_id=fc.film_id
    join category as c on fc.category_id = c.category_id
) as s on c.customer_id=s.customer_id
where row_num<=5 and action_count>=4
group by c.customer_id, c.first_name, c.last_name
having count(*)=5
order by c.customer_id;
*/
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
LEFT JOIN LATERAL (
      SELECT *
      FROM rental r
      WHERE customer_id = c.customer_id
      ORDER BY rental_date desc
      LIMIT 5
) as rental ON TRUE
JOIN inventory USING (inventory_id)
JOIN film USING(film_id)
JOIN film_category USING(film_id)
WHERE category_id = 1
GROUP BY c.customer_id
HAVING count(c.customer_id) >=4
ORDER BY c.customer_id;
