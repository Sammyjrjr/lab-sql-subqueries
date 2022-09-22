use sakila;
-- 1How many copies of the film Hunchback Impossible exist in the inventory system?
select count(film_id) 
from inventory
where film_id in (select film_id 
from sakila.film
where title = 'Hunchback Impossible'
);
-- 2List all films whose length is longer than the average of all the films.
select avg(length) from film;
select film_id,title,length
from film
where length > (select avg(length) from film)
order by length desc;

-- 3Use subqueries to display all actors who appear in the film Alone Trip.

-- subqueries 1
select film_id  from film 
where title = "Alone trip"; -- 17
-- subquerie 2
select actor_id from film_actor
where film_id =(
select film_id 
from film 
where title= "Alone trip");
-- final query

select actor_id as Actor_in_film from actor
where actor_id in (
select actor_id
from film_actor
where film_id = (
select film_id 
from film
where title = 'Alone Trip'
)
);
-- 4 Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
select * from category;			
select * from film_category;		
select * from film;

select title as Title
from film
where film_id in (
select film_id
from film_category
where category_id in (
select category_id
from category 
where name = 'Family'
)
);

-- 5 Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.
select * from address; --  address_id, district, city_id
select * from city; --  city_id, country_id
select * from customer;--  customer_id, first_name, last_name, email, address_id
select * from country; -- country_id, country

-- first step, know how many customers from Canada
select country_id from country where country = "Canada"; -- 20

select country_id,first_name,last_name,email
from customer
join address using (address_id)
join city using (city_id)
join country using (country_id)
where country = "Canada";


-- 6 Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.
select * from film_actor;				# actor_id, film_id
select * from film;                  	# film_id, title
select actor_id, film_id




-- 7 Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments
select * from customer;
select * from payment; 
select customer_id,sum(amount) as total
from customer 
join payment using (customer_id)
group by customer_id
order by total desc
limit 1; 

-- 8 Get the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client.
select * from customer; -- client_id 
select avg(amount) as average from payment; -- 4.2


select customer_id, sum(amount) sum 
from payment
group by customer_id
having sum > (
select sum(amount) / count(distinct customer_id)     
from payment)
order by sum desc;
 


