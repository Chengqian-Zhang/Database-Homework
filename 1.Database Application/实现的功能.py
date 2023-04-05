import pymysql

db = pymysql.connect(host='162.105.146.37', user='stu2000013058', passwd='stu2000013058', port=43306, db = 'stu2000013058')
cursor = db.cursor()

# 1. 一个用户给另一个用户发送信息(更新发送表和收到信息的表)
user_id_1 = 1
user_id_2 = 2
message = 'Creeper!'
sql = (
    "INSERT INTO private_message_tb "
    "(content, id_of_the_msg_accepted_user, "
    "id_of_the_msg_sent_user) "
    "VALUES "
    "(%s, %s, %s)"
)
try:
    cursor.execute(sql, (message, user_id_1, user_id_2))
    print("1", cursor.fetchall())
    db.commit()
except:
    db.rollback()

# 收信人查看更新后的信息表
sql = (
    "SELECT * FROM private_message_tb "
    "WHERE id_of_the_msg_accepted_user = %s "
)
try:
    cursor.execute(sql, (user_id_1, ))
    print("2", cursor.fetchall())
    db.commit()
except:
    db.rollback()

# 发信人查看更新后的信息表
sql = (
    "SELECT * FROM private_message_tb "
    "WHERE id_of_the_msg_sent_user = %s "
)
try:
    cursor.execute(sql, (user_id_2, ))
    print("3", cursor.fetchall())
    db.commit()
except:
    db.rollback()

# 2. 用户创建歌单，并把对应的歌曲放进歌单
# 用户创建歌单
user_id = 3
title = '想考清华？听完这张歌单再去学习！'
sql = (
    "INSERT INTO song_list_tb "
    "(title, id_of_the_list_creating_user) "
    "VALUES (%s, %s)"
)
try:
    cursor.execute(sql, (title, user_id))
    print("4", cursor.fetchall())
    db.commit()
except:
    db.rollback()

# 用户插入歌曲
song_list_id = 3
music_ids = [2, 3]
sql = (
    "INSERT INTO song_belongs_to_song_list_tb "
    "(belong_music_id, belong_song_list_id) "
    "VALUES (%s, %s)"
)
for music_id in music_ids:
    try:
        cursor.execute(sql, (music_id, song_list_id))
        print("5", cursor.fetchall())
        db.commit()
    except:
        db.rollback()
        break

# 查看新建完成的歌单
song_list_id = 3
sql = (
    "SELECT song_tb.name FROM "
    "song_belongs_to_song_list_tb AS list "
    "JOIN song_tb ON list.belong_music_id = "
    "song_tb.song_music_id AND list.belong_song_list_id = %s"
)
try:
    cursor.execute(sql, (song_list_id, ))
    print("6", cursor.fetchall())
    db.commit()
except:
    db.rollback()

# 3. 按名字降序播放歌单里的歌曲
song_list_id = 3
sql = (
    "SELECT song_tb.name FROM "
    "song_belongs_to_song_list_tb AS list "
    "JOIN song_tb ON list.belong_music_id = "
    "song_tb.song_music_id AND list.belong_song_list_id = %s "
    "ORDER BY song_tb.name DESC"
)
try:
    cursor.execute(sql, (song_list_id, ))
    print("7", cursor.fetchall())
    db.commit()
except:
    db.rollback()


# 4. 按昵称查找用户
sql = "SELECT * FROM user_tb WHERE nickname LIKE %s"

try:
    cursor.execute(sql, ("李四", ))
    print('Results:', cursor.fetchall())
except:
    print('Error')

    
#mql 1.歌手注册 2.发布专辑音乐 3.用户播放评论音乐 关注歌手 4.查询查看过某专辑的所有用户
#功能实现中为了精简程序，在考虑发布音乐专辑时注释掉了INSERT对应音乐和专辑实体的语句，默认建库的时候已经创建相关实体，仅考虑查询后对多对多联系表INSERT相关联系

# -- 1.歌手注册
login='user_phone'
level_of_membership=5
login_key='15530616876'
nickname='小北'
sql=(
    "INSERT INTO user_tb"
    "(level_of_membership, %s, nickname)"
    "VALUE (%d,%s,%s)"
)
try:
    cursor.execute(sql,(login,level_of_membership,login_key,nickname))
    print("user_registered", cursor.fetchall())
    db.commit()
except:
    db.rollback()



sql = "SELECT MAX(id) FROM user_tb"
try:
    cursor.execute(sql)
    now_id = cursor.fetchone()
    db.commit()
except:
    db.rollback()

