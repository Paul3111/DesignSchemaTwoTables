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