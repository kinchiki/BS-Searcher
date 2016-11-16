create table urls (
    id serial primary key,

    briefing_session_id int not null, -- references briefing_sessions
    site_id int not null, -- references sites
    url_val varchar(500) not null unique,

    created_at timestamp not null default now(),
    updated_at timestamp not null default now()
);