create table sub_industries (
    id serial primary key,

    main_industry_id int not null, -- references main_types
    sub_t varchar(100) not null unique,

    created_at timestamp not null default now(),
    updated_at timestamp not null default now()
);