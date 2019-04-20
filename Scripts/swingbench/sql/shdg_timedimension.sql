DROP TABLE times purge;

CREATE TABLE times AS
SELECT udate time_id,
  TO_CHAR(udate,'Day') day_name,
  TO_CHAR(udate,'DD') day_number_in_month,
  TO_CHAR(udate,'DDD') day_number_in_year,
  TO_CHAR(udate,'YYYY' ) calendar_year,
  TO_CHAR(udate,'Q' ) calendar_quarter_number,
  TO_CHAR(udate,'MM' ) calendar_month_number,
  TO_CHAR(udate,'WW' ) calendar_week_number,
  TO_CHAR(udate,'YYYY-MM') calendar_month_desc,
  TO_CHAR(udate,'YYYY-Q') calendar_quarter_desc
FROM
  (SELECT to_date('31/12/1994','DD/MM/YYYY')+rownum udate
  FROM all_objects
  WHERE to_date('31/12/1994','DD/MM/YYYY')+rownum <= to_date( '31/12/2014','DD/MM/YYYY')
  )
/


  