singer_name='北大学子'
singer_district='北京'
singer_style='经典'
sql=(
    "INSERT INTO singer_tb"
    "(singer_id,singer_name,singer_district,singer_style)"
    "VALUE (%d,%s,%s,%s)"
)
try:
    cursor.execute(sql,(now_id,singer_name,singer_district,singer_style))
    print("singer_registered", cursor.fetchall())
    db.commit()
except:
    db.rollback()

# -- 2.歌手发布专辑
album_id=1
album_name='百大金曲'
belong_album_id=1
producer_id=4

#album1
#默认建库已经创建专辑
# sql=(
#     "INSERT INTO album_tb"
#     "(album_id,album_name)"
#     "VALUES(%d,%s)"
# )
# try:
#     cursor.execute(sql,(album_id,album_name))
#     print("album_insert", cursor.fetchall())
#     db.commit()
# except:
#     db.rollback()

#发布专辑
release_time='2023-04-01'
sql=(
    "INSERT INTO release_tb"
    "(releaser_id,released_album,release_time) "
    "VALUES (%d,%d,%s)"
)
try:
    cursor.execute(sql,(producer_id,album_id,release_time))
    print("album_release", cursor.fetchall())
    db.commit()
except:
    db.rollback()
#----------添加音乐3music3
music_id=3
#默认建库已经创建歌曲
# music_name='清华大学校歌'
# sql=(
#     "INSERT INTO music_tb"
#     "(id,music_name,belong_album_id) "
#     "VALUES (%d,%s,%d)"
# )
# try:
#     cursor.execute(sql,(music_id,music_name,belong_album_id))
#     print("music_insert", cursor.fetchall())
#     db.commit()
# except:
#     db.rollback()
sql=(
    "INSERT INTO produce_tb"
    "(producer_id,produced_music) "
    "VALUES (%d,%d)"
)
try:
    cursor.execute(sql,(producer_id,music_id))
    print("produce_insert", cursor.fetchall())
    db.commit()
except:
    db.rollback()

#----------添加音乐5 music5
#默认建库已经创建歌曲
# music_id=5
# music_name='只因你太美'
# sql=(
#     "INSERT INTO music_tb"
#     "(id,music_name,belong_album_id) "
#     "VALUES (%d,%s,%d)"
# )
# try:
#     cursor.execute(sql,(music_id,music_name,belong_album_id))
#     print("music_insert", cursor.fetchall())
#     db.commit()
# except:
#     db.rollback()

sql=(
    "INSERT INTO produce_tb"
    "(producer_id,produced_music) "
    "VALUES (%d,%d)"
)
try:
    cursor.execute(sql,(producer_id,music_id))
    print("produce_insert", cursor.fetchall())
    db.commit()
except:
    db.rollback()

    


# --3.用户播放并评论音乐，可选择关注歌手


#----------播放音乐
player_id=1
played_music=5
play_state='Start'
play_order='Order'
sql=(
    "INSERT INTO play_tb"
    "(player_id,played_music,play_state,play_order) "
    "VALUES (%d,%d,%s,%s)"
)
try:
    cursor.execute(sql,(player_id,played_music,play_state,play_order))
    print("music_play", cursor.fetchall())
    db.commit()
except:
    db.rollback()

#----------评论音乐
comment_content='立燕解清!'
sql=(
    "INSERT INTO comment_music_tb"
    "(commentator_id,commented_music,comment_content) "
    "VALUES (%d,%d,%s)"
)
try:
    cursor.execute(sql,(player_id,played_music,comment_content))
    print("music_comment", cursor.fetchall())
    db.commit()
except:
    db.rollback()

#----------关注歌手
follow_time='2023-04-05'

#查找创作本音乐的所有歌手
sql =(
    "select producer_id"
    "FROM produce_tb "   
    "where produced_music=played_music")
try:
    cursor.execute(sql)
    producer_ids = cursor.fetchall()
    db.commit()
except:
    db.rollback()

#添加当前用户与所有歌手的关注关系
for producer_id in producer_ids:
    sql=(
        "INSERT INTO follow_tb"
        "(subscriber_id,publisher_id,follow_time)"
        "VALUES(%d,%d,%s)"
    )
    try:
        cursor.execute(sql,(player_id,producer_id,follow_time))
        print("singer_follow", cursor.fetchall())
        db.commit()
    except:
        db.rollback()


# --4.查询查看过某个专辑音乐的所有用户
album_id=1

sql=(
    "select player_id"
    "from play_tb as P"
    "where exists("
    "select * from music_tb"
    "where id=P.played_music"
    "and belong_album_id=album_id)"
)
try:
    cursor.execute(sql)
    print("album_player",cursor.fetchall())
    db.commit()
except:
    db.rollback()
