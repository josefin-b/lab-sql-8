-- LAB 2.8 --

use sakila;

-- 1 Rank films by length (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, and the rank.
select title, length, rank() over (order by length asc) as 'rank' from film
where length <> '' or length <> 0;

-- 2 Rank films by length within the rating category (filter out the rows that have nulls or 0s in length column). 
-- In your output, only select the columns title, length, rating and the rank.
select title, length, rating, rank() over (partition by rating order by length desc) as 'rank' from film
having length <> '' or length <> 0;

-- 3 How many films are there for each of the categories in the category table. Use appropriate join to write this query
select c.name, fc.category_id, count(f.film_id) as nr_of_films from sakila.film_category as fc
inner join sakila.film as f
on fc.film_id = f.film_id
inner join sakila.category as c
on c.category_id = fc.category_id
group by fc.category_id;

-- 4 Which actor has appeared in the most films?
select f.first_name, f.last_name, count(fa.actor_id) as nr_of_films from sakila.film_actor as fa
inner join sakila.actor as f
on fa.actor_id = f.actor_id
group by f.actor_id
order by nr_of_films desc
limit 1;

-- 5 Most active customer (the customer that has rented the most number of films)
select c.first_name, c.last_name, count(r.rental_id) as nr_of_rentals from sakila.rental as r
inner join sakila.customer as c
on r.customer_id = c.customer_id
group by c.customer_id
order by nr_of_rentals desc
limit 1;

-- Bonus: Which is the most rented film? The answer is Bucket Brotherhood. This query might require using more than one join statement. 
select f.title, f.film_id, count(r.rental_id) as nr_of_rentals from sakila.film as f
inner join sakila.inventory as i 
on f.film_id = i.film_id
join sakila.rental as r
on r.inventory_id = i.inventory_id
group by f.film_id
order by nr_of_rentals desc
limit 1;
