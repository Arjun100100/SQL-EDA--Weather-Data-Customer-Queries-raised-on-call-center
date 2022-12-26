/* Exploratory Data Analysis*/

use [Call Center Projects];

select top 10 *
from Call_Center;

/*Checking the shape of dataset*/

select count(*) as Number_of_rows
from Call_Center;
select count(*) as number_of_cols 
from INFORMATION_SCHEMA.COLUMNS 
where TABLE_NAME='Call_Center';


/*Checking distinct values*/

select distinct sentiment from Call_Center;
/*Very Negative
Negative
Neutral
Very Positive
Positive*/
select distinct reason from Call_Center;
/*Billing Question
Payments*/
select distinct channel from Call_Center;
/*Call-Center
Web
Email
Chatbot*/
select distinct call_center from Call_Center;
/* Baltimore/MD
Chicago/IL
Denver/CO
Los Angeles/CA */
select distinct response_time from Call_Center;
/* Below SLA
Above SLA
Within SLA */


/* Now lets calculate the pct of each category in columns*/

select sentiment,
count(*) counts,
cast(100.00*count(*)/(select count(*) from Call_Center) as decimal(4,2)) as pct
from Call_Center
group by sentiment;

select reason,
count(*) counts,
cast(100.0*count(*)/(select count(*) from Call_Center) as decimal(4,2)) as pct
from Call_Center
group by reason
order by count(*) desc;

select channel,
count(*) counts,
cast(100.0*count(*)/(select count(*) from Call_Center) as decimal(4,2)) as pct
from Call_Center
group by channel
order by count(*) desc;

select response_time,
count(*) counts,
cast(100.0*count(*)/(select count(*) from Call_Center) as decimal(4,2)) as pct
from Call_Center
group by response_time
order by count(*) desc;

select call_center,
count(*) counts,
cast(100.0*count(*)/(select count(*) from Call_Center) as decimal(4,2)) as pct
from Call_Center
group by call_center
order by count(*) desc;

select state,
count(*) counts
from Call_Center
group by state
order by count(*) desc;

/* Now we will find number of calls by days*/

select DATEname(dw,call_timestamp) as Day,
COUNT(*) as number_of_calls
from Call_Center
group by DATEname(DW,call_timestamp)
order by 2 desc;

/* Now lets checkout some aggregations */

select min(csat_score) as min_csat,
max(csat_score) as max_csat,
round(avg(cast(csat_score as float)),1) as avg_csat
from Call_Center;

select min(call_timestamp) as earliest_date, max(call_timestamp) as recent_date
from Call_Center;

select min(call_duration_in_minutes) as min_duration,
max(call_duration_in_minutes) as max_duration,
round(avg(cast(call_duration_in_minutes as float)),1) as avg_call_duration
from Call_Center;

select call_center, response_time, count(response_time) as response_time_counts
from Call_Center
group by call_center,response_time
order by call_center,response_time;

select call_center,round(avg(cast(call_duration_in_minutes as float)),1) as avg_call_duration
from Call_Center
group by call_center;


/*Lets max duration for each date*/

select distinct call_timestamp, max(call_duration_in_minutes) over(partition by call_timestamp) as max_call_duration
from Call_Center
group by call_timestamp, call_duration_in_minutes;