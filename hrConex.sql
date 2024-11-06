CREATE TABLE copy_employees AS (SELECT * FROM hr.employees);


-- 1 Criando uma View Básica:
--○ Crie uma view chamada vw_empregados_info que exiba o nome completo
--(concatenando first_name e last_name), o cargo (job_id) e o salário (salary) de todos os
--empregados.

create or replace view vw_empregados_info ("NOME","CARGO","SALARIO")
AS
select first_name || ' ' || last_name, job_id, salary 
from copy_employees;

select * from vw_empregados_info;


-- 2
--Filtrando Dados em uma View:
--Crie uma view chamada vw_empregados_alta_renda que mostre os detalhes dos
--empregados (ID, nome completo, cargo e salário) que ganham mais de 10.000.

create or replace view vw_empregados_alta_renda ("ID","Nome","cargo","salario")
as
select employee_id, first_name || ' ' || last_name,job_id,salary
from copy_employees
where salary > 10000;
select * from vw_empregados_alta_renda;


--3
--View com Junção de Tabelas
--Crie uma view chamada vw_empregados_departamento que mostre o nome completo
--do empregado, o nome do departamento (department_name) e a cidade (city) onde o
--departamento está localizado. Utilize as tabelas employees, departments e locations.

create or replace view vw_empregados_departamento ("Nome","Departamento","Cidade")
as
select e.first_name || ' ' || e.last_name, d.department_name, l.city
from employees e
join departments d on e.department_id = d.department_id
join locations l on d.location_id = l.location_id;

select * from vw_empregados_departamento;

--4 View com Agregação:
--○ Crie uma view chamada vw_salario_medio_departamento que mostre o nome do
--departamento e o salário médio dos empregados em cada departamento.

create or replace view vw_salario_medio_departmento ("Departamento","Salario Medio")
as
select d.department_name, avg(e.salary)
from departments d
join employees e on d.department_id = e.department_id

select * from vw_salario_medio_departmento;


