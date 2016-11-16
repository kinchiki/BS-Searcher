create table companies (
    id serial primary key,

    sub_industry_id integer not null, -- references sub_industry
    com_name varchar(100) unique not null,
    head_office varchar(30) not null,
    employees_number int not null,

    created_at timestamp,
    updated_at timestamp
);