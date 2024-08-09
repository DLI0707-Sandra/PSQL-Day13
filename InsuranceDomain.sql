create table customers (customer_id int primary key,first_name varchar(25),last_name varchar(25),date_of_birth date,gender varchar(10),contact_number varchar(10),
email varchar(30),address varchar(25));
 
create table policies(policy_id int Primary key,policy_name varchar(25),policy_type varchar(25), coverage_details varchar(50),premium float8,start_date date,end_date date);
 
create table claims(claim_id int Primary key,claim_date date,claim_amount float8,approved_amount float8,claim_status varchar(25),policy_id int references policies(policy_id),customer_id int references customers(customer_id));
 
create table agents(agent_id int Primary key,first_name varchar(25),last_name varchar(25),contact_number varchar(25),email varchar(25),hire_date date);
 
create table policy_assignments (assignment_id int Primary Key, customer_id int references customers(customer_id),policy_id int references policies(policy_id) ,start_date date,end_date date);
 
create table claim_processing(processing_id int Primary key, claim_id int references claims(claim_id),processing_date date,payment_amount float8,payment_date date);
 
 
--DDL 
--Add a new column to the agents table:
 
alter table agents add column dob date;
 
--Rename the policy_name column in the policies table to policy_title
alter table policies rename column policy_name to policy_title;
 
--Drop the address column from the customers table
alter table customers drop column address;
 
--Adding data
insert into customers values(1,'Sandra','Davis','2002-04-04','Female','8590527328','sandra.davis@godigit.com');
insert into customers values(2,'Unnimaya','T','2001-10-17','Female','9832002345','unnimaya.t@godigit.com');
insert into customers values(3,'Gayathri','B','2002-06-04','Female','9962123456','gayathri@godigit.com');
 
insert into policies values(12,'Health insurance','Health','Hospital charges',120000.0,'2024-08-01','2025-08-01');
insert into policies values(23,'Life insurance','Life','Death',150000.0,'2024-01-01','2020-01-01');
insert into policies values(34,'Motor insurance','Auto','Maintenance charges',50000.0,'2024-08-01','2026-01-01');
 
--DML
--Update a policy's premium amount
update policies set premium =500000.0 where policy_type ='Auto';
select * from policies p where p.policy_type ='Auto';
 
--Delete a specific claim:
insert into claims values(1,'2024-08-08',1200000.0,800000.0,'Approved',12,2);
insert into claims values(2,'2024-08-05',500000.0,0.0,'Denied',34,3);
--Delete a specific claim:
delete from claims where claim_id=2;
 
--Insert a new policy assignment
insert into policy_assignments values(21,2,12,'2024-08-01','2025-08-01');
 
--JOIN queries
--Find all claims and the associated policy details
select * from policies p join claims c on  p.policy_id =c.policy_id ;
 
-- List all claims along with the customer details:
--select * from claims c join customers c2 on c.customer_id-c2.customer_id;
select * from claims c natural join customers c2  ;
 
--Get the total claim amount and number of claims per policy type
select p.policy_type ,sum(claim_amount) as sum_of_claim_amounts,count(*)as number_of_policies from claims c join policies p on c.policy_id =p.policy_id 
group by c.policy_id,p.policy_type ;
 
--Retrieve all customers with their assigned policies and agents
select * from customers c join policy_assignments pa on c.customer_id =pa.customer_id ;
 
--Find the most recent claim for each customer
 select c2.customer_id,c.claim_id ,c2.first_name,c2.last_name from claims c join customers c2 on c.customer_id =c2.customer_id  
where c.claim_date =(select max(claims.claim_date) from claims group by claims.customer_id)order by c.claim_date  desc ;