# Data-Engineering-ZoomCamp

Q1:  --rm 

 

 

Q2:  0.42.0 

 

docker run -it --entrypoint bash python:3.9 

 

 

Q3: 15767 

 

SELECT  

COUNT(1) 

FROM public.green_taxi_data 

WHERE lpep_pickup_datetime::date >= '2019-09-18'  AND lpep_pickup_datetime::date < '2019-09-19' 

LIMIT 100; 

 

 

Q4: 2019-09-26 

 

SELECT  

lpep_pickup_datetime as "pickup", trip_distance as "distance", total_amount 

FROM public.green_taxi_data 

ORDER BY "distance" DESC 

LIMIT 100; 

 

Q5: "Brooklyn" "Manhattan" "Queens" 
 
SELECT  

z."Borough", 

SUM(t."total_amount") 

FROM  

public.green_taxi_data t JOIN zones z 

ON t."PULocationID" = z."LocationID" 

WHERE  

lpep_pickup_datetime::date >= '2019-09-18' AND lpep_pickup_datetime::date < '2019-09-19' 

GROUP BY z."Borough" 

ORDER BY SUM(t."total_amount") DESC 

 

 

Q6: JFK Airport 
 
SELECT  

t."PULocationID", 

t."DOLocationID", 

zpu."Zone" as "PUZone", 

zdo."Zone" as "DOZone", 

t."tip_amount" 

FROM  

public.green_taxi_data t JOIN zones zpu 

ON t."PULocationID" = zpu."LocationID" 

JOIN zones zdo 

ON t."DOLocationID" = zdo."LocationID" 

WHERE  

lpep_pickup_datetime::date >= '2019-09-01' AND lpep_pickup_datetime::date < '2019-10-01' AND zpu."Zone" = 'Astoria' 

ORDER BY t."tip_amount" DESC 
