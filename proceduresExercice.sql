SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE add_dept
IS
dept_id departments.department_id%TYPE;
dept_name departments.department_name%TYPE;
BEGIN
SELECT MAX(department_id) INTO dept_id
FROM departments;
dept_name:='Novo Departamento';
INSERT INTO departments
(department_id,department_name)
VALUES((dept_id + 1),dept_name);
DBMS_OUTPUT.PUT_LINE('Inserida '|| SQL%ROWCOUNT ||'
linha.');
END;




create or replace procedure exibir_dept
is
dept_name departments.department_name%TYPE;
begin
select department_name into dept_name
from departments
where department_id = 240;
DBMS_OUTPUT.PUT_LINE('Nome departmento' || 'dept_name');
END;


exec exibir_dept;


create or replace procedure exibir_dept2(
dept_id departments.department_id%TYPE)
is
dept_name departments.department_name%TYPE;
begin
select department_name into dept_name
from departments
where department_id = dept_name;
DBMS_OUTPUT.PUT_LINE('Nome departmento' || 'dept_name');
END;

begin
exibir_dept2(240);
end;



------------------



create or replace procedure p(
    a integer,
    b in integer,
    c out integer,
    d in out float
)is
begin
DBMS_OUTPUT.PUT_LINE('Dentro do procedimento p:');
DBMS_OUTPUT.PUT_LINE('IN a =' || a);
DBMS_OUTPUT.PUT_LINE('IN b =' || b);
DBMS_OUTPUT.PUT_LINE('out c =' || c);
DBMS_OUTPUT.PUT_LINE('in out d =' || d);
c := a+b;
d := a/b;
end;


DECLARE
x INTEGER := 10;
y INTEGER := 2;
z INTEGER;
w FLOAT := 5;

BEGIN
DBMS_OUTPUT.PUT_LINE('ANTES do procedimento p:');
DBMS_OUTPUT.PUT_LINE('x = ' || x);
DBMS_OUTPUT.PUT_LINE('y = ' || y);
DBMS_OUTPUT.PUT_LINE('z = ' || z);
DBMS_OUTPUT.PUT_LINE('w = ' || w);
p(x,y,z,w);
DBMS_OUTPUT.PUT_LINE('DEPOIS do procedimento p:');
DBMS_OUTPUT.PUT_LINE('x = ' || x);
DBMS_OUTPUT.PUT_LINE('y = ' || y);
DBMS_OUTPUT.PUT_LINE('z = ' || z);
DBMS_OUTPUT.PUT_LINE('w = ' || w);
END;


CREATE OR REPLACE FUNCTION check_sal(
empno employees.employee_id%TYPE)
RETURN BOOLEAN IS
dept_id employees.department_id%TYPE;
sal employees.salary%TYPE;
avg_sal employees.salary%TYPE;
BEGIN
SELECT salary,department_id INTO sal, dept_id
FROM employees WHERE employee_id = empno;
SELECT AVG(salary) INTO avg_sal
FROM employees WHERE department_id = dept_id;
IF sal > avg_sal THEN
RETURN TRUE;
END IF;
RETURN FALSE;
END;

BEGIN
IF (check_sal(101)) THEN
DBMS_OUTPUT.PUT_LINE('Salário > média');
ELSE
DBMS_OUTPUT.PUT_LINE('Salário < média');
END IF;
END;


drop procedure add_dept;
drop procedure exibir_dept;
drop procedure exibir_dept2;
drop function chech_hiredate;
    
--- lista de exercicios

--1. Elabore uma função que, dado o id do empregado, retorne quantos empregados são mais antigos
--que ele na empresa

create or replace function chech_hiredate(
empt employees.employee_id%TYPE)
return number is
hiredate employees.hire_date%TYPE;
qtd employees.employee_id%TYPE;
begin
select hire_date into hiredate
from employees where employee_id = empt;

select count(employee_id) into qtd
from employees where hiredate < employees.hire_date;

return qtd;
end;

BEGIN
IF (check_hiredate(100)) THEN
DBMS_OUTPUT.PUT_LINE('quantidade');
END IF;
END;


-- 2    
--O departamento de IT, localizado no estado americano do Texas, fica próximo de uma estação de
--exploração petrolífera e, devido a uma lei regulamentada nos EUA, os funcionários devem receber
--um adicional de 20% no salário devido à periculosidade.

--Elabore um procedimento que exiba na tela o nome e sobrenome do empregado e o valor do
--adicional de periculosidade, considerando todos os empregados que possuem esse direito.

--CREATE OR REPLACE PROCEDURE add_periculosidade(
--empt employees.employee_id%TYPE) is
--nameF employees.first_name%TYPE;
--lastname employees.last_name%TYPE;
--begin
--select employee_id into empt
--where employee_id



