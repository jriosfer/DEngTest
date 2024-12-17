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
