create table companies (
    com_id serial primary key,
    sub_type_id int not null, -- references sub_types
    com_name varchar(100) unique not null,
    head_office varchar(30) not null,
    employees_number int not null,
    created_at timestamp not null default now(),
    updated_at timestamp not null default now()
);