-- 1. List all customers who live in Texas (use JOINs)
SELECT customer_id, address.address_id, district, first_name, last_name
FROM customer
INNER JOIN address
ON customer.address_id=address.address_id
WHERE district = 'Texas';


-- Reasoning
--got the ambiguous error. fixed it in the select. then matched the district name to Texas as well as gave their full name

-- 2. Get all payments above $6.99 with the Customer's Full Name
SELECT customer.customer_id, amount, first_name, last_name
FROM payment
INNER JOIN customer
ON payment.customer_id=customer.customer_id
WHERE amount > 6.99;


-- Reasoning
--Joined the two tables to get full name and searched for those above $6.99

-- 3. Show all customers names who have made payments over $175 (use subqueries)
SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id IN(
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    HAVING SUM(amount) > 175
);

SELECT amount
FROM payment
WHERE amount > 175;

-- Reasoning
-- The last selection is how I checked. There are many with payments over 175, but the error said that 
-- amount had to be in an aggregate. So I'm not sure if this is what we were meant to do or if I'm missing something.

-- 4. List all customers that live in Nepal (use the city table)
SELECT city
FROM city
WHERE city = 'Nepal';

SELECT *
FROM city;

-- Reasoning
--There is no data for Nepal. I double checked this with the select all and filtered the city for Nepal

-- 5. Which staff member had the most transactions?
SELECT staff_id, COUNT(amount)
FROM payment
GROUP BY staff_id 
ORDER BY COUNT(amount) DESC;


SELECT *
FROM payment;

-- Reasoning
--Doing it this way shows the staff id with the most transactions at the top of the output list.
--The second selection is to figure out what columns I needed to pull from

-- 6. How many movies of each rating are there?
SELECT rating, COUNT(rating) as films
FROM film
GROUP BY rating;


SELECT *
FROM film;

-- Reasoning
-- Renamed count to films for easier reading. And instead of printing out a bunch of 1's ( happened numerous times )
-- This way prints out each film for each rating
--Second select helped me visualize what columns to pull from.

-- 7. Show all customers who have made a single payment above $6.99 (use subqueries)
SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id IN(
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    HAVING COUNT(DISTINCT amount) > 6.99
);

-- Reasoning
-- Similar thought process to question 2. we match the customer id's between the two tables
-- Then we find the distinct counts of payments above 6.99.


-- 8. How many free rentals did our stores give away?
SELECT COUNT(DISTINCT amount)
FROM payment
WHERE amount < 1;

SELECT COUNT(amount)
FROM payment
WHERE amount < 1;

-- Reasoning
--Assuming free means that they didn't pay. Which would be a negative number.
--I just found the distinct amounts that were less than $1
--If you just find the COUNT() it is 14,564
--I included both because I'm not sure exactly which one we want because 14k 'free' rentals is, well that's a store closing.
