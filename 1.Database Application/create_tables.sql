-- 1. 创建用户表，并检查qq，邮箱，电话之一是否有填写，并检查填写是否合规。

SET @@foreign_key_checks=0;

DROP TABLE IF EXISTS user_tb;

CREATE TABLE user_tb
(
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    level_of_membership TINYINT NULL DEFAULT 1,
    user_phone VARCHAR(20) NULL,
    qq BIGINT NULL,
    mail VARCHAR(40) NULL,
    nickname VARCHAR(40) NOT NULL,
    CHECK(LENGTH(user_phone)=11 OR user_phone IS NULL),
    CHECK(
        mail LIKE '%@%' 
        OR mail IS NULL
    ),
    CHECK(
        user_phone IS NOT NULL OR
        mail IS NOT NULL OR
        qq IS NOT NULL
    )
);

SET @@foreign_key_checks=1;

-- 2. 创建私信表，私信和用户间的“收到”和“发送”关系是一对多关系，需要在表中填写对应的用户id
SET @@foreign_key_checks=0;

DROP TABLE IF EXISTS private_message_tb;

CREATE TABLE private_message_tb
(
	id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    time_of_private_message TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    content VARCHAR(255) NOT NULL,
    id_of_the_msg_accepted_user BIGINT NOT NULL,
    id_of_the_msg_sent_user BIGINT NOT NULL,
    CONSTRAINT private_msg_fk_accept FOREIGN KEY(id_of_the_msg_accepted_user) REFERENCES user_tb(id),
    CONSTRAINT private_msg_fk_send FOREIGN KEY(id_of_the_msg_sent_user) REFERENCES user_tb(id)
);

SET @@foreign_key_checks=1;

-- 3. 创建音乐表，功能尚未完成。

SET @@foreign_key_checks=0;

DROP TABLE IF EXISTS music_tb;

CREATE TABLE music_tb
(
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY
);

SET @@foreign_key_checks=1;

-- 4. 创建歌曲表，歌曲继承自音乐，需要以音乐的id(music_id)为主键。

SET @@foreign_key_checks=0;

DROP TABLE IF EXISTS song_tb;

CREATE TABLE song_tb
(
    song_music_id BIGINT NOT NULL PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    CONSTRAINT song_fk_music_id FOREIGN KEY(song_music_id) REFERENCES music_tb(id)
);

SET @@foreign_key_checks=1;

-- 5. 创建MV表，MV继承自音乐，需要以音乐的id(music_id)为主键。

SET @@foreign_key_checks=0;

DROP TABLE IF EXISTS mv_tb;

CREATE TABLE mv_tb
(
    mv_music_id BIGINT NOT NULL PRIMARY KEY,
    video_title VARCHAR(20) NOT NULL,
    CONSTRAINT mv_fk_music_id FOREIGN KEY(mv_music_id) REFERENCES music_tb(id)
);

SET @@foreign_key_checks=1;

-- 6. 创建歌单表。歌单与用户的创建关系为一对多关系，因而需要指明创建的用户的id
-- (id_of_the_creating_user)和创造的时间(cerating_time)

SET @@foreign_key_checks=0;

DROP TABLE IF EXISTS song_list_tb;

CREATE TABLE song_list_tb
(
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(20) NOT NULL,
    sortord VARCHAR(20) NULL DEFAULT '默认排序',
    id_of_the_list_creating_user BIGINT NOT NULL,
    creating_time TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    CHECK(sortord IN ('默认排序', '歌曲名', '歌手', '专辑')),
    CONSTRAINT list_fk_create_list FOREIGN KEY(id_of_the_list_creating_user) REFERENCES user_tb(id)
);

SET @@foreign_key_checks=1;

-- 7. 创建收藏表。收藏关系是用户和歌单的多对多关系，主键为用户id(user_id)和歌单id(song_list_id)。

SET @@foreign_key_checks=0;

DROP TABLE IF EXISTS collect_tb;

CREATE TABLE collect_tb
(
    collect_user_id BIGINT NOT NULL,
    collect_song_list_id BIGINT NOT NULL,
    PRIMARY KEY(collect_user_id, collect_song_list_id),
    CONSTRAINT collect_fk_user FOREIGN KEY(collect_user_id) REFERENCES user_tb(id),
    CONSTRAINT collect_fk_list FOREIGN KEY(collect_song_list_id) REFERENCES song_list_tb(id)
);

