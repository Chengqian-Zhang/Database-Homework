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
sql = "SELECT * FROM students WHERE nickame= %s "

try:
    cursor.execute(sql，('李四'，))
    print('Results:', cursor.fetchall())
except:
    print('Error')
