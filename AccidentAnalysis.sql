create database project;
use project;

show tables;

/*Question 1: *How many accidents occured in Rural vs Urban Area?*/
select count(*) from vehicle;

select area,count(accidentindex)
from accident group by area;

/*Question 2: Day Name wise accident count*/

update accident set `Date`= STR_TO_DATE(`DATE`,"%d/%m/%Y" );
alter table accident modify column `Date` DATE;

select dayname(`date`), count(accidentindex) from accident
group by dayname(`date`) order by count(accidentindex) desc;

/*Question 3: Average Age of Vehicles involved in accidents based on their type*/

select * from vehicle
where agevehicle is not null;

select vehicletype, count(accidentindex), round(avg(agevehicle)) from vehicle where agevehicle is not null 
group by vehicletype order by  count(accidentindex) desc ;

/*Question 4: Can we identify any trends in accidents based on the age of vehicles involved?*/


select AgeGroup, count(accidentindex),round(avg(agevehicle))
from (
select accidentindex, agevehicle, 
case
	when agevehicle between 0 and 4 then "New"
	when agevehicle between 5 and 8 then "Regular"
	when agevehicle between 9 and 10 then "old"
	else "Very Old" end as `AgeGroup`
from vehicle) as abc
group by AgeGroup;


/*Question 5: What is the percentage trend of each weather condition towards accidents*/

	SELECT
    WeatherConditions,
    COUNT(*) AS TotalAccidents,
    ROUND((COUNT(*) / (SELECT COUNT(*) FROM accident)) * 100, 2) AS Percentage
FROM
    accident
GROUP BY
    WeatherConditions
ORDER BY
    Percentage DESC;
   
   
/*Question 6: Do accidents often involve impacts on the left-hand side of vehicles?  */
   
select 
lefthand, count(accidentindex) from vehicle
where lefthand in ("No","yes")
group by lefthand;

/*Question 7: Are there any relationships between journey purposes and 
 the severity of accidents?*/

select * from accident;
select * from vehicle;

select v.JourneyPurpose,count(a.severity),
case 
	when count(a.severity) between 0 and 100 then "Very LOw"
	when count(a.severity) between 101 and 1000 then "Low"
	when count(a.severity) between 1001 and 5000 then "Medium"
	when count(a.severity) between 5001 and 20000 then "High"
	else "Very High" end as Status
from 
vehicle v inner join accident a 
on v.accidentindex=a.accidentindex
group by v.JourneyPurpose,a.severity
having v.journeypurpose != "Not Known"
order by count(a.severity) desc limit 5;

/*Question 8: Calculate the average age of vehicles involved 
  in accidents , considering Day light and point of impact*/

SELECT 
	A.LightConditions, 
	V.PointImpact, 
	Round(AVG(V.AgeVehicle)) AS 'Average Vehicle Year'
FROM 
	accident A
JOIN 
	vehicle V ON A.AccidentIndex = V.AccidentIndex
GROUP BY 
	V.PointImpact, A.LightConditions;

/*Question 9: Calculate the percentage distribution of accident severity.*/
SELECT Severity, COUNT(*) AS TotalAccidents,
       ROUND((COUNT(*) / (SELECT COUNT(*) FROM accident)) * 100, 2) AS Percentage
FROM accident
GROUP BY Severity;

/*Question 10: List the top 3 vehicle types involved in accidents with the highest average age.*/
SELECT VehicleType, ROUND(AVG(AgeVehicle), 2) AS AverageAge
FROM vehicle
GROUP BY VehicleType
ORDER BY AverageAge DESC
LIMIT 3;

/*Question 11: Find the average age of vehicles for each propulsion type.*/
SELECT Propulsion, ROUND(AVG(AgeVehicle)) AS AverageAge
FROM vehicle
GROUP BY Propulsion
having Averageage is not null;

/*Question 12: Calculate the percentage of accidents that
 *  occurred in daylight and darkness..*/
SELECT LightConditions, COUNT(*) AS TotalAccidents,
       ROUND((COUNT(*) / (SELECT COUNT(*) FROM accident)) * 100, 2) AS Percentage
FROM accident
GROUP BY LightConditions;

/*Question 13: Count the number of accidents for each road condition.*/
SELECT RoadConditions, COUNT(*) AS TotalAccidents
FROM accident
GROUP BY RoadConditions;


/*Question 14: */SELECT VehicleType, ROUND(AVG(SpeedLimit), 2) AS AverageSpeedLimit
FROM accident A
JOIN vehicle V ON A.AccidentIndex = V.AccidentIndex
GROUP BY VehicleType
ORDER BY AverageSpeedLimit DESC
LIMIT 3;

/*Question 15: Find the average age of vehicles for each area where accidents occurred.*/
SELECT Area, ROUND(AVG(AgeVehicle), 2) AS AverageAge
FROM accident A
JOIN vehicle V ON A.AccidentIndex = V.AccidentIndex
GROUP BY Area;

/*Question 16: Find the average age of vehicles for each weather condition
 where the average speed limit is higher than the overall average speed limit*/

SELECT roadconditions, ROUND(AVG(SpeedLimit), 2) AS AverageSpeedLimit
FROM accident
GROUP BY roadconditions
HAVING AverageSpeedLimit > (SELECT AVG(SpeedLimit) FROM accident);


/*Question 17:Calculate the percentage distribution of accidents 
 * for each road condition in areas with a speed limit above 50.*/
SELECT A.RoadConditions, COUNT(*) AS TotalAccidents,
       ROUND((COUNT(*) / (SELECT COUNT(*) FROM accident WHERE Area = A.Area AND SpeedLimit > 50)) * 100, 2) AS Percentage
FROM accident A
WHERE A.SpeedLimit > 50
GROUP BY A.RoadConditions, A.Area;

/*Question 18:Count the number of accidents where the weather 
 * condition contains the word 'wind'.*/

SELECT weatherconditions,COUNT(*) AS TotalAccidents
FROM accident
group by weatherconditions
having WeatherConditions REGEXP 'wind';












       
   
       
       
       
       
       
  


   
   
   

