create table sites (
    site_id serial primary key,
    site_name  varchar(30) not null unique,
    created_at timestamp not null default now(),
    updated_at timestamp not null default now()
);