# Fakey - foreign keys support for ActiveRecord migrations


Before resorting to write yet another foreign key plugin I tried
[foreign_key_migrations](http://github.com/harukizaemon/foreign_key_migrations)
(no longer available) and
[foreigner](http://github.com/matthuhiggins/foreigner), but they have annoying
shortcomings. *foreign_key_migrations* assumes every column ending on `_id` to
be a foreign key and tries to infer the table name, which in my case was not
the right one. *foreigner* doesn't let you declare foreign key in
`create_table` block, instead you have to call explicitly
`add_foreign_key(:comments, :posts)` after it. Not quite helpful for tables
containing a lot of foreign keys.

Fakey is fully tested by directly inspecting schema in the database and
supports both MySQL and PostgreSQL.

## Example

  Fakey hooks foreign keys to the standard `belongs_to` and `references` methods in migrations.

    # Standard usage
    create_table :books do |t|
      t.belongs_to :author
    end
    # => CREATE TABLE "books" ("id" serial primary key, "author_id" integer REFERENCES "authors")

    # Table name specified explicitly
    create_table :poems do |t|
      t.belongs_to :author, :references => :poets
    end
    # => CREATE TABLE "poems" ("id" serial primary key, "author_id" integer REFERENCES "poets")

    # Column name specified explicitly (if you don't want _id suffix)
    create_table :books do |t|
      t.belongs_to :author, :column => :author
    end
    # => CREATE TABLE "books" ("id" serial primary key, "author" integer REFERENCES "books")

    # Non-integer primary key (for those with legacy databases) - this only works in PostgreSQL now!
    execute "CREATE TABLE authors( name VARCHAR(255) PRIMARY KEY)"
    create_table :books do |t|
      t.belongs_to :author_name, :column => :author_name, :references => :authors, :type => :string
    end
    # => CREATE TABLE "books" ("id" serial primary key, "author_name" VARCHAR(255) REFERENCES "authors")

    # Non-primary key (for those with legacy databases)
    create_table :authors do |t|
      t.integer :ssid
    end
    execute("ALTER TABLE authors ADD UNIQUE(ssid)") # note that add_index doesn't create constraint!
    create_table :books do |t|
      t.belongs_to :author_ssid, :column => :author_ssid, :references => :authors, :referenced_column => :ssid
    end
    # => CREATE TABLE "books" ("id" serial primary key, "author_ssid" integer REFERENCES "authors"(ssid))


    # Changing table too
    change_table :atuhors do |t|
      t.belongs_to :author
    end

## Compatibility

Rails: 3.2+

PostgreSQL 7.0+

MySQL 5.0+

Copyright (c) 2009-2014 Tutuf Ltd, released under the MIT license. Thanks to Bryan Evans for database introspection query (taken from drysql gem).
