create table main_types (
    main_id serial primary key,
    main_type varchar(20) not null,
    created_at timestamp not null default now(),
    updated_at timestamp not null default now()
);