-- 1. 插入用户表数据。

INSERT INTO user_tb (
    level_of_membership, 
    user_phone, 
    nickname
) VALUES (
    1, '18712345678', '张三'
);

INSERT INTO user_tb (
    level_of_membership, 
    qq, 
    nickname
) VALUES (
    4, 976344301, '李四'
);

INSERT INTO user_tb (
    level_of_membership, 
    mail, 
    nickname
) VALUES (
    4, 'testing@163.com', '王五'
);

-- 2. 创建私信表。

INSERT INTO private_message_tb (
    content,
    id_of_the_msg_accepted_user,
    id_of_the_msg_sent_user
) VALUES (
    'hello!',
    2,
    1
);

INSERT INTO private_message_tb (
    content,
    id_of_the_msg_accepted_user,
    id_of_the_msg_sent_user
) VALUES (
    'hi!',
    1,
    2
);

INSERT INTO private_message_tb (
    content,
    id_of_the_msg_accepted_user,
    id_of_the_msg_sent_user
) VALUES (
    'how do you do',
    3,
    1
);

-- 3. 创建音乐表。

INSERT INTO music_tb (id) VALUES (1);
INSERT INTO music_tb (id) VALUES (2);
INSERT INTO music_tb (id) VALUES (3);
INSERT INTO music_tb (id) VALUES (4);

-- 4. 创建歌曲表。

INSERT INTO song_tb (
    song_music_id,
    name
) VALUES (
    1,
    'world.execute(me);'
);

INSERT INTO song_tb (
    song_music_id,
    name
) VALUES (
    2,
    'Creeper?'
);

INSERT INTO song_tb (
    song_music_id,
    name
) VALUES (
    3,
    '清华大学校歌'
);

-- 5. 创建MV表。

INSERT INTO mv_tb (
    mv_music_id,
    video_title
) VALUES (
    4,
    'heal the world'
);

-- 6. 创建歌单表。

INSERT INTO song_list_tb (
    title,
    id_of_the_list_creating_user
) VALUES (
    '自建歌单1',
    1
);

INSERT INTO song_list_tb (
    title,
    id_of_the_list_creating_user
) VALUES (
    '自建歌单2',
    1
);

INSERT INTO song_list_tb (
    title,
    id_of_the_list_creating_user
) VALUES (
    '自建歌单1',
    3
);

-- 7. 创建收藏表。

INSERT INTO collect_tb (
    collect_user_id,
    collect_song_list_id
) VALUES(
    1,
    1
);

INSERT INTO collect_tb (
    collect_user_id,
    collect_song_list_id
) VALUES(
    2,
    1
);

INSERT INTO collect_tb (
    collect_user_id,
    collect_song_list_id
) VALUES(
    2,
    2
);

INSERT INTO collect_tb (
    collect_user_id,
    collect_song_list_id
) VALUES(
    3,
    3
);

-- 8. 创建标识歌单属于关系的表。

INSERT INTO song_belongs_to_song_list_tb (
    belong_music_id,
    belong_song_list_id
) VALUES (
    1,
    1
);

INSERT INTO song_belongs_to_song_list_tb (
    belong_music_id,
    belong_song_list_id
) VALUES  (
    2,
    1
);

INSERT INTO song_belongs_to_song_list_tb (
    belong_music_id,
    belong_song_list_id
) VALUES  (
    2,
    2
);

INSERT INTO song_belongs_to_song_list_tb (
    belong_music_id,
    belong_song_list_id
) VALUES  (
    3,
    2
);

INSERT INTO song_belongs_to_song_list_tb (
    belong_music_id,
    belong_song_list_id
) VALUES  (
    1,
    3
);

INSERT INTO song_belongs_to_song_list_tb (
    belong_music_id,
    belong_song_list_id
) VALUES  (
    2,
    3
);

INSERT INTO song_belongs_to_song_list_tb (
    belong_music_id,
    belong_song_list_id
) VALUES  (
    3,
    3
);

-- 9. 创建动态表。

INSERT INTO moment_tb (
    content, 
    range_of_share, 
    id_of_the_moment_creating_user,
) VALUES (
    '今天去家园食堂吃了鸡腿饭', '粉丝可见', 1
);

INSERT INTO moment_tb (
    content, 
    range_of_share, 
    id_of_the_moment_creating_user,
) VALUES (
    '2023考研冲冲冲', '自己可见', 1
);

INSERT INTO moment_tb (
    content, 
    id_of_the_moment_creating_user,
) VALUES (
    '许嵩又出新专辑', 3
);

-- 10. 创建评论表。

INSERT INTO comment_tb (
    content,
    belong_moment_id,
    id_of_the_comment_user,
) VALUES (
    '家园的鸡排饭也很不错',
    1,
    1
);

INSERT INTO comment_tb (
    content,
    belong_moment_id,
    id_of_the_comment_user,
) VALUES (
    '考研加油',
    2,
    2
);

INSERT INTO comment_tb (
    content,
    belong_moment_id,
    id_of_the_comment_user,
) VALUES (
    '许嵩粉丝报道',
    3,
    3
);

-- 11. 创建点赞表。

INSERT INTO liked_tb (
    belong_moment_id,
    id_of_the_liked_user,
) VALUES (
    1,
    2
);

INSERT INTO liked_tb (
    belong_moment_id,
    id_of_the_liked_user,
) VALUES (
    2,
    3
);

INSERT INTO liked_tb (
    belong_moment_id,
    id_of_the_liked_user,
) VALUES (
    3,
    1
);

INSERT INTO liked_tb (
    belong_moment_id,
    id_of_the_liked_user,
) VALUES (
    2,
    2
);

-- 12. 创建转发表。

INSERT INTO trans_tb (
    content,
    belong_moment_id,
    id_of_the_trans_user,
) VALUES (
    '我们也去家园吃饭吧',
    1,
    2
);

INSERT INTO trans_tb (
    content,
    belong_moment_id,
    id_of_the_trans_user,
) VALUES (
    '看看当代大学生内卷的现状吧',
    2,
    3
);

INSERT INTO trans_tb (
    content,
    belong_moment_id,
    id_of_the_trans_user,
) VALUES (
    '姐妹们我买好票了',
    3,
    1
);