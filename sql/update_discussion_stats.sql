UPDATE [PREFIX]discussions discussions,
  (
    SELECT
      a.discussion_id as discussion_id,
      a.comment_count as comment_count,
      a.participant_count as participant_count,
      b.post_id as first_post_id,
      b.user_id as first_user_id,
      c.post_id as last_post_id,
      c.post_number as last_post_number,
      c.last_posted_at as last_posted_at,
      c.user_id as last_user_id
    FROM (
        SELECT
          d.id as discussion_id,
          count(DISTINCT p.id) as comment_count,
          count(DISTINCT u.id) as participant_count
        FROM [PREFIX]discussions d
        LEFT JOIN [PREFIX]posts p ON p.discussion_id = d.id
        LEFT JOIN [PREFIX]users u on p.user_id = u.id
        GROUP BY d.id
      ) as a
    LEFT JOIN (
        SELECT
          d.id as discussion_id,
          p.id as post_id,
          p.user_id as user_id
        FROM [PREFIX]discussions d
        LEFT JOIN [PREFIX]posts p ON p.discussion_id = d.id
        WHERE p.created_at IN (
          SELECT MAX(p2.created_at)
          FROM [PREFIX]posts p2
          WHERE p2.discussion_id = d.id AND p.is_private = FALSE
        )
        GROUP BY d.id, p.id
      ) as b ON a.discussion_id = b.discussion_id
    LEFT JOIN (
      SELECT
        d.id as discussion_id,
        p.id as post_id,
        p.number as post_number,
        p.created_at as last_posted_at,
        p.user_id as user_id
      FROM [PREFIX]discussions d
      LEFT JOIN [PREFIX]posts p ON p.discussion_id = d.id
      WHERE p.created_at IN (
        SELECT MAX(p2.created_at)
        FROM [PREFIX]posts p2
        WHERE p2.discussion_id = d.id AND p.is_private = FALSE
      )
      GROUP BY d.id, p.id
    ) as c on a.discussion_id = c.discussion_id
    GROUP BY a.discussion_id
  )AS source
SET
  discussions.comment_count = source.comment_count,
  discussions.participant_count = source.participant_count,
  discussions.first_post_id = source.first_post_id,
  discussions.user_id = source.first_user_id,
  discussions.last_post_id = source.last_post_id,
  discussions.last_post_number = source.last_post_number,
  discussions.last_posted_user_id = source.last_user_id,
  discussions.last_posted_at = source.last_posted_at,
  discussions.post_number_index = source.last_post_number + 1
WHERE
  discussions.id = source.discussion_id;