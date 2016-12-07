create table briefing_sessions (
    bs_id serial primary key,
    com_id int not null, -- references companies
    bs_date date not null,
    location varchar(12) not null,
    start_time time not null,
    finish_time time not null,
    created_at timestamp not null default now(),
    updated_at timestamp not null default now()
);