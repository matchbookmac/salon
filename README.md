## HAIR SALON

<a href="APP LINK IF APPLICABLE" target="#"><APP LINK NAME></a>

By Ian MacDonald (<a href="https://github.com/matchbookmac" target="#">GitHub</a>)

@ Epicodus Programming School, Portland, OR

GNU General Public License, version 3 (see below). Copyright (c) 2015 Ian C. MacDonald.

### Description

**Hair Salon**

A web app designed to enable a salon owner to manage clients and stylists, and assign clients to stylists.

### Author(s)

Ian MacDonald

### Setup

This app was written in `ruby '2.0.0'`.

Clone this repo with
```console
> git clone https://github.com/matchbookmac/salon.git
```
Install database
```console
> pg_restore -d hair_salon hair_salon_test.dump
```

Install and run:
```console
> bundle install
> ruby app.rb
```

### Database Schema

If unable to restore database from dump file, the schema for creating the database is below.

Be sure Postgres is installed.

Start the postgres server, open postgres, and create the databases needed.

```console
 > psql
=# CREATE DATABASE hair_salon;
=# \c hair_salon;
=# CREATE TABLE clients (id serial PRIMARY KEY, first_name varchar, last_name varchar, stylist_id int);
=# CREATE TABLE stylists (id serial PRIMARY KEY, first_name varchar, last_name varchar);
=# CREATE DATABASE hair_salon_test WITH TEMPLATE hair_salon;
```

#### Schema

List of relations
|   Name   | Type  |
|----------|-------|
| clients  | table |
| stylists | table |

clients
id  | first_name | last_name | stylist_id
----|------------|-----------|------------
int | varchar    | varchar   | int

stylists
id  | first_name | last_name
----|------------|-----------
int | varchar    | varchar

### License
Copyright  (C)  2015  Ian C. MacDonald

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
