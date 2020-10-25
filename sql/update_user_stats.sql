UPDATE [PREFIX]users users,
  (
    SELECT
      a.user_id as user_id,
      a.post_count as post_count,
      b.discussion_count as discussion_count
    FROM (
      SELECT
        u.id as user_id,
        count(DISTINCT p.id) as post_count
      FROM [PREFIX]users u
      LEFT JOIN [PREFIX]posts p ON p.user_id = u.id
      WHERE
        p.is_private = FALSE AND p.type = 'comment'
      GROUP BY u.id
    ) as a
    LEFT JOIN (
      SELECT
        u.id as user_id,
        count(DISTINCT d.id) as discussion_count
      FROM [PREFIX]users u
        LEFT JOIN [PREFIX]discussions d ON d.user_id = u.id
      WHERE
        d.is_private = FALSE
      GROUP BY u.id
    ) as b ON b.user_id = a.user_id
    GROUP BY a.user_id
  ) AS source
SET
  users.comment_count = source.post_count,
  users.discussion_count = source.discussion_count
WHERE
  users.id = source.user_id;
