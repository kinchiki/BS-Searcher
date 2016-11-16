create table sites (
    id serial primary key,

    site_name  varchar(30) not null unique,

    created_at timestamp,
    updated_at timestamp
);