/* For each customer, find the movie that they have rented most recently.
 *
 * NOTE:
 * This problem can be solved with either a subquery (using techniques we've covered in class),
 * or a new type of join called a LATERAL JOIN.
 * You are not required to use LATERAL JOINs,
 * and we will not cover in class how to use them.
 * Nevertheless, they can greatly simplify your code,
 * and so I recommend that you learn to use them.
 * The website <https://linuxhint.com/postgres-lateral-join/> provides a LATERAL JOIN that solves this problem.
 * All of the subsequent problems in this homework can be solved with LATERAL JOINs
 * (or slightly less conveniently with subqueries).
 */
select first_name, last_name, title, max(rental_date) as rental_date
from customer
join rental using (customer_id)
join inventory using(inventory_id)
join film using(film_id)
where (customer_id, rental_date) in (
    select customer_id, max(rental_date) as rental_date
    from rental
    group by customer_id
)
group by customer_id, first_name, last_name, title
order by last_name, first_name;
