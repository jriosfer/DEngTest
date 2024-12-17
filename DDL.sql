CREATE TABLE department (
    deptno          VARCHAR2(25) NOT NULL,
    department_name VARCHAR2(512) NOT NULL,
    creation_date   TIMESTAMP NOT NULL,
    created_by      VARCHAR2(128) NOT NULL,
    updated_date    TIMESTAMP,
    updated_by      VARCHAR2(128)
);

COMMENT ON COLUMN department.deptno IS
    'Department Code';

COMMENT ON COLUMN department.department_name IS
    'Department Name or Business area name';

COMMENT ON COLUMN department.creation_date IS
    'Record''s creation date';

COMMENT ON COLUMN department.created_by IS
    'Record created  by';

COMMENT ON COLUMN department.updated_date IS
    'Record''s update  date';

COMMENT ON COLUMN department.updated_by IS
    'Record updated by';

ALTER TABLE department ADD CONSTRAINT department_pk PRIMARY KEY ( deptno );


CREATE TABLE employee (
    employee_id   NUMBER NOT NULL,
    name          VARCHAR2(512) NOT NULL,
    last_name     VARCHAR2(128),
    middle_name   VARCHAR2(128),
    creation_date TIMESTAMP NOT NULL,
    created_by    VARCHAR2(128) NOT NULL,
    updated_date  TIMESTAMP,
    updated_by    VARCHAR2(128)
);

COMMENT ON COLUMN employee.employee_id IS
    'employee''s ID';

COMMENT ON COLUMN employee.name IS
    'Employees''s name';

COMMENT ON COLUMN employee.last_name IS
    'Last name';

COMMENT ON COLUMN employee.middle_name IS
    'Middle name if applies';

COMMENT ON COLUMN employee.creation_date IS
    'Record''s creation date';

COMMENT ON COLUMN employee.created_by IS
    'Record created  by';

COMMENT ON COLUMN employee.updated_date IS
    'Record''s update  date';

COMMENT ON COLUMN employee.updated_by IS
    'Record updated by';

ALTER TABLE employee ADD CONSTRAINT employee_pk PRIMARY KEY ( employee_id );


CREATE TABLE job (
    department_deptno    VARCHAR2(25),
    employee_employee_id NUMBER,
    salary               NUMBER(3) NOT NULL,
    from_date            TIMESTAMP NOT NULL,
    until_date           TIMESTAMP,
    creation_date        TIMESTAMP NOT NULL,
    created_by           VARCHAR2(128) NOT NULL,
    updated_date         TIMESTAMP,
    updated_by           VARCHAR2(128)
);

COMMENT ON COLUMN job.salary IS
    'Salary amount (monthly)';

COMMENT ON COLUMN job.from_date IS
    'From the salary is valid';

COMMENT ON COLUMN job.until_date IS
    'Until  the salary is valid';

COMMENT ON COLUMN job.creation_date IS
    'Record''s creation date';

COMMENT ON COLUMN job.created_by IS
    'Record created  by';

COMMENT ON COLUMN job.updated_date IS
    'Record''s update  date';

COMMENT ON COLUMN job.updated_by IS
    'Record updated by';

ALTER TABLE job
    ADD CONSTRAINT job_department_fk FOREIGN KEY ( department_deptno )
        REFERENCES department ( deptno );

ALTER TABLE job
    ADD CONSTRAINT job_employee_fk FOREIGN KEY ( employee_employee_id )
        REFERENCES employee ( employee_id );
		


CREATE TABLE department_load (
    record_id       number not null primary key,
    deptno          VARCHAR2(25) NOT NULL,
    department_name VARCHAR2(512),
    creation_date   VARCHAR2(128) NOT NULL,
    created_by      VARCHAR2(128) NOT NULL,
    updated_date    VARCHAR2(128),
    updated_by      VARCHAR2(128),
	loading_date    TIMESTAMP,
    loading_by      VARCHAR2(128)
);

COMMENT ON COLUMN department_load.deptno IS
    'Department Code';

COMMENT ON COLUMN department_load.department_name IS
    'Department Name or Business area name';

