create table urls (
    url_id serial primary key,
    bs_id int not null, -- references briefing_sessions
    site_id int not null, -- references sites
    url varchar(255) not null unique,
    created_at timestamp not null default now(),
    updated_at timestamp not null default now()
);