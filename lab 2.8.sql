USE sakila;

-- 1 Write a query to display for each store its store ID, city, and country.
SELECT s.store_id, c.city, co.country 
FROM sakila.store s
JOIN sakila.address a
ON s.address_id = a.address_id
JOIN sakila.city c
ON c.city_id = a.city_id
JOIN sakila.country co
ON co.country_id = c.country_id;

-- 2 Write a query to display how much business, in dollars, each store brought in.
SELECT s.store_id, SUM(amount)
FROM sakila.store s
JOIN sakila.staff stf
ON s.store_id = stf.store_id
JOIN sakila.payment p
ON p.staff_id = stf.staff_id
GROUP BY s.store_id;

-- 3 Which film categories are longest?
SELECT c.name, MAX(length)
FROM sakila.film f
JOIN sakila.film_category fc
ON f.film_id = fc.film_id
JOIN sakila.category c
ON c.category_id = fc.category_id
GROUP BY c.name
ORDER BY MAX(length) DESC;

-- 4 Display the most frequently rented movies in descending order
SELECT f.title, COUNT(rental_id)
FROM sakila.film f
JOIN sakila.inventory i
ON f.film_id = i.film_id
JOIN sakila.rental r
ON r.inventory_id = i.inventory_id
GROUP BY f.title
ORDER BY COUNT(rental_id) DESC;

-- 5 List the top five genres in gross revenue in descending order.
SELECT name, category_id, SUM(amount) AS `gross revenue`
FROM payment 
JOIN rental  USING (rental_id)
JOIN inventory USING (inventory_id)
JOIN film_category  USING (film_id)
JOIN category  USING (category_id)
GROUP BY category_id
ORDER BY `gross revenue` DESC
LIMIT 5;

-- 6 Is "Academy Dinosaur" available for rent from Store 1?
SELECT f.film_id, f.title, s.store_id, i.inventory_id
FROM sakila.inventory i
JOIN sakila.store s
ON i.store_id = s.store_id
JOIN sakila.film f
ON f.film_id = i.film_id
WHERE f.title = 'Academy Dinosaur' AND s.store_id = '1';

-- 7 Get all pairs of actors that worked together.
SELECT f.title, fa1.actor_id, fa2.actor_id
FROM sakila.film_actor fa1
JOIN sakila.film_actor fa2
ON fa1.actor_id <> fa2.actor_id AND fa1.film_id = fa2.film_id
JOIN sakila.film f
ON fa2.film_id = f.film_id
JOIN sakila.actor a
ON fa1.actor_id = a.actor_id
GROUP BY f.title;

-- 8 Get all pairs of customers that have rented the same film more than 3 times.




-- 9 For each film, list actor that has acted in more films.
SELECT fa1.film_id, COUNT(fa1.actor_id)
FROM sakila.film_actor fa1
JOIN sakila.film_actor fa2
ON fa1.actor_id = fa2.actor_id AND fa1.film_id <> fa2.film_id
GROUP BY fa1.film_id
ORDER BY fa1.film_id asc;
