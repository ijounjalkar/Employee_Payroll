//UC1

create database payroll_service;
show databases;
use payroll_service;
select database();

//UC2

create table employee_payroll
     (
     id              INT unsigned NOT NULL AUTO_INCREMENT,
     Name            VARCHAR(150) NOT NULL,
     Salary          Double NOT NULL,
     Start           DATE NOT NULL,
     PRIMARY KEY     (id)
     );  
describe employee_payroll;

//UC3 & 4

insert into employee_payroll (name, salary, start) VALUES
    -> ('Bill', 109089.00, '2018-08-04'),
    -> ('Terisa', 887682.00, '2017-05-06'),
    -> ('Charlie', 8667388.00, '2020-05-06');
select*from employee_payroll;

//UC5

select salary from employee_payroll where name = 'Bill';
select * from employee_payroll where start between cast('2018-08-03' as date) and date(NOW());

//UC6

alter table employee_payroll
    -> add gender char(1)
    -> after name;
describe employee_payroll;
update employee_payroll
    -> set gender = 'F'
    -> where name = 'Isha' or name = 'Leena'
select *  from employee_payroll;
update employee_payroll
    -> set gender = 'M'
    -> where name = 'Tushar'
select *  from employee_payroll;

//UC7

select avg(salary) from employee_payroll where gender='F';
select gender, avg(salary) from employee_payroll group by gender;
select gender, sum(salary) from employee_payroll group by gender;
select gender, min(salary) from employee_payroll group by gender;
select gender, max(salary) from employee_payroll group by gender;
select count(*) from employee_payroll;
select gender, count(*) from employee_payroll group by gender;