SET @@foreign_key_checks=1;

-- 8. 创建歌曲歌单表标识歌曲和歌单之间的属于关系。这个关系是多对多关系，需要以歌曲id(music_id)和歌单id(song_list_id)为主键

SET @@foreign_key_checks=0;

DROP TABLE IF EXISTS song_belongs_to_song_list_tb;

CREATE TABLE song_belongs_to_song_list_tb
(
    belong_music_id BIGINT NOT NULL,
    belong_song_list_id BIGINT NOT NULL,
    PRIMARY KEY(belong_music_id, belong_song_list_id),
    CONSTRAINT song_fk_music FOREIGN KEY(belong_music_id) REFERENCES song_tb(song_music_id),
    CONSTRAINT song_fk_list FOREIGN KEY(belong_song_list_id) REFERENCES song_list_tb(id)
);

SET @@foreign_key_checks=1;

-- 9. 创建动态表。动态与用户的创建关系为一对多关系，因而需要指明创建的用户的id
-- (id_of_the_moment_creating_user)和发布动态的时间（creating_time）

SET @@foreign_key_checks=0;

DROP TABLE IF EXISTS moment_tb;

CREATE TABLE moment_tb
(
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    content VARCHAR(255) NOT NULL,
    range_of_share VARCHAR(20) NULL DEFAULT '所有人可见',
    id_of_the_moment_creating_user BIGINT NOT NULL,
    creating_time TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    CHECK(range_of_share IN ('所有人可见', '粉丝可见', '自己可见')),
    CONSTRAINT moment_fk_create_list FOREIGN KEY(id_of_the_moment_creating_user) REFERENCES user_tb(id)
);

SET @@foreign_key_checks=1;

-- 10. 创建评论表。id是分辨符，belong_moment_id是强实体的主码。
-- “发送评论”是一对多联系，id_of_the_comment_user是对应的外码

SET @@foreign_key_checks=0;

DROP TABLE IF EXISTS comment_tb;

CREATE TABLE comment_tb
(
    id BIGINT NOT NULL AUTO_INCREMENT,
    time_of_comment TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    content VARCHAR(255) NOT NULL,
    belong_moment_id BIGINT NOT NULL,
    id_of_the_comment_user BIGINT NOT NULL,
    PRIMARY KEY(id, belong_moment_id),
    CONSTRAINT comment_belong_fk_moment_id FOREIGN KEY(belong_moment_id) REFERENCES moment_tb(id),
    CONSTRAINT comment_fk_user_id FOREIGN KEY(id_of_the_comment_user) REFERENCES user_tb(id)
);

SET @@foreign_key_checks=1;

-- 11. 创建点赞表。id是分辨符，belong_moment_id是强实体的主码。
-- “发送点赞”是一对多联系，id_of_the_liked_user是对应的外码

SET @@foreign_key_checks=0;

DROP TABLE IF EXISTS liked_tb;

CREATE TABLE liked_tb
(
    id BIGINT NOT NULL AUTO_INCREMENT,
    belong_moment_id BIGINT NOT NULL,
    id_of_the_liked_user BIGINT NOT NULL,
    PRIMARY KEY(id, belong_moment_id),
    CONSTRAINT liked_belong_fk_moment_id FOREIGN KEY(belong_moment_id) REFERENCES moment_tb(id),
    CONSTRAINT liked_fk_user_id FOREIGN KEY(id_of_the_liked_user) REFERENCES user_tb(id)
);

SET @@foreign_key_checks=1;

-- 12. 创建转发表。id是分辨符，belong_moment_id是强实体的主码。
-- “进行转发”是一对多联系，id_of_the_trans_user是对应的外码

SET @@foreign_key_checks=0;

DROP TABLE IF EXISTS trans_tb;

CREATE TABLE trans_tb
(
    id BIGINT NOT NULL AUTO_INCREMENT,
    time_of_trans TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    content VARCHAR(255) NOT NULL,
    belong_moment_id BIGINT NOT NULL,
    id_of_the_trans_user BIGINT NOT NULL,
    PRIMARY KEY(id, belong_moment_id),
    CONSTRAINT trans_belong_fk_moment_id FOREIGN KEY(belong_moment_id) REFERENCES moment_tb(id),
    CONSTRAINT trans_bk_user_id FOREIGN KEY(id_of_the_trans_user) REFERENCES user_tb(id)
);

SET @@foreign_key_checks=1;
