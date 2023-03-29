/* 生成样例数据 */
/* 用户 */
INSERT INTO user_tb(user_id,user_nickname,user_level,user_login) VALUES
('1','花开富贵','3','phone');
INSERT INTO user_tb(user_id,user_nickname,user_level,user_login) VALUES
('2','平安是福','4','wechat');
INSERT INTO user_tb(user_id,user_nickname,user_level,user_login) VALUES
('3','PKUer','3','qq');
INSERT INTO user_tb(user_id,user_nickname,user_level,user_login) VALUES
('4','小黑子','6','wechat');

/* 音乐 */
INSERT INTO music_tb(music_id,music_name,belong_album_id)VALUES()
INSERT INTO music_tb(music_id,music_name,belong_album_id)VALUES('1','燕园情','北大')
INSERT INTO music_tb(music_id,music_name,belong_album_id)VALUES('2','只因你太美')
/* 歌手 */
INSERT INTO singer_tb(siner_id,singer_name,singer_district,singer_style)VALUES('4','蔡徐坤','北京','流行')
INSERT INTO singer_tb(siner_id,singer_name,singer_district,singer_style)VALUES('3','北大学子','北京','经典')

/*专辑*/
INSERT INTO album_tb(album_id,album_name)VALUES()

/*关注*/
INSERT INTO follow_tb(subscriber_id,publisher_id,follow_time)VALUES()

/*播放*/
INSERT INTO play_tb(player_id,played_music,play_time,play_state,play_order)VALUES()

/*评论*/
INSERT INTO comment_tb(commentator_id,commented_music,comment_content,comment_time)VALUES()

/*喜欢*/
INSERT INTO like_tb(liker_id,liked_music)VALUES()

/*制作*/
INSERT INTO produce_tb(producer_id,produced_music)VALUES('4','2')
INSERT INTO produce_tb(producer_id,produced_music)VALUES('3','1')

/*发布专辑*/

INSERT INTO release_tb(releaser_id,released_album,release_time)VALUES()
INSERT INTO release_tb(releaser_id,released_album,release_time)VALUES('3','北大','2014-05-04 10:00:00')




