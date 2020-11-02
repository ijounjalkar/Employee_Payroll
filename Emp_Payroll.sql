//UC1

create database payroll_service;
show databases;
use payroll_service;
select database();

//UC2

create table employee_payroll
     (
     id              INT unsigned NOT NULL AUTO_INCREMENT,
     name            VARCHAR(150) NOT NULL,
     salary          Double NOT NULL,
     start           DATE NOT NULL,
     PRIMARY KEY     (id)
     );  
describe employee_payroll;

//UC3 & 4

insert into employee_payroll (name, salary, start) VALUES
    -> ('Bill', 1000000.00, '2018-08-04'),
    -> ('Terisa', 2000000.00, '2017-05-06'),
    -> ('Charlie', 30000000.00, '2020-05-06');
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
    -> where name = 'Terisa'
select *  from employee_payroll;
update employee_payroll
    -> set gender = 'M'
    -> where name = 'Bill', or 'Charlie';
select *  from employee_payroll;

//UC7

select avg(salary) from employee_payroll where gender='F';
select gender, avg(salary) from employee_payroll group by gender;
select gender, sum(salary) from employee_payroll group by gender;
select gender, min(salary) from employee_payroll group by gender;
select gender, max(salary) from employee_payroll group by gender;
select count(*) from employee_payroll;
select gender, count(*) from employee_payroll group by gender;

//UC8

alter table employee_payroll_service add phone numeric(10) after name;
alter table employee_payroll_service add address varchar(250) after phone;
alter table employee_payroll_service add department varchar(150) NOT NULL after address;
alter table employee_payroll_service alter address SET DEFAULT 'TBD';

//UC9

alter table employee_payroll_service RENAME COLUMN salary to basic_pay;
alter table employee_payroll_service add deductions double NOT NULL after basic_pay;
alter table employee_payroll_service add taxable_pay double NOT NULL after deductions;
alter table employee_payroll_service add tax double NOT NULL after taxable_pay;
alter table employee_payroll_service add net_pay double NOT NULL after tax;

//UC10

update employee_payroll_service set department = 'Sales' where name = 'Terisa'
insert into employee_payroll_service(name,department, gender, basic_pay, deductions, taxable_pay, tax, net_pay, start) 
       ->values ('Terisa','Marketing','F',3000000,1000000,2000000,500000,1500000,'2018-12-11');


//UC12

alter table employee_payroll_service rename to employee;
alter table employee rename column id to employeeId;
alter table employee add payroll_id int not null after gender;
create table department (employeeId int not null, departmentName varchar(100) not null,
                         foreign key (employeeId) references employee(employeeId));
create table payroll ( payroll_id int not null, basic_pay double not null, deductions double not null,
                      taxable_pay double not null, tax double not null, net_pay double not null, primary key (payroll_id));

alter table employee add foreign key(payroll_id) payroll(payroll_id);
create table phone_numbers (employeeId int not null, phone numeric(10) not null,
                            foreign key (employeeId) references employee(employeeId));
alter table employee drop column basic_pay, drop column deductions, drop column taxable_pay, drop column tax, drop column net_pay;

//UC13

select employee.employeeId, employee.name, phone_numbers.phone, employee.address, department.departmentName, employee.gender,
payroll.basic_pay, payroll.deductions, payroll.taxable_pay, payroll.tax, payroll.net_pay, employee.start
from employee 
inner join phone_numbers on employee.employeeId = phone_numbers.employeeId 
inner join employee_dept on employee.employeeId = department.employeeId
inner join payroll on employee.payroll_id = payroll.payroll_id;