COMMENT ON COLUMN department_load.creation_date IS
    'Record''s creation date';

COMMENT ON COLUMN department_load.created_by IS
    'Record created  by';

COMMENT ON COLUMN department_load.updated_date IS
    'Record''s update  date';

COMMENT ON COLUMN department_load.updated_by IS
    'Record updated by';
	


CREATE TABLE employee_load (
    record_number   number not null primary key,
    employee_id   NUMBER NOT NULL,
    name          VARCHAR2(512),
    last_name     VARCHAR2(128),
    middle_name   VARCHAR2(128),
    creation_date VARCHAR2(128) NOT NULL,
    created_by    VARCHAR2(128) NOT NULL,
    updated_date  VARCHAR2(128),
    updated_by    VARCHAR2(128),
	loading_date    TIMESTAMP,
    loading_by      VARCHAR2(128)
);

COMMENT ON COLUMN employee_load.employee_id IS
    'employee''s ID';

COMMENT ON COLUMN employee_load.name IS
    'Employees''s name';

COMMENT ON COLUMN employee_load.last_name IS
    'Last name';

COMMENT ON COLUMN employee_load.middle_name IS
    'Middle name if applies';

COMMENT ON COLUMN employee_load.creation_date IS
    'Record''s creation date';

COMMENT ON COLUMN employee_load.created_by IS
    'Record created  by';

COMMENT ON COLUMN employee_load.updated_date IS
    'Record''s update  date';

COMMENT ON COLUMN employee_load.updated_by IS
    'Record updated by';


CREATE TABLE job_load (
record_number number not null primary key,
    deptno        VARCHAR2(25),
    employee_id   NUMBER,
    salary        VARCHAR2(128),
    from_date     VARCHAR2(128),
    until_date    VARCHAR2(128),
    creation_date VARCHAR2(128) NOT NULL,
    created_by    VARCHAR2(128) NOT NULL,
    updated_date  VARCHAR2(128),
    updated_by    VARCHAR2(128),
	loading_date    TIMESTAMP,
    loading_by      VARCHAR2(128)
);

COMMENT ON COLUMN job_load.salary IS
    'Salary amount (monthly)';

COMMENT ON COLUMN job_load.from_date IS
    'From the salary is valid';

COMMENT ON COLUMN job_load.until_date IS
    'Until  the salary is valid';

COMMENT ON COLUMN job_load.creation_date IS
    'Record''s creation date';

COMMENT ON COLUMN job_load.created_by IS
    'Record created  by';

COMMENT ON COLUMN job_load.updated_date IS
    'Record''s update  date';

COMMENT ON COLUMN job_load.updated_by IS
    'Record updated by';
	
	
create sequence JOB_LOAD_NEXT
start with 1
increment by 1
cache 20
minvalue 1
maxvalue 999999999999999999999999
nocycle;


create sequence EMPLOYEE_LOAD_NEXT
start with 1
increment by 1
cache 20
minvalue 1
maxvalue 999999999999999999999999
nocycle;


create sequence DEPTNO_LOAD_NEXT
start with 1
increment by 1
cache 20
minvalue 1
maxvalue 999999999999999999999999
nocycle;	


create or replace trigger DEPARTMENT_LOAD_BI
before
insert or update or delete on DEPARTMENT_LOAD
for each row
begin
    :new.record_id := DEPTNO_LOAD_NEXT.nextval;
	:new.loading_date := systimestamp;
    :new.loading_by:= v('APP_USER');
	
end;
/

create or replace trigger EMPLOYEE_LOAD_BI
before
insert or update or delete on EMPLOYEE_LOAD
for each row
begin
    :new.record_number := EMPLOYEE_LOAD_NEXT.nextval;
	:new.loading_date := systimestamp;
    :new.loading_by:= v('APP_USER');
	
end;
/

create or replace trigger JOB_LOAD_BI
before
insert or update or delete on JOB_LOAD
for each row
begin
    :new.record_number := JOB_LOAD_NEXT.nextval;
	:new.loading_date := systimestamp;
    :new.loading_by:= v('APP_USER');
	
end;
/