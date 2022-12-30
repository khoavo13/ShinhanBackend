-- Name: VO VAN DANG KHOA

--------------------------------------------------------------------------------
-- PART 1 - CREATE PROCEDURE
-- QUESTION 1.1
CREATE OR REPLACE PROCEDURE dept_info (
    id   IN  NUMBER,
    info OUT departments%rowtype
) IS
BEGIN
    SELECT *
    INTO info
    FROM
        departments
    WHERE
        department_id = id;
    
    EXCEPTION 
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No data found');
END;


DECLARE 
    info departments%rowtype;
BEGIN
    dept_info(10, info);
    dbms_output.put_line('Name department: ' || info.department_name);
END;

-- QUESTION 1.2
CREATE OR REPLACE PROCEDURE add_job (
    id   IN VARCHAR2,
    name IN VARCHAR2
) IS
BEGIN
    INSERT INTO jobs VALUES (
        id,
        name,
        NULL,
        NULL
    );
END;

BEGIN
    add_job('IT_TECH', 'Technician');
END;

-- QUESTION 1.3
CREATE OR REPLACE PROCEDURE update_comm (
    id IN NUMBER
) IS
BEGIN
    UPDATE employees
    SET
        commission_pct = commission_pct * 1.05
    WHERE
        employee_id = id;

    EXCEPTION
        WHEN no_data_found THEN
            dbms_output.put_line('No data found');
END;

BEGIN
    update_comm(7);
END;

-- QUESTION 1.4
CREATE OR REPLACE PROCEDURE ADD_EMP (
    emp IN EMPLOYEES%ROWTYPE
) IS
BEGIN
    INSERT INTO employees VALUES (
        emp.employee_id,
        emp.first_name,
        emp.last_name,
        emp.email,
        emp.phone_number,
        emp.hire_date,
        emp.job_id,
        emp.salary,
        emp.commission_pct,
        emp.manager_id,
        emp.department_id
    );
END;

DECLARE
    emp employees%rowtype;
BEGIN
    SELECT
        207,
        'Khoa',
        'Vo',
        'KVO',
        '515.123.8182',
        TO_DATE('2022/12/30', 'yyyy/mm/dd'),
        'AD_VP',
        5000,
        0.15,
        100,
        90
    INTO emp
    FROM
        dual;

    add_emp(emp);
END;

-- QUESTION 1.5
CREATE OR REPLACE PROCEDURE DELETE_EMP (
    ID IN EMPLOYEES.EMPLOYEE_ID%Type
) IS
BEGIN
    DELETE 
    FROM EMPLOYEES
    WHERE employees.employee_id = ID;
END;

BEGIN
    DELETE_EMP(207);
END;

-- QUAESTION 1.6
CREATE OR REPLACE PROCEDURE find_emp
IS         
BEGIN 
    FOR emp IN (SELECT *
        FROM employees e
            JOIN jobs j
            ON e.job_id = j.job_id
        WHERE j.min_salary < e.salary 
            AND j.max_salary > e.salary)
    LOOP
        DBMS_OUTPUT.PUT_LINE(
            emp.employee_id || 
            ',' || emp.first_name ||
            ',' || emp.last_name ||
            ',' || emp.hire_date ||
            ',' || emp.manager_id ||
            ',' || emp.department_id
        );
    END LOOP;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No data found');
END;

BEGIN
    find_emp();
END;


-- QUESTION 1.7
CREATE OR REPLACE PROCEDURE update_salary IS
    year_range FLOAT;
    inc        INTEGER;
BEGIN
    FOR emp IN (
        SELECT
            *
        FROM
            employees
    ) LOOP
        year_range := ( sysdate - emp.hire_date ) / 12;
        IF ( year_range > 2 ) THEN
            inc := 200;
        ELSIF ( year_range > 1 ) THEN
            inc := 100;
        ELSIF ( year_range = 1 ) THEN
            inc := 50;
        ELSE
            inc := 0;
        END IF;

        UPDATE employees
        SET
            salary = salary + inc
        WHERE
            employee_id = emp.employee_id;

    END LOOP;
END;

BEGIN 
    update_salary();
END;

-- QUESTION 1.8
CREATE OR REPLACE PROCEDURE job_his (
    emp_id  IN job_history.employee_id%TYPE
) IS 
BEGIN
FOR emp_his IN (
        SELECT
            *
        FROM
            job_history
        WHERE EMPLOYEE_ID = emp_id
    ) LOOP
        dbms_output.put_line('Start date: '
                     || emp_his.start_date
                     || ', End date: '
                     || emp_his.end_date
                     || ', Job ID: '
                     || emp_his.job_id
                     || ', Dapartment ID: '
                     || emp_his.department_id);
    END LOOP; 
