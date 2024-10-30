

-- desafio Como analisar o tempo de empresa dos
--funcionários e categorizá-los em "Novatos",
--"Experientes" e "Veteranos"

select first_name,hire_date,
    case 
    when  months_between(sysdate,hire_date) < 220 then  'Novato'
    when months_between(sysdate,hire_date) between  220 and 240 then 'Experientes'
    else 'Veterano'
    end as tempo_de_empresa
    from employees;
    
    
    
--------------------------------------------------------------------------
--ex 1 Quais funcionários trabalham em departamentos localizados nos EUA e também
--possuem histórico em departamentos localizados também nos EUA? Utilize o
--operador INTERSECT para encontrar a interseção entre duas consultas que selecionam os
--funcionários com base na localização atual e no histórico de trabalho.


select e.employee_id from employees e
    join departments d on e.department_id = d.department_id
    join locations l on d.location_id = l.location_id
    join countries c on l.country_id = c.country_id
    where c.country_name = 'United States of America' 
intersect 
    select employee_id from job_history j
    join departments d on j.department_id = d.department_id
    join locations l on  d.location_id = l.location_id
    join countries c on l.country_id = c.country_id
    where c.country_name = 'United States of America';
--  verificar se essa ta certa

select unique employee_id  from job_history;

select employee_id
from employees e join departments d on e.department_id=d.department_id
    join locations l on l.location_id=d.location_id
    join countries c on c.country_id=l.country_id
where c.country_name='United States of America'
intersect
select employee_id
from job_history j join departments d on j.department_id=d.department_id
    join locations l on l.location_id=d.location_id
    join countries c on c.country_id=l.country_id
where c.country_name='United States of America';



-- ex 2 Exiba os nomes dos países que possuem escritórios mas não possuem
--funcionários. Utilize o operador MINUS para encontrar os países que estão na tabela
--locations mas não na tabela employees (através da junção com departments).

select c.country_name from countries c
join locations l on c.country_id = l.country_id
join departments d on l.location_id = d.location_id
join employees e on d.department_id = e.department_id
where e.department_id = null

minus
select d.department_name from departments d
join employees e on d.department_id = e.department_id
where manager_id = null;





