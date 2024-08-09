reate table Authors (author_id serial primary key,
first_name varchar(25),
last_name varchar(25),
date_of_birth date,
nationality varchar(25))
 
 
create table Books (book_id serial primary key,
title varchar(25),
author_id serial ,
publication_year int,
genre varchar(25),
isbn varchar(25),
available_copies int ,
foreign key(author_id) references Authors(author_id))
 
 
create table Members (member_id serial primary key,
first_name varchar(25),
last_name varchar(25),
date_of_birth date,
contact_number varchar(10),
email varchar(25),
membership_date date
);
  
create table Staff (staff_id serial primary key,
first_name varchar(25),
last_name varchar(25),
position varchar(25),
contact_number varchar(10),
email varchar(25),
hire_date date);
create table loans(loan_id serial primary key,book_id serial ,member_id serial ,loan_date date,return_date date,actual_return_date date,foreign key(book_id) references books(book_id),foreign key(member_id) references members(member_id));
--
--DDL
--Add a new column to the books table
alter table books add column rating numeric(2,1);

--Rename the position column in the staff table to job_title
alter table staff rename column position to job_title;

--drop the email column from the members table:
alter table members drop column email;

--DML
--Insert new data into the books table
insert into authors(first_name,last_name,date_of_birth,nationality) values('John','Green','1980-09-12','American');
insert into books values(1,'Fault in the stars',1,'2010','rom','2134212',5,4.5);

--Update a member's contact number
insert into members values(1,'Sandra','Davis','2002-04-04','8590527328','2020-01-01');
update members set contact_number ='8590527322' where member_id =1;
select * from members;

--Insert a new loan record:
insert into loans values(1,1,1,'2024-04-04','2024-05-04',null);

--Delete a specific loan record:
delete from loans where loan_id=1;

--JOIN Queries
--Retrieve all books along with their authors:
select * from books b join authors a on b.author_id =a.author_id ;

--Find all books currently on loan along with member details
insert into loans values(2,1,1,'2024-04-04','2024-05-04',null);
select b.title,m.member_id,m.first_name,l.loan_id from books b join loans l on b.book_id=l.book_id join members m on m.member_id=l.member_id ;

--List all books borrowed by a specific member
select b.title from books b join loans l on l.book_id =b.book_id join members m on m.member_id =l.member_id where m.first_name='Sandra' ;


--Get the total number of books and the total available copies for each genre
select count(*) as number_of_books from books b; 
select b.genre,sum(available_copies) as tota_available_copies from books b group by b.genre;

--Find all staff members who are librarians and their hire dates
select * from staff where job_title = 'librarians';
