CREATE DATABASE ceng302_hw3;

create table Author (
authorID varchar(5),
Aname varchar(20),
surname varchar(20),
primary key (authorID)
);

create table Book (
isbn varchar(50) ,
authorID varchar(5),
title varchar(50),
publisher varchar(50),
subject varchar(50),
primary key (isbn),
foreign key (authorID) references Author on delete cascade 
);

create table Borrowed (
isbn varchar(50) ,
dueDate date,
studentID varchar(7), 
returnDate date,
primary key (isbn , dueDate),
foreign key (isbn) references Book on delete cascade ,
foreign key (studentID) references Student on delete cascade 

 );

create table Student (
studentID varchar(7), 
Sname varchar(40),
surname varchar(40),
email varchar(255),
primary key (studentID)

);


--drop table borrowed   
--drop table book      
--drop table student        
--drop table author          
--
select  * from student  
select  * from author a  
select  * from book b  
select  * from borrowed   
--

 

--q1
select isbn 
from borrowed 
where dueDate >  '2023-10-08';


--q2
select b.isbn 
from author a ,book b    
where a.authorid = b.authorid and aname ='Yuval Noah' and surname = 'Harari'


--q3
select b.studentID
from borrowed b ,book b2 
where b.isbn = b2.isbn and title ='1984'

--q4

select b.studentID
from borrowed b ,book b2 
where b.isbn = b2.isbn and subject ='Database'
intersect 
select b.studentID
from borrowed b ,book b2 
where b.isbn = b2.isbn and subject ='Civilization'


--q5

select b1.studentid 
from Borrowed b1,Book b2,Author a
where b1.isbn = b2.isbn and b2.authorid = a.authorid and a.aname ='Michio'

--q6
select b1.isbn 
from book b1    
where b1.authorid  =(select b2.authorid 
 from book b2
 where b2.title='Sapiens'
) and title !='Sapiens'

--q7

select tempt.sname , tempt.surname 
from (
 select s.sname ,s.surname , b.studentid , count(*) as booksNum
 from borrowed b , student s 
 where s.studentid =b.studentid 
 group by b.studentid,s.sname ,s.surname) as tempt    
 where tempt.booksNum = (select max(booksNum)
                       from ( select s.sname ,s.surname , b.studentid , count(*) as booksNum
 from borrowed b , student s 
 where s.studentid =b.studentid 
 group by b.studentid,s.sname ,s.surname))
  

 
--q8

select s.sname, s.surname
from student s 
where not exists (
(
 select b.isbn  
 from borrowed b ,student s1 
 where b.studentid =s1.studentid and s1.sname ='Emre'

)
except
(
select b.isbn
from  borrowed b 
where b.studentid = s.studentid

)) and s.sname !='Emre'

--insert into borrowed 
--values ('9780136086208' ,'12.12.2023','7890000','12.12.2024')
--insert into borrowed 
--values ('9780136086208' ,'4.11.2023','4560000','12.11.2024')
--insert into borrowed 
--values ('9780062316103' ,'3.02.2023','4560000','12.12.2024')
--insert into borrowed 
--values ('9780385530804' ,'5.02.2023','4560000','12.12.2024')
--
--




