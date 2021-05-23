create table bet_type
(
    id       int auto_increment
        primary key,
    bet_name varchar(250) not null
);

create table horse
(
    id          int auto_increment
        primary key,
    horse_name  varchar(100)                                             not null,
    description varchar(500)                                             null,
    avatar      varchar(255) default '1tHwqgUbl2-tlgZgx9lx5UEaxVr7mOjA3' null
);

create table race_status
(
    id     int auto_increment
        primary key,
    status varchar(20) not null,
    constraint race_status_status_uindex
        unique (status)
);

create table race
(
    id          int auto_increment
        primary key,
    start_date  datetime      not null,
    race_name   varchar(250)  not null,
    description blob          null,
    race_status int default 1 not null,
    constraint race_race_status_id_fk
        foreign key (race_status) references race_status (id)
);

create table race_runner
(
    id           int auto_increment
        primary key,
    runner_id    int not null,
    runner_place int null,
    race_id      int null,
    constraint h_history_r_horse_id_fk
        foreign key (runner_id) references horse (id),
    constraint h_history_r_race_id_fk
        foreign key (race_id) references race (id)
);

create index h_history_r_result_id_fk
    on race_runner (runner_place);

create table user_role
(
    id        int auto_increment
        primary key,
    role_name varchar(20) not null,
    constraint u_role_role_name_uindex
        unique (role_name)
);

create table user_status
(
    id          int auto_increment
        primary key,
    user_status varchar(20) null
);

create table user_table
(
    id        int auto_increment
        primary key,
    login     varchar(50)                                                not null,
    pass      varchar(100)                                               not null,
    username  varchar(100)                                               null,
    role_id   int            default 2                                   not null,
    money     decimal(15, 2) default 100.00                              null,
    avatar    varchar(255)   default '1l4Ptmxh7TNGYfhPItd7vEVS3dqq-qBPF' null,
    status_id int            default 1                                   not null,
    constraint client_user_u_login_uindex
        unique (login),
    constraint client_user_u_role_id_fk
        foreign key (role_id) references user_role (id),
    constraint user_table_user_status_id_fk
        foreign key (status_id) references user_status (id)
);

create table bet
(
    id       int auto_increment
        primary key,
    user_id  int            not null,
    price    decimal(15, 2) not null,
    bet_type int            null,
    constraint r_bet_r_result_id_fk1
        foreign key (bet_type) references bet_type (id),
    constraint r_bet_r_user_id_fk
        foreign key (user_id) references user_table (id)
);

create table bet_pick
(
    id         int auto_increment
        primary key,
    bet_id     int null,
    pick_place int null,
    pick_id    int not null,
    constraint bet_pick_race_runner_id_fk
        foreign key (pick_id) references race_runner (id),
    constraint bet_pick_user_bet_id_fk
        foreign key (bet_id) references bet (id)
);
