Two Tables Design Recipe Template

Copy this recipe template to design and create two related database tables from a specification.
1. Extract nouns from the user stories or specification

# EXAMPLE USER STORY:
# (analyse only the relevant part - here the final line).

As a blogger
So I can write interesting stuff
I want to write posts having a title.

As a blogger
So I can write interesting stuff
I want to write posts having a content.

As a blogger
So I can let people comment on interesting stuff
I want to allow comments on my posts.

As a blogger
So I can let people comment on interesting stuff
I want the comments to have a content.

As a blogger
So I can let people comment on interesting stuff
I want the author to include their name in comments.

Nouns:

posts, post_title, post_content, comment_title, comment_content, comment_author

2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.
Record 	Properties
post 	post_title, post_content
comment comment_title, comment_content, comment_author

    Name of the first table (always plural): posts

    Column names: post_title, post_content

    Name of the second table (always plural): comments

    Column names: comment_title, comment_content, comment_author

3. Decide the column types.

Here's a full documentation of PostgreSQL data types.

Most of the time, you'll need either text, int, bigint, numeric, or boolean. If you're in doubt, do some research or ask your peers.

Remember to always have the primary key id as a first column. Its type will always be SERIAL.

# EXAMPLE:

Table: posts
id: SERIAL
post_title: TEXT
post_content: TEXT

Table: comments
id: SERIAL
comment_title: TEXT
comment_content: TEXT
comment_author: TEXT
# foreign key will be here (post_id)

4. Decide on The Tables Relationship

Most of the time, you'll be using a one-to-many relationship, and will need a foreign key on one of the two tables.

To decide on which one, answer these two questions:

    Can one post have many comments? (Yes)
    Can one comment have many posts? (No)

You'll then be able to say that:

    A post has many comments
    And on the other side, a comment belongs to a post
    In that case, the foreign key is in the table comments

Replace the relevant bits in this example with your own:

# EXAMPLE

1. Can one artist have many albums? YES
2. Can one album have many artists? NO

-> Therefore,
-> An artist HAS MANY albums
-> An album BELONGS TO an artist

-> Therefore, the foreign key is on the albums table.

If you can answer YES to the two questions, you'll probably have to implement a Many-to-Many relationship, which is more complex and needs a third table (called a join table).
4. Write the SQL.

-- EXAMPLE
-- file: posts_table.sql

-- Replace the table name, columm names and types.

-- Create the table without the foreign key first.
CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  post_title TEXT,
  post_content TEXT
);

-- Then the table with the foreign key.
CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  comment_title TEXT,
  comment_content TEXT,
  comment_author TEXT,
-- The foreign key name is always post_id
  post_id int,
  constraint fk_post foreign key(post_id)
    references posts(id)
    on delete cascade
);

5. Create the tables.

psql -h 127.0.0.1 blog < posts_table.sql
psql -h 127.0.0.1 blog < comments_table.sql