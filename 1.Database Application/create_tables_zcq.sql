-- 1. 创建动态表。动态与用户的创建关系为一对多关系，因而需要指明创建的用户的id
-- (id_of_moment_creating_user)和发布动态的时间（creating_time）

SET @@foreign_key_checks=0;

DROP TABLE IF EXISTS moment_tb;

CREATE TABLE moment_tb
(
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    content VARCHAR(255) NOT NULL,
    range_of_share VARCHAR(20) NULL DEFAULT '所有人可见',
    id_of_moment_creating_user BIGINT NOT NULL,
    creating_time TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    CHECK(range_of_share IN ('所有人可见', '粉丝可见', '自己可见')),
    CONSTRAINT moment_fk_create_list FOREIGN KEY(id_of_moment_creating_user) REFERENCES user_tb(id)
);

SET @@foreign_key_checks=1;

-- 2. 创建评论表。comment_id是分辨符，belong_moment_id是强实体的主码。
-- “发送评论”是一对多联系，comment_user_id是对应的外码

SET @@foreign_key_checks=0;

DROP TABLE IF EXISTS comment_tb;

CREATE TABLE comment_tb
(
    comment_id BIGINT NOT NULL AUTO_INCREMENT,
    comment_time TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    comment_content VARCHAR(255) NOT NULL,
    comment_belong_moment_id BIGINT NOT NULL,
    comment_user_id BIGINT NOT NULL,
    PRIMARY KEY(comment_id, comment_belong_moment_id),
    CONSTRAINT comment_belong_fk_moment_id FOREIGN KEY(comment_belong_moment_id) REFERENCES moment_tb(id)
    CONSTRAINT comment_bk_user_id FOREIGN KEY(comment_user_id) REFERENCES user_tb(id)
);

SET @@foreign_key_checks=1;

-- 3. 创建点赞表。liked_id是分辨符，liked_belong_moment_id是强实体的主码。
-- “发送点赞”是一对多联系，liked_user_id是对应的外码

SET @@foreign_key_checks=0;

DROP TABLE IF EXISTS liked_tb;

CREATE TABLE liked_tb
(
    liked_id BIGINT NOT NULL AUTO_INCREMENT,
    liked_belong_moment_id BIGINT NOT NULL,
    liked_user_id BIGINT NOT NULL,
    PRIMARY KEY(liked_id, liked_belong_moment_id),
    CONSTRAINT liked_belong_fk_moment_id FOREIGN KEY(liked_belong_moment_id) REFERENCES moment_tb(id)
    CONSTRAINT liked_bk_user_id FOREIGN KEY(liked_user_id) REFERENCES user_tb(id)
);

SET @@foreign_key_checks=1;

-- 4. 创建转发表。trans_id是分辨符，trans_belong_moment_id是强实体的主码。
-- “进行转发”是一对多联系，trans_user_id是对应的外码

SET @@foreign_key_checks=0;

DROP TABLE IF EXISTS trans_tb;

CREATE TABLE trans_tb
(
    trans_id BIGINT NOT NULL AUTO_INCREMENT,
    trans_time TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    trans_content VARCHAR(255) NOT NULL,
    trans_belong_moment_id BIGINT NOT NULL,
    trans_user_id BIGINT NOT NULL,
    PRIMARY KEY(trans_id, trans_belong_moment_id),
    CONSTRAINT trans_belong_fk_moment_id FOREIGN KEY(trans_belong_moment_id) REFERENCES moment_tb(id)
    CONSTRAINT trans_bk_user_id FOREIGN KEY(trans_user_id) REFERENCES user_tb(id)
);

SET @@foreign_key_checks=1;