-- 1. 创建动态表。

INSERT INTO moment_tb (
    content, 
    range_of_share, 
    id_of_moment_creating_user,
) VALUES (
    '今天去家园食堂吃了鸡腿饭', '粉丝可见', 1
);

INSERT INTO moment_tb (
    content, 
    range_of_share, 
    id_of_moment_creating_user,
) VALUES (
    '2023考研冲冲冲', '自己可见', 1
);

INSERT INTO moment_tb (
    content, 
    id_of_moment_creating_user,
) VALUES (
    '许嵩又出新专辑', 3
);

-- 2. 创建评论表。

INSERT INTO comment_tb (
    comment_content,
    comment_belong_moment_id,
    comment_user_id,
) VALUES (
    '家园的鸡排饭也很不错',
    1,
    1
);

INSERT INTO comment_tb (
    comment_content,
    comment_belong_moment_id,
    comment_user_id,
) VALUES (
    '考研加油',
    2,
    2
);

INSERT INTO comment_tb (
    comment_content,
    comment_belong_moment_id,
    comment_user_id,
) VALUES (
    '许嵩粉丝报道',
    3,
    3
);

-- 3. 创建点赞表。

INSERT INTO liked_tb (
    liked_belong_moment_id,
    liked_user_id,
) VALUES (
    1,
    2
);

INSERT INTO liked_tb (
    liked_belong_moment_id,
    liked_user_id,
) VALUES (
    2,
    3
);

INSERT INTO liked_tb (
    liked_belong_moment_id,
    liked_user_id,
) VALUES (
    3,
    1
);

INSERT INTO liked_tb (
    liked_belong_moment_id,
    liked_user_id,
) VALUES (
    2,
    2
);

-- 4. 创建转发表。

INSERT INTO trans_tb (
    trans_content,
    trans_belong_moment_id,
    trans_user_id,
) VALUES (
    '我们也去家园吃饭吧',
    1,
    2
);

INSERT INTO song_tb (
    song_music_id,
    name
) VALUES (
    '看看当代大学生内卷的现状吧',
    2,
    3
);

INSERT INTO song_tb (
    song_music_id,
    name
) VALUES (
    '姐妹们我买好票了',
    3,
    1
);