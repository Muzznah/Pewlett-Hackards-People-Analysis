# Pewlett-Hackard-Analysis
## Background
The purpose of this assignment was to help, Pewlett Hackard (PH) future-proof the company, by determining how many people would be retiring soon, and of those, how many ,can be engaged as mentors for the new hires. 
## Resources
Software used: PostgreSQL 11.8 and pgAdmin 4.21
## Approach & Challenges faced.
The task was achieved by upgrading PH’s database from simple CSV files to an operational SQL database, and then performing queries with conditionals. The steps taken for transformation were as follows:

-	An ERD, mapping the existing data tables, their attributes, and dependencies was created on https://app.quickdatabasediagrams.com/.

    ![](https://github.com/Muzznah/Pewlett-Hackard-Analysis/blob/master/Images/EmployeeDB.png)

-	Using pgAdmin the ERD was translated into a postgress database, named “PH-EmployeeDB”.
  
-	The six csv files (Data, Salaries, Titles, Dept_Manager, Dept_Emp and Department) were imported into tables with corresponding names.   For details see, [schema_tableCreation.sql].
  
-	Finally, the database was queried to determine the number of current employees that were eligible to retire, and were qualified for
  the mentorship roles. For details view [queries.sql](https://github.com/Muzznah/Pewlett-Hackard-Analysis/blob/master/Queries/queries.sql)
  
### Number of individuals retiring

-	The retiree criteria was established as: 

    -	Birth dates: between 1952-01-01 to 1955-12-31

    -	Hired dates: between 1985-01-01 to 1988-12-31

    -	Currently employed: “to_date” column filtered for “9999-01-01”

-	The table “employees” was filtered for the birthdate, and hire date, and saved into a new table; "retirement_info".

-	The "retirement_info" table was then left-joined to "dept_emp" table and the currently employed criterion was fulfilled by, filtering
  for "to_date" equals to “9999-01-01”. This new information was saved as "current_emp" table.

-	To get a retiree count by title, the “current_emp” table was inner-joined with “salaries” and “title”, to get the columns; “from_date”
  and “salary”, and saved as “title_info”

-	Duplicate rows in the created table were handled through partitioning function. The table was partitioned by “emp_no” with “from_date”
  sorted in descending, to get the current title for each “emp_no”. The duplicate free information was saved into “current_title_info”
  table (exported as “current_title_info.csv”).

-	Finally, count function was perfomed on “emp_no” of “current_title_info” table and was saved in table "retiree_counttBytitle”
  (exported as “retiree_counttBytitle.csv”).

## Number of individuals being hired

-	This part was challenging in terms of interpreting the ask. Was it asking for individuals being hired this year? Or those that will be
  hired in the following years due to retirements.

-	The information for hiring was only present in the “employees” table in the form of “hire_date” column. To get the latest hiring date   following code was used:

    SELECT * FROM employees ORDER BY hire_date DESC;

-	The above query showed that the latest hiring data available was of “2000-01-03”

-	The number of people hired in total by the company, based on the data provided was 300,024. Calculated using the following:

    SELECT COUNT(emp_no) FROM employees;

-	The number of people hired in year 2000 was 13. Calculated using the following:

    _SELECT COUNT(emp_no) FROM employees
    WHERE hire_date BETWEEN '2000-01-01' AND '2000-12-31' ;_

## Number of individuals available for mentorship role

-	To get the number of individuals available for mentorship roles “current_title_info” table  was inner-joined to "titles" to include
  the "to_date" column, and inner-joined to "employees" to filter for birth dates for year 1965 only.  The filtered data was saved as
  “mentor_list” table.

-	The challenge encountered at this stage was that the output of the above function was a data less table. Year 1965 was beyond the
  criteria range choosen to filter retirees in "reitirement_info" table. In order to populate the “mentor_list” table based on the
  "current_title_info" table (table made in part one) and the birth date between "1965-12-31" to "1965-01-01", all the tables  starting   with “retirement_info” were dropped and recreated with a birth date between “1952” to “1965”.

      --Drop and recreate tables to include birth date till 1965.

      DROP TABLE retirement_info;

      DROP TABLE current_emp;

      DROP TABLE title_info;

      DROP TABLE current_title_info;

      DROP TABLE retiree_countBytitle;

      DROP TABLE mentor_list;

-	The first step was repeated to create the “mentor_list” table.

-	Quick inspection of the table showed that the table needed to be treated for duplicate rows.

-	The partitioning function was used again to get the current title of the retiree and was saved as “mentor_list_final” table 
  (exported as “mentor_list_final.csv”).

-	Finally, the count function (on ‘emp_no’) along with group by (on ‘title’)  was used to get “mentor_countBytitle” table (exported as
  “mentor_countBytitle.csv”).

## Summary & Result
-	the number of individuals retiring is 108,958, for potential retiree’s criterion set at:
      -	55-68 years of age

      -	birthdates between 1965-12-31 and 1952-01-01

      -	hire dates between 1988-12-31 and 1985-01-01 (worked 31-35 years) 

      -	currently employed
-	the number of individuals retiring is 33,118, for potential retiree’s criterion set at: 
      -	65-68 years of age
      
      -	birthdates between 1955-12-31 and 1952-01-01
      
      -	hire dates between 1988-12-31 and 1985-01-01 (worked 31-35 years) 
      
      -	currently employed
      
-	the number of individuals retiring based on birth year, for age 68:
![](https://github.com/Muzznah/Pewlett-Hackard-Analysis/blob/master/Images/AnualRetirementTable.png)

        

-	For counts of potential retirees by job title, see retiree_countbytitle.csv.

-	For a table of potential retirees with titles, see current _title_info.csv.

-	Total number of employees hired by HP are 300,024 and the number of employees hired only in year 2000 are 13.

-	Based on the calculation of people retiring in year 2020, the same count would be rehired for vacancies created.

-	The number of retirees that are eligible to be mentors is 691, for potential mentor criterion set as:

    -	55 years-old, born in year 1965.
    
    -	hire dates between 1988-12-31 and 1985-01-01.
    
    -	Currently employed.

-	For count of mentors by title, see mentor_countbytitle.csv.

-	For a table of potential mentors with job title, see mentor_list_final.csv.

## Limitations & Recommendations:
-	The data for hire dates is dated. There is no data available for hiring after January 2000.

-	The data for salaries is not updated as it was observed that the same salary was carried forward with the change in title and
  promotion.

-	Create a table for mentors grouped by department to see the number of mentors available per department.

-	Create a table for number of retirees grouped by department to plan for department wise hiring for the future.

-	Create a table of potential future department managers based on a filter criterion of number of years worked in a department. These 
  employees could be paired with retiring managers for mentorship.

-	Determine number of potential employees or new hires that can be enrolled into the mentor program. This can be determined by filtering 
  for hire dates and years served.

-	Break down of retirees per year to determine an average number of retirees per year for annual hiring plans.
