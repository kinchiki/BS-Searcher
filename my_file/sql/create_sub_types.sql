create table sub_types (
    sub_id serial primary key,
    main_id int not null, -- references main_types
    sub_type varchar(100) not null,
    created_at timestamp not null default now(),
    updated_at timestamp not null default now()
);