END;

BEGIN
    job_his(114);
END;

-------------------------------------------------------------------------------
-- PART 2 - CREATE FUNCTION
-- QUESTION 2.1
CREATE OR REPLACE FUNCTION sum_salary (
    dept_id IN DEPARTMENTS.DEPARTMENT_ID%TYPE
) RETURN NUMBER IS
    sum_sal NUMBER;
BEGIN
    SELECT
        SUM(salary)
    INTO sum_sal
    FROM
        employees
    WHERE
        department_id = dept_id;
        
    IF sum_sal IS NULL
    THEN
        RETURN 0;
    ELSE
        RETURN sum_sal;
    END IF;
END;

SELECT sum_salary(300) from DUAL;

-- QUESTION 2.2
CREATE OR REPLACE FUNCTION name_con (
    id IN countries.country_id%TYPE
) RETURN countries.country_name%TYPE IS
    name countries.country_name%TYPE;
BEGIN
    SELECT
        country_name
    INTO name
    FROM
        countries
    WHERE
        country_id = id;

    RETURN name;
END;

SELECT
    name_con('AU')
FROM
    dual;
    
-- QUESTION 2.3
CREATE OR REPLACE FUNCTION annual_comp(salary  IN NUMBER, comm IN NUMBER)
RETURN NUMBER
IS
    income NUMBER;
BEGIN
    income := salary *(1+ comm) * 12;
    RETURN income;
END;

SELECT annual_comp(5000, 0.15)from DUAL;

-- QUESTION 2.4
CREATE OR REPLACE FUNCTION avg_salary(id IN EMPLOYEES.DEPARTMENT_ID%TYPE)
RETURN NUMBER 
IS
    avg_sal NUMBER(10);
BEGIN
    SELECT AVG(SALARY) INTO avg_sal FROM EMPLOYEES WHERE DEPARTMENT_ID = id;
    RETURN avg_sal;
END;

SELECT avg_salary(100) from DUAL;

-- QUESTION 2.5
CREATE OR REPLACE FUNCTION time_work (
    id_emp IN NUMBER
) RETURN NUMBER IS
    work_time NUMBER;
BEGIN
    SELECT
        months_between(sysdate, hire_date)
    INTO work_time
    FROM
        employees
    WHERE
        employee_id = id_emp;

    RETURN work_time;
END;

SELECT time_work(102) as Month FROM DUAL;

-------------------------------------------------------------------------------
-- PART 3 - CREATE TRIGGER
-- QUESTION 3.1
CREATE OR REPLACE TRIGGER hire_date BEFORE
    INSERT OR UPDATE ON employees
    FOR EACH ROW
DECLARE BEGIN
    IF :new.hire_date > sysdate THEN
        raise_application_error(-20000, 'ERROR: NGAY THUE LON HON NGAY HIEN HANH');
    END IF;
END;

-- QUESTION 3.2
CREATE OR REPLACE TRIGGER salary_min_max
BEFORE INSERT OR UPDATE
    ON jobs
    FOR EACH ROW
DECLARE
BEGIN
    IF :new.min_salary >= :new.max_salary 
    THEN
        RAISE_APPLICATION_ERROR(-20000, 'ERROR: MIN SALARY LON HON MAX SALARY');
    END IF;
END;

-- QUESTION 3.3
CREATE OR REPLACE TRIGGER date_job_history
BEFORE INSERT OR UPDATE 
    ON job_history
    FOR EACH ROW
DECLARE
BEGIN 
    IF :new.start_date > :new.end_date
    THEN
        RAISE_APPLICATION_ERROR(-20000, 'ERROR: NGAY BAT DAU LON HON NGAY KET THÚC');
    END IF;
END;

-- QUESTION 3.4
CREATE OR REPLACE TRIGGER salary_and_commission_employee
BEFORE UPDATE
    ON employees
    FOR EACH ROW
DECLARE
BEGIN 
    IF (:new.salary < :old.salary) OR (:new.commission_pct < :old.commission_pct)
    THEN
        RAISE_APPLICATION_ERROR(-20000, 'ERROR: LUONG VA HOA HONG DA GIAM KHI CAP NHAT');
    END IF;
END;
