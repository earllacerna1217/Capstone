/*
a) thie information included in "Column" are actor_id, first_name, last_name and last_update
b) Inside the film -> column the information included are film_id, title, descriptino, release_year, language_id, original_language_id, rental_duration, rental_rate, length, replacement_cost, rating, special_features and last_update. 
film_actorfilm_categoryfilm_textrentalstaff
c) film_actor table also has film_id and actor_id in it's table
d) you can find the records of rental_date, inventory_id, customer_id, return_date, staff_id and last_update. In my opinion, it is easy to read because I was able to figure out what these records mean, it indicates that this is the record of when was the rental was borrowed, what did they rent, which customer rented it, and which staff rented them the rented object
e) this table includes inventory_id which is the primary number of each of movie and film_id which also tells what movie are they renting and the last update about these information recoreded. It's not the easiest to read because there's 2 value that are partial dependent to each other which is the inventory_id and film_id but I just figured that it's tells the same information
*/

Select *  from film;
Select * from rental;



