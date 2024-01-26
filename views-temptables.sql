-- Step 1: Create a View First, create a view that summarizes rental information for each customer. The view should include the customer's ID, name, email address, and total number of rentals (rental_count).

CREATE VIEW rental_info as
select customer_id, first_name, email, count(rental_id) as rental_count
from customer
inner join rental 
using(customer_id)
group by customer_id

-- Step 2: Create a Temporary Table Next, create a Temporary Table that calculates the total amount paid by each customer (total_paid). 
-- The Temporary Table should use the rental summary view created in Step 1 to join with the payment table and calculate the total amount paid by each customer.

create temporary table total_paid as 
select rental_info.*, sum(payment.amount) as total_amount_paid
from rental_info
inner join payment
on rental_info.customer_id = payment.customer_id 
group by customer_id

-- Step 3: Create a CTE and the Customer Summary Report
-- Create a CTE that joins the rental summary View with the customer payment summary Temporary Table created in Step 2. The CTE should include the customer's name, email address, rental count, and total amount paid.
-- Next, using the CTE, create the query to generate the final customer summary report, which should include: customer name, email, rental_count, total_paid and average_payment_per_rental, 
-- this last column is a derived column from total_paid and rental_count.

WITH rental_summary AS (
    SELECT total.paid.*, (total_paid/rental count)
    FROM total_paid
    
)
