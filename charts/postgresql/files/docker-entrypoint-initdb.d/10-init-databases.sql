create database drone;
create role drone with password 'drone';
alter role drone with login;
grant all on database drone to drone;

create database gogs;
create role gogs with password 'gogs';
alter role gogs with login;
grant all on database gogs to gogs;
