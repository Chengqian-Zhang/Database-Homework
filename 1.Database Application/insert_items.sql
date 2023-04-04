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

INSERT INTO user_tb (
    level_of_membership, 
    user_phone, 
    nickname
) VALUES (
    5, '15530616876', '小北'
);

-- 2. 创建歌手表
INSERT INTO singer_tb(singer_id,singer_name,singer_district,singer_style) 
    VALUES (3,'Mili','日本','电子音乐');
INSERT INTO singer_tb(singer_id,singer_name,singer_district,singer_style) 
    VALUES (4,'北大学子','北京','经典');

-- 3. 创建私信表。

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
-- 4. 创建专辑表。
INSERT INTO album_tb(album_id,album_name)VALUES(1,'百大金曲');
INSERT INTO album_tb(album_id,album_name)VALUES(2,'Miracle Milk');

-- 5. 创建音乐表。

INSERT INTO music_tb (id,music_name,belong_album_id) 
    VALUES (1,'world.execute(me);',2);
INSERT INTO music_tb (id,music_name) 
    VALUES (2,'Creeper?');
INSERT INTO music_tb (id,music_name,belong_album_id) 
    VALUES (3,'清华大学校歌',1);
INSERT INTO music_tb (id,music_name)
    VALUES (4,'heal the world');
INSERT INTO music_tb (id,music_name,belong_album_id)
    VALUES (5,'只因你太美',1);



-- 6. 歌手制作音乐
INSERT INTO produce_tb(producer_id,produced_music)VALUES(3,1);
INSERT INTO produce_tb(producer_id,produced_music)VALUES(3,2);
INSERT INTO produce_tb(producer_id,produced_music)VALUES(4,3);
INSERT INTO produce_tb(producer_id,produced_music)VALUES(3,4);
INSERT INTO produce_tb(producer_id,produced_music)VALUES(4,5);

-- 7. 歌手发布专辑
INSERT INTO release_tb(releaser_id,released_album,release_time)
    VALUES(4,1,'2023-04-01');
INSERT INTO release_tb(releaser_id,released_album,release_time)
    VALUES(3,2,'2016-10-12');

-- 8. 创建播放表
INSERT INTO play_tb(player_id,played_music,play_state,play_order)
    VALUES(1,1,'Pause','Order');
INSERT INTO play_tb(player_id,played_music,play_state,play_order)
    VALUES(1,2,'Start','Order');
INSERT INTO play_tb(player_id,played_music,play_state,play_order)
    VALUES(2,1,'Start','Random');
INSERT INTO play_tb(player_id,played_music,play_state,play_order)
    VALUES(2,5,'Pause','Order');
INSERT INTO play_tb(player_id,played_music,play_state,play_order)
    VALUES(3,3,'Pause','Random');
INSERT INTO play_tb(player_id,played_music,play_state,play_order)
    VALUES(3,4,'Start','Order');
INSERT INTO play_tb(player_id,played_music,play_state,play_order)
    VALUES(4,3,'Start','Order');

-- 9. 创建评论表
INSERT INTO comment_music_tb(commentator_id,commented_music,comment_content)
    VALUES(2,1,'这首歌的主题是计算机编程和模拟,通过使用编程术语和比喻来描述关系和情感。歌词中提到了对象创建、初始化和模拟等编程术语,同时也包含了对情感和关系的描绘,表达了在虚拟世界中寻求满足和幸福的渴望。这句话是ChatGPT回答的。');
INSERT INTO comment_music_tb(commentator_id,commented_music,comment_content)
    VALUES(4,3,'还是我大PKU的燕园情好听。');
INSERT INTO comment_music_tb(commentator_id,commented_music,comment_content)
    VALUES(3,5,'巅峰产生虚伪的拥护,黄昏见证虔诚的信徒!');
        

-- 11. 创建歌曲表。

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

INSERT INTO song_tb (
    song_music_id,
    name
) VALUES (
    5,
    '只因你太美'
);
-- 12. 创建MV表。

INSERT INTO mv_tb (
    mv_music_id,
    video_title
) VALUES (
    4,
    'heal the world'
);
-- 13. 创建歌单表。

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

-- 14. 创建收藏表。

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

-- 15. 创建标识歌单属于关系的表。

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

-- 16. 创建动态表。

INSERT INTO moment_tb (
    content, 
    range_of_share, 
    id_of_the_moment_creating_user
) VALUES (
    '今天去家园食堂吃了鸡腿饭', '粉丝可见', 1
);

INSERT INTO moment_tb (
    content, 
    range_of_share, 
    id_of_the_moment_creating_user
) VALUES (
    '2023考研冲冲冲', '自己可见', 1
);

INSERT INTO moment_tb (
    content, 
    id_of_the_moment_creating_user
) VALUES (
    '许嵩又出新专辑', 3
);

-- 17. 创建评论表。

INSERT INTO comment_tb (
    content,
    belong_moment_id,
    id_of_the_comment_user
) VALUES (
    '家园的鸡排饭也很不错',
    1,
    1
);

INSERT INTO comment_tb (
    content,
    belong_moment_id,
    id_of_the_comment_user
) VALUES (
    '考研加油',
    2,
    2
);

INSERT INTO comment_tb (
    content,
    belong_moment_id,
    id_of_the_comment_user
) VALUES (
    '许嵩粉丝报道',
    3,
    3
);

-- 18. 创建点赞表。

INSERT INTO liked_tb (
    belong_moment_id,
    id_of_the_liked_user
) VALUES (
    1,
    2
);

INSERT INTO liked_tb (
    belong_moment_id,
    id_of_the_liked_user
) VALUES (
    2,
    3
);

INSERT INTO liked_tb (
    belong_moment_id,
    id_of_the_liked_user
) VALUES (
    3,
    1
);

INSERT INTO liked_tb (
    belong_moment_id,
    id_of_the_liked_user
) VALUES (
    2,
    2
);

-- 19. 创建转发表。

INSERT INTO trans_tb (
    content,
    belong_moment_id,
    id_of_the_trans_user
) VALUES (
    '我们也去家园吃饭吧',
    1,
    2
);

INSERT INTO trans_tb (
    content,
    belong_moment_id,
    id_of_the_trans_user
) VALUES (
    '看看当代大学生内卷的现状吧',
    2,
    3
);

INSERT INTO trans_tb (
    content,
    belong_moment_id,
    id_of_the_trans_user
) VALUES (
    '姐妹们我买好票了',
    3,
    1
);
