create table briefing_sessions (
    id serial primary key,

    company_id int not null,
    location varchar(12) not null,
    bs_date date not null,
    start_time time(0) not null,
    finish_time time(0) not null,

    created_at timestamp,
    updated_at timestamp
);