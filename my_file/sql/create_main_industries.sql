create table main_industries (
    id serial primary key,

    main_t varchar(20) not null unique,

    created_at timestamp not null default now(),
    updated_at timestamp not null default now()
);