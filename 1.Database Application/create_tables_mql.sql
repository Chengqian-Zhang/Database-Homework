-- # 业务分析：
-- # 播放音乐，
-- # ⽹易云⾳乐⽤户通过⼿机号/qq号/邮箱来登录，
-- # 创建或收藏歌单，播放歌曲或MV，
-- # 在⾳乐下发表评论、喜欢该⾳乐，
-- # 还可以查看歌⼿、专辑等更详细的信息。
-- #%%sql

-- # 实体

-- -- 1. 创建用户表，并检查qq，邮箱，电话之一是否有填写，并检查填写是否合规。
set @@foreign_key_checks=0;
drop table if exists user_tb
-- CREATE TABLE user_tb
-- {
--   user_id BIGINT NOT NULL PRIMARY KEY,
--   user_nickname VARCHAR(100) NOT NULL,
--   user_level INT,
--   user_login ENUM('wechat','qq','phone') NOT NULL,
-- --   check(user_login in (`wechat`,`phone`,`qq`,`email`))
-- }
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
set @@foreign_key_checks=1;

-- # 2.音乐（音乐ID,音乐名称）+属于专辑（一对多
set @@foreign_key_checks=0;
drop table if exists music_tb
CREATE TABLE music_tb
{
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    music_name VARCHAR(50) NOT NULL,
    belong_album_id VARCHAR(50),
    constraint music_fk_album foreign key(belong_album_id) references album_tb(album_id)
}
set @@foreign_key_checks=1;

-- # 歌手（用户ID，姓名，地区、风格）
set @@foreign_key_checks=0;
drop table if exists singer_tb
CREATE TABLE singer_tb
{
    singer_id BIGINT NOT NULL PRIMARY KEY
    singer_name VARCHAR(50) NOT NULL,
    singer_district VARCHAR(50) NOT NULL,
    singer_style VARCHAR(50) NOT NULL,
    constraint singer_fk_user foreign key(siner_id) references user_tb(id)
}
set @@foreign_key_checks=1;

-- # 专辑（专辑ID）
set @@foreign_key_checks=0;
drop table if exists album_tb
CREATE TABLE album_tb
{
    album_id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY
    -- 增加专辑名称
    album_name VARCHAR(50) NOT NULL
    
}
set @@foreign_key_checks=1;

-- # 联系

-- # 关注（关注用户ID，被关注用户ID，关注时间）
set @@foreign_key_checks=0;
drop table if exists follow_tb
CREATE TABLE follow_tb
{
    subscriber_id BIGINT NOT NULL,
    publisher_id BIGINT NOT NULL,
    follow_time DATE,
    primary key(subscriber_id,publisher_id),
    constraint sub_fk_user foreign key(subscriber_id) references user_tb(id)
    constraint pub_fk_user foreign key(publisher_id) references user_tb(id)
}
set @@foreign_key_checks=1;

-- # 播放：一首音乐多个用户？播放状态和顺序，采用多对多实现
set @@foreign_key_checks=0;
drop table if exists play_tb
CREATE TABLE play_tb
{
    player_id BIGINT NOT NULL,
    played_music BIGINT NOT NULL,
    play_time DATE,
    play_state ENUM('Pause','Start') NOT NULL,
    play_order ENUM('Order','Random') NOT NULL,
    -- 是否加入评论时间？
    primary key(player_id,played_music),
    constraint play_fk_user foreign key(player_id) references user_tb(id)
    constraint play_fk_music foreign key(played_music) references music_tb(id)
}
set @@foreign_key_checks=1;
-- # 评论（用户ID，音乐ID，评论内容）//？？要不要加时间
set @@foreign_key_checks=0;
drop table if exists comment_tb
CREATE TABLE comment_tb
{
    commentator_id BIGINT NOT NULL,
    commented_music BIGINT NOT NULL,
    comment_content VARCHAR(500) NOT NULL,
    comment_time DATE,
    -- 加入评论时间？
    primary key(commentator_id,commented_music),
    constraint comment_fk_user foreign key(commentator_id) references user_tb(id)
    constraint comment_fk_music foreign key(commented_music) references music_tb(id)
}
set @@foreign_key_checks=1;

-- # 喜欢（用户ID，音乐ID）
set @@foreign_key_checks=0;
drop table if exists like_tb
CREATE TABLE like_tb
{
    liker_id BIGINT NOT NULL,
    liked_music BIGINT NOT NULL,
    primary key(liker_id,liked_music),
    constraint like_fk_user foreign key(liker_id) references user_tb(id)
    constraint like_fk_music foreign key(liked_music) references music_tb(id)
}
set @@foreign_key_checks=1;

-- # 制作（歌手ID，音乐ID）
set @@foreign_key_checks=0;
drop table if exists produce_tb
CREATE TABLE produce_tb
{
    producer_id BIGINT NOT NULL,
    produced_music BIGINT NOT NULL,
    primary key(producer_id,produced_music),
    constraint produce_fk_user foreign key(producer_id) references singer_tb(singer_id)
    constraint produce_fk_music foreign key(produced_music) references music_tb(id)
}
set @@foreign_key_checks=1;

-- # 发布专辑（歌手ID，专辑ID，发布专辑时间）
set @@foreign_key_checks=0;
drop table if exists release_tb
CREATE TABLE release_tb
{
    releaser_id BIGINT NOT NULL,
    released_album BIGINT NOT NULL,
    release_time DATE,
    primary key(releaser_id,released_album),
    constraint release_fk_user foreign key(releaser_id) references user_tb(id)
    constraint release_fk_album foreign key(released_album) references album_tb(album_id)
}
set @@foreign_key_checks=1;

