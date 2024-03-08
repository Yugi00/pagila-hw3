/*
 * Compute the country with the most customers in it. 
 */
select country from (
    select country, count(customer_id) 
    from country 
    join city using(country_id) 
    join address using(city_id) 
    join customer using(address_id) 
    group by country.country 
    order by count(customer_id) desc limit 1
) as c;
