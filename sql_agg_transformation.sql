-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
select max(length) as max_duration, min(length) as min_durat
from film

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
select
CASE 
	WHEN AVG(length) > 60 THEN ROUND(AVG(length), -1)/ 60 
    END as Hours,
CASE
	WHEN AVG(length) > 60 THEN FLOOR(AVG(length)) % 60 
	END as Minutes
FROM film;

-- 2.1 Calculate the number of days that the company has been operating.
select max(rental_date) as most_recent, min(rental_date) as oldest, datediff(max(rental_date), min(rental_date)) as days_in_op
from rental
-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.

select rental_date, extract(month from rental_date) as month, weekday(rental_date) as day
FROM rental;
limit 20
-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week. Hint: use a conditional expression.
SELECT 
    rental_date,
    CASE 
        WHEN weekday(rental_date) IN (0, 1, 2, 3, 4) THEN 'Weekday'
        WHEN weekday(rental_date) IN (5, 6) THEN 'Weekend'
        ELSE NULL  -- or provide a default value or handle the case when it's not a weekday or weekend
    END AS day_category
FROM rental;


-- You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. 
-- If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order. Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
-- Hint: Look for the IFNULL() function.

SELECT title,
CASE 
	WHEN isnull(rental_duration) THEN REPLACE(rental_duration, null, 'Not Available')
    WHEN rental_duration THEN rental_duration
END as rental_duration
FROM film
ORDER BY title;


-- Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. 
-- To achieve this, you need to retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address, 
-- so that you can address them by their first name and use their email address to send personalized recommendations. The results should be ordered by last name in ascending order to make it easier to use the data.

select concat(first_name,' ', last_name) as full_name, LEFT(email, 3) as first_3
from customer

-- Challenge 2
-- 1.1 The total number of films that have been released.
select count(distinct(title))
from film 

-- 1.2 The number of films for each rating.

select distinct(rating), count(film_id)
from film
group by rating 

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
-- Using the film table, determine:
select distinct(rating), count(film_id)
from film
group by rating 
order by count(film_id) desc 

-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
select distinct(rating), avg(length) as al
from film
group by rating 
order by al desc 

2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
select distinct(rating), avg(length) as al
from film
group by rating 
having al > 120
order by al desc 