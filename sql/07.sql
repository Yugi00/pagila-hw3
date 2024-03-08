/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */
with bac0 as (
    select actor_id
    from actor
    where first_name || ' ' || last_name like 'RUSSELL BACALL'
),
bac1 as (
    select a1.actor_id
    from actor a1 
    join film_actor f1 using(actor_id)
    join film_actor f2 using(film_id)
    join actor a2 on f2.actor_id=a2.actor_id
    where a2.actor_id in (
        select *
        from bac0
    )
    and a1.actor_id not in (
        select *
        from bac0
    )
)
select distinct a1.first_name || ' ' || a1.last_name as "Actor Name"
from actor a1
join film_actor f1 using(actor_id)
join film_actor f2 using(film_id)
join actor a2 on f2.actor_id=a2.actor_id
where a2.actor_id in (
    select *
    from bac1
)
and a1.actor_id not in (
    select *
    from bac0
)
and a1.actor_id not in (
    select *
    from bac1
)
order by "Actor Name";
