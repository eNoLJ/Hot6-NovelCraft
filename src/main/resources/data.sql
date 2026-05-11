-- =====================================================
-- Hot6-NovelCraft 더미 데이터
-- 모든 계정 비밀번호: asdf1234
-- =====================================================

-- 1. users
INSERT INTO users (id, email, password, nickname, phone_no, birthday, role, refresh_token, is_adult_verified, is_deleted, deleted_at, updated_at, created_at) VALUES
                                                                                                                                                                  (1, 'author1@test.com', '$2a$10$j0lHqS.XzKnx0TrsRsosm.oP3rrvBkUe/z643kJr.cUT4MJu5fMLW', '김도윤', '010-1111-0001', '1990-03-15', 'AUTHOR', NULL, FALSE, FALSE, NULL, NULL, '2025-01-01 09:00:00'),
                                                                                                                                                                  (2, 'author2@test.com', '$2a$10$j0lHqS.XzKnx0TrsRsosm.oP3rrvBkUe/z643kJr.cUT4MJu5fMLW', '이서연', '010-1111-0002', '1992-07-22', 'AUTHOR', NULL, FALSE, FALSE, NULL, NULL, '2025-01-01 10:00:00'),
                                                                                                                                                                  (3, 'reader1@test.com', '$2a$10$j0lHqS.XzKnx0TrsRsosm.oP3rrvBkUe/z643kJr.cUT4MJu5fMLW', '박지훈', '010-1111-0003', '1995-11-08', 'READER', NULL, FALSE, FALSE, NULL, NULL, '2025-01-02 09:00:00'),
                                                                                                                                                                  (4, 'reader2@test.com', '$2a$10$j0lHqS.XzKnx0TrsRsosm.oP3rrvBkUe/z643kJr.cUT4MJu5fMLW', '최수아', '010-1111-0004', '1998-04-30', 'READER', NULL, FALSE, FALSE, NULL, NULL, '2025-01-03 09:00:00'),
                                                                                                                                                                  (5, 'mentor@test.com',  '$2a$10$j0lHqS.XzKnx0TrsRsosm.oP3rrvBkUe/z643kJr.cUT4MJu5fMLW', '정민준', '010-1111-0005', '1985-09-12', 'AUTHOR', NULL, FALSE, FALSE, NULL, NULL, '2025-01-01 11:00:00'),
                                                                                                                                                                  (6, 'mentee@test.com',  '$2a$10$j0lHqS.XzKnx0TrsRsosm.oP3rrvBkUe/z643kJr.cUT4MJu5fMLW', '한예린', '010-1111-0006', '2000-01-25', 'AUTHOR', NULL, FALSE, FALSE, NULL, NULL, '2025-01-04 09:00:00'),
                                                                                                                                                                  (7, 'admin@test.com',   '$2a$10$j0lHqS.XzKnx0TrsRsosm.oP3rrvBkUe/z643kJr.cUT4MJu5fMLW', '관리자',   '010-1111-0007', NULL,         'ADMIN',  NULL, FALSE, FALSE, NULL, NULL, '2025-01-01 08:00:00');

-- 2. author_profiles (users 1, 2, 5, 6)
INSERT INTO author_profiles (id, user_id, bio, career_level, main_genre, instagram_links, x_links, blog_links, allow_mentee_request, updated_at, deleted_at, created_at) VALUES
                                                                                                                                                                             (1, 1, '로맨스 소설 전문 작가입니다. 독자들의 심장을 두근거리게 만드는 것이 목표입니다.', 'INTERMEDIATE', '로맨스', 'https://instagram.com/kimdoyun', NULL, 'https://blog.naver.com/kimdoyun', TRUE,  '2025-01-01 09:00:00', NULL, '2025-01-01 09:00:00'),
                                                                                                                                                                             (2, 2, '판타지 장르를 주로 씁니다. 세계관 구축에 심혈을 기울입니다.',                       'ELEMENTARY',   '판타지', NULL, 'https://x.com/leeseoyeon', NULL,                              FALSE, '2025-01-01 10:00:00', NULL, '2025-01-01 10:00:00'),
                                                                                                                                                                             (3, 5, '무협 소설 15년 경력의 베테랑 작가입니다. 멘토로도 활동 중입니다.',                   'PROFICIENT',   '무협',   NULL, NULL, 'https://blog.naver.com/jungminjun',                          TRUE,  '2025-01-01 11:00:00', NULL, '2025-01-01 11:00:00'),
                                                                                                                                                                             (4, 6, '무협 장르에 도전 중인 신인 작가입니다. 열심히 배우며 성장하고 있습니다.',            'ELEMENTARY',   '무협',   NULL, NULL, NULL,                                                         FALSE, '2025-01-04 09:00:00', NULL, '2025-01-04 09:00:00');

-- 3. reader_profiles (users 3, 4)
INSERT INTO reader_profiles (id, user_id, preferred_genres, reading_goal, updated_at, deleted_at, created_at) VALUES
                                                                                                                  (1, 3, 'ROMANCE_FANTASY,FANTASY', 'STEADY', '2025-01-02 09:00:00', NULL, '2025-01-02 09:00:00'),
                                                                                                                  (2, 4, 'CHIVALROUS,FANTASY',      'LIGHT',  '2025-01-03 09:00:00', NULL, '2025-01-03 09:00:00');

-- 4. author_follows
INSERT INTO author_follows (id, follower_id, following_id, created_at) VALUES
                                                                           (1, 3, 1, '2025-01-05 10:00:00'),
                                                                           (2, 4, 2, '2025-01-06 10:00:00'),
                                                                           (3, 6, 5, '2025-01-10 10:00:00');

-- 5. bank_accounts
INSERT INTO bank_accounts (id, user_id, bank_name, account_number, account_holder, is_verified, created_at) VALUES
                                                                                                                (1, 1, '카카오뱅크', '3333-11-1234567', '김도윤', TRUE, '2025-01-05 10:00:00'),
                                                                                                                (2, 5, '신한은행',   '110-123-456789',  '정민준', TRUE, '2025-01-05 11:00:00');

-- 6. points (BaseEntity 없음 → created_at 컬럼 없음)
INSERT INTO points (id, user_id, balance, updated_at) VALUES
                                                          (1, 1,  6000, '2025-03-01 00:00:00'),
                                                          (2, 2,  2000, '2025-03-01 00:00:00'),
                                                          (3, 3, 14950, '2025-04-01 00:00:00'),
                                                          (4, 4,  4950, '2025-04-01 00:00:00'),
                                                          (5, 5, 10000, '2025-03-01 00:00:00'),
                                                          (6, 6,  3000, '2025-03-01 00:00:00');

-- 7. novels
INSERT INTO novels (id, author_id, title, description, cover_image_url, genre, tags, status, view_count, is_deleted, updated_at, deleted_at, bookmark_count, created_at) VALUES
                                                                                                                                                                             (1, 1, '달빛 아래서',   '두 남녀가 운명처럼 만나 사랑을 키워가는 순수 로맨스 소설입니다.',       NULL, '로맨스', '로맨스,순정,설렘', 'ONGOING',   1250, FALSE, '2025-03-01 00:00:00', NULL, 1, '2025-01-10 09:00:00'),
                                                                                                                                                                             (2, 1, '천공의 기사단', '하늘을 나는 기사들이 악의 제국에 맞서 싸우는 대서사시 판타지입니다.', NULL, '판타지', '판타지,액션,모험', 'COMPLETED', 8300, FALSE, '2025-02-01 00:00:00', NULL, 0, '2024-06-01 09:00:00'),
                                                                                                                                                                             (3, 2, '마법사의 귀환', '전설의 마법사가 환생하여 현대 세계에서 다시 활약하는 이야기입니다.',   NULL, '판타지', '판타지,환생,현판', 'ONGOING',    670, FALSE, '2025-04-01 00:00:00', NULL, 1, '2025-02-01 09:00:00'),
                                                                                                                                                                             (4, 5, '무림전설',       '최강의 무인을 꿈꾸는 청년의 성장기를 담은 정통 무협입니다.',           NULL, '무협',   '무협,성장,액션',   'ONGOING',    910, FALSE, '2025-04-01 00:00:00', NULL, 1, '2025-01-15 09:00:00');

-- 8. novel_wiki
INSERT INTO novel_wiki (id, novel_id, category, title, content, created_at) VALUES
                                                                                (1, 1, 'CHARACTER',     '강민서',        '주인공. 27세 직장인. 차갑고 냉철한 외모와 달리 따뜻한 내면을 가지고 있다.',    '2025-01-11 09:00:00'),
                                                                                (2, 1, 'WORLDBUILDING', '서울 강남 배경', '현대 한국 서울을 배경으로 함. 특히 강남 고층 오피스가 주요 무대.',              '2025-01-11 10:00:00'),
                                                                                (3, 3, 'CHARACTER',     '아르카디안',    '5000년 전 살았던 전설의 마법사. 현대에 환생 후 기억을 되찾아 가는 중.',          '2025-02-02 09:00:00');

-- 9. novel_bookmarks
INSERT INTO novel_bookmarks (id, user_id, novel_id, created_at) VALUES
                                                                    (1, 3, 1, '2025-01-20 10:00:00'),
                                                                    (2, 4, 3, '2025-02-10 10:00:00'),
                                                                    (3, 6, 4, '2025-01-25 10:00:00');

-- 10. episodes
INSERT INTO episodes (id, novel_id, episode_number, title, content, is_free, point_price, status, published_at, updated_at, deleted_at, like_count, is_deleted, created_at) VALUES
-- 달빛 아래서 (novel 1)
(1,  1, 1, '첫 번째 만남',    '그날따라 비가 많이 왔다. 카페 처마 밑에서 비를 피하던 두 사람이 처음 눈을 마주쳤다.', TRUE,  0,   'PUBLISHED', '2025-01-12 09:00:00', '2025-01-12 09:00:00', NULL, 152, FALSE, '2025-01-12 09:00:00'),
(2,  1, 2, '두 번째 우연',    '두 번째로 만난 건 다시 열흘 뒤였다. 이번엔 서점에서였다.',                            FALSE, 50,  'PUBLISHED', '2025-01-19 09:00:00', '2025-01-19 09:00:00', NULL,  87, FALSE, '2025-01-19 09:00:00'),
(3,  1, 3, '고백의 밤',       '강민서는 오늘 마음속에 묻어둔 말을 꺼내기로 결심했다.',                               FALSE, 50,  'PUBLISHED', '2025-01-26 09:00:00', '2025-01-26 09:00:00', NULL,  94, FALSE, '2025-01-26 09:00:00'),
-- 천공의 기사단 (novel 2)
(4,  2, 1, '하늘의 부름',     '제국의 하늘에 검은 구름이 드리웠다. 기사단장 라이온은 칼을 뽑아 들었다.',              TRUE,  0,   'PUBLISHED', '2024-06-05 09:00:00', '2024-06-05 09:00:00', NULL, 230, FALSE, '2024-06-05 09:00:00'),
(5,  2, 2, '첫 번째 전투',    '적군의 선봉대가 마을 외곽에 나타났다. 기사단은 즉각 출동했다.',                        FALSE, 50,  'PUBLISHED', '2024-06-12 09:00:00', '2024-06-12 09:00:00', NULL, 178, FALSE, '2024-06-12 09:00:00'),
(6,  2, 3, '배신자',           '믿었던 동료 중 한 명이 적의 첩자였다는 사실이 밝혀졌다.',                              FALSE, 50,  'PUBLISHED', '2024-06-19 09:00:00', '2024-06-19 09:00:00', NULL, 196, FALSE, '2024-06-19 09:00:00'),
-- 마법사의 귀환 (novel 3)
(7,  3, 1, '낯선 세상',        '눈을 떴을 때 아르카디안은 자신이 전혀 다른 시대에 있다는 것을 깨달았다.',              TRUE,  0,   'PUBLISHED', '2025-02-05 09:00:00', '2025-02-05 09:00:00', NULL, 105, FALSE, '2025-02-05 09:00:00'),
(8,  3, 2, '마법의 재각성',    '현대의 스마트폰을 처음 본 아르카디안은 이것이 마법의 일종이라 생각했다.',             FALSE, 50,  'PUBLISHED', '2025-02-12 09:00:00', '2025-02-12 09:00:00', NULL,  73, FALSE, '2025-02-12 09:00:00'),
-- 무림전설 (novel 4)
(9,  4, 1, '무공 입문',        '강호에 이름을 떨치겠다는 소년 진호는 오늘도 뒷산에서 혼자 수련을 거듭했다.',           TRUE,  0,   'PUBLISHED', '2025-01-18 09:00:00', '2025-01-18 09:00:00', NULL, 320, FALSE, '2025-01-18 09:00:00'),
(10, 4, 2, '첫 번째 시련',    '마을에 난입한 악당들. 진호는 처음으로 진검 승부에 나섰다.',                            FALSE, 100, 'PUBLISHED', '2025-01-25 09:00:00', '2025-01-25 09:00:00', NULL, 210, FALSE, '2025-01-25 09:00:00');

-- 11. episode_likes
INSERT INTO episode_likes (id, user_id, episode_id, created_at) VALUES
                                                                    (1, 3, 1, '2025-01-13 10:00:00'),
                                                                    (2, 4, 1, '2025-01-14 10:00:00'),
                                                                    (3, 3, 4, '2025-01-22 10:00:00'),
                                                                    (4, 6, 9, '2025-01-19 10:00:00');

-- 12. comments (EpisodeComment)
INSERT INTO comments (id, user_id, episode_id, content, created_at) VALUES
                                                                        (1, 3, 1, '너무 설레는 시작이에요! 다음 화가 기대됩니다.',                   '2025-01-13 11:00:00'),
                                                                        (2, 4, 1, '비 오는 날 처음 만나는 설정이 너무 좋아요!',                      '2025-01-14 11:00:00'),
                                                                        (3, 3, 4, '기사단장 라이온의 카리스마가 대단하네요!',                         '2025-02-01 11:00:00'),
                                                                        (4, 6, 9, '무림전설 1화 읽었는데 진짜 재밌어요. 빨리 다음 화 올려주세요!', '2025-01-20 11:00:00');

-- 13. payments
INSERT INTO payments (id, user_id, payment_key, amount, method, status, cancelled_at, created_at) VALUES
                                                                                                      (1, 3, 'pay_20250301_001', 5000,  'CARD',     'COMPLETED', NULL, '2025-03-01 10:00:00'),
                                                                                                      (2, 3, 'pay_20250315_002', 10000, 'KAKAOPAY', 'COMPLETED', NULL, '2025-03-15 10:00:00'),
                                                                                                      (3, 4, 'pay_20250310_003', 5000,  'CARD',     'COMPLETED', NULL, '2025-03-10 10:00:00');

-- 14. purchases
INSERT INTO purchases (id, user_id, type, amount, payment_id, created_at) VALUES
                                                                              (1, 3, 'POINT', 5000, 1, '2025-03-01 10:01:00'),
                                                                              (2, 4, 'POINT', 5000, 3, '2025-03-10 10:01:00');

-- 15. point_histories
INSERT INTO point_histories (id, user_id, novel_id, episode_id, amount, type, description, created_at) VALUES
                                                                                                           (1, 1, NULL, NULL,   1000, 'EVENT', '신규 작가 가입 이벤트 보너스',       '2025-01-01 09:30:00'),
                                                                                                           (2, 3, NULL, NULL,   5000, 'CHARGE', '5,000 포인트 충전 (카드결제)',       '2025-03-01 10:01:00'),
                                                                                                           (3, 3, NULL, NULL,  10000, 'CHARGE', '10,000 포인트 충전 (카카오페이)',    '2025-03-15 10:01:00'),
                                                                                                           (4, 3,    1,    2,    -50, 'NOVEL',  '달빛 아래서 2화 구매',               '2025-03-20 10:00:00'),
                                                                                                           (5, 4, NULL, NULL,   5000, 'CHARGE', '5,000 포인트 충전 (카드결제)',       '2025-03-10 10:01:00'),
                                                                                                           (6, 4,    4,   10,   -100, 'NOVEL',  '무림전설 2화 구매',                   '2025-04-01 10:00:00');

-- 16. Subscriptions
INSERT INTO Subscriptions (id, user_id, plan_type, subscription_status, fail_reason, started_at, ended_at, next_billing_at, created_at) VALUES
    (1, 4, 'PREMIUM', 'ACTIVE', NULL, '2025-04-01 00:00:00', NULL, '2025-05-01 00:00:00', '2025-04-01 00:00:00');

-- 17. mentors
INSERT INTO mentors (id, user_id, career_level, main_genres, mentoring_style, bio, awards_career, max_mentees, allow_instant, preferred_mentee_desc, status, created_at) VALUES
                                                                                                                                                                             (1, 5, 'PROFICIENT',   '["무협","판타지"]', '원고 피드백 중심, 주 1회 온라인 미팅',      '무협 소설 15년 경력의 전문 작가입니다.',             '2020 무협문학대상 수상, 대표작 무림전설 시리즈',   3, TRUE,  '열정과 성실함이 있는 초보 작가',     'APPROVED', '2025-01-05 12:00:00'),
                                                                                                                                                                             (2, 1, 'INTERMEDIATE', '["로맨스","판타지"]','초고 합평 중심, 격주 피드백 제공',            '로맨스 전문 작가로 출판사 데뷔 경험이 있습니다.', '2022 웹소설 신인상 수상, 달빛 아래서 시리즈',      2, FALSE, '로맨스 장르에 관심 있는 신인 작가', 'APPROVED', '2025-02-01 09:00:00');

-- 18. mentorships
INSERT INTO mentorships (id, mentor_id, mentee_id, current_novel_id, motivation, manuscript_url, total_sessions, status, manuscript_download_count, accepted_at, completed_at, created_at) VALUES
                                                                                                                                                                                               (1, 1, 6, 4, '무협 소설을 쓰고 싶은데 처음이라 어디서 시작해야 할지 몰라 멘토링을 신청했습니다.',                   NULL, 0, 'ACCEPTED', 0, '2025-01-12 09:00:00', NULL, '2025-01-10 09:00:00'),
                                                                                                                                                                                               (2, 2, 2, 3, '로맨스 판타지 장르로 전환하고 싶어 경험 많은 멘토님께 배우고 싶습니다.',                              NULL, 0, 'ACCEPTED', 0, '2025-02-10 09:00:00', NULL, '2025-02-08 09:00:00'),
                                                                                                                                                                                               (3, 1, 1, 1, '달빛 아래서 연재를 계속하고 싶은데 갈등 구조와 캐릭터 심화 방면에서 조언을 얻고 싶습니다.', NULL, 0, 'PENDING',  0, NULL,                  NULL, '2025-04-10 09:00:00');

-- 19. chat_rooms
INSERT INTO chat_rooms (id, mentorship_id, mentee_id, mentor_id, created_at) VALUES
                                                                                 (1, 1, 6, 5, '2025-01-12 09:00:00'),
                                                                                 (2, 2, 2, 1, '2025-02-10 09:00:00');

-- 20. chat_messages
INSERT INTO chat_messages (id, room_id, sender_id, content, file_url, message_type, is_read, created_at) VALUES
                                                                                                             (1, 1, 5, '안녕하세요! 멘토링 수락했습니다. 앞으로 잘 부탁드려요.',        NULL, 'TEXT', TRUE,  '2025-01-12 09:05:00'),
                                                                                                             (2, 1, 6, '감사합니다! 열심히 하겠습니다.',                                  NULL, 'TEXT', TRUE,  '2025-01-12 09:10:00'),
                                                                                                             (3, 1, 5, '먼저 기본 무공 설정부터 잡아볼까요? 초안을 보내주세요.',         NULL, 'TEXT', TRUE,  '2025-01-15 10:00:00'),
                                                                                                             (4, 1, 6, '네! 이번 주 안에 초안 정리해서 올려드리겠습니다.',               NULL, 'TEXT', FALSE, '2025-01-15 10:30:00'),
                                                                                                             (5, 2, 1, '이서연 작가님, 멘토링 시작해봐요! 현재 쓰고 계신 초고 먼저 보내주실 수 있나요?', NULL, 'TEXT', TRUE,  '2025-02-10 09:30:00'),
                                                                                                             (6, 2, 2, '네, 감사합니다! 3화까지 작성한 초고 보내드릴게요.',              NULL, 'TEXT', TRUE,  '2025-02-10 10:00:00'),
                                                                                                             (7, 2, 1, '읽어봤는데 세계관 설정이 탄탄하네요. 주인공 감정선을 좀 더 살려보면 좋을 것 같아요.', NULL, 'TEXT', FALSE, '2025-02-15 14:00:00');

-- 21. mentorship_feedbacks
INSERT INTO mentorship_feedbacks (id, mentorship_id, author_id, title, session_number, content, created_at) VALUES
    (1, 1, 5, '1회차 피드백 - 갈등 구조 개선', 1, '한예린 멘티는 기초 설정은 잘 잡혀있으나 갈등 구조가 단조롭습니다. 주인공의 내면 갈등을 더 구체적으로 묘사하면 독자 몰입도가 높아질 것입니다.', '2025-02-01 10:00:00');

-- 22. mentorship_reviews
INSERT INTO mentorship_reviews (id, mentorship_id, reviewer_id, rating, content, created_at) VALUES
    (1, 1, 6, 5, '정민준 멘토님 덕분에 무협 소설 쓰는 방법을 체계적으로 배울 수 있었습니다. 꼼꼼한 피드백 감사합니다!', '2025-03-01 10:00:00');

-- 23. revenues
INSERT INTO revenues (id, author_id, episode_id, amount, balance, type, created_at) VALUES
                                                                                        (1, 1, 2, 35, 35, 'EPISODE_SALE', '2025-03-20 10:05:00'),
                                                                                        (2, 1, 3, 35, 70, 'EPISODE_SALE', '2025-03-22 10:05:00'),
                                                                                        (3, 5, 10, 70, 70, 'EPISODE_SALE', '2025-04-01 10:05:00');

-- 24. withdrawals
INSERT INTO withdrawals (id, author_id, bank_account_id, request_amount, fee, actual_amount, status, requested_at, processed_at, created_at) VALUES
    (1, 1, 1, 50000, 500, 49500, 'PENDING', '2025-04-01 10:00:00', NULL, '2025-04-01 10:00:00');

-- 25. library
INSERT INTO library (id, user_id, novel_id, library_type, novel_title, author_nickname, cover_image_url, last_read_episode_title, created_at) VALUES
                                                                                                                                                  (1, 3, 1, 'READING',   '달빛 아래서',   '김도윤', NULL, '두 번째 우연',  '2025-01-20 10:00:00'),
                                                                                                                                                  (2, 3, 2, 'COMPLETED', '천공의 기사단', '김도윤', NULL, '배신자',         '2025-02-15 10:00:00'),
                                                                                                                                                  (3, 6, 4, 'READING',   '무림전설',       '정민준', NULL, '첫 번째 시련', '2025-01-25 10:00:00');

-- 26. reading_records
INSERT INTO reading_records (id, user_id, novel_id, title, author_name, source, read_date, note, read_page, total_page, reading_status, created_at) VALUES
                                                                                                                                                        (1, 3, 1,    '달빛 아래서',              '김도윤',   'PLATFORM', '2025-03-20', '달콤한 로맨스, 오늘도 설렜다.',          NULL, NULL, 'READING',   '2025-03-20 21:00:00'),
                                                                                                                                                        (2, 3, NULL, '해리포터와 마법사의 돌',   'J.K.롤링', 'EXTERNAL', '2025-04-01', '고전 명작, 역시 재밌다.',                 309,  309,  'COMPLETED', '2025-04-01 22:00:00'),
                                                                                                                                                        (3, 6, 4,    '무림전설',                  '정민준',   'PLATFORM', '2025-04-10', '멘토님 작품이라 더 열심히 읽고 있다.',   NULL, NULL, 'READING',   '2025-04-10 20:00:00');

-- 27. notifications
INSERT INTO notifications (id, event_id, user_id, type, title, content, is_read, created_at) VALUES
                                                                                                 (1, 'a1b2c3d4-0001-0000-0000-000000000001', 3, 'NEW_EPISODE', '달빛 아래서 3화 업로드',    '김도윤 작가의 [달빛 아래서] 3화가 업로드되었습니다.', FALSE, '2025-01-26 09:05:00'),
                                                                                                 (2, 'a1b2c3d4-0001-0000-0000-000000000002', 3, 'PAYMENT',     '포인트 충전 완료',            '10,000 포인트가 정상적으로 충전되었습니다.',           TRUE,  '2025-03-15 10:02:00'),
                                                                                                 (3, 'a1b2c3d4-0001-0000-0000-000000000003', 1, 'FOLLOW',      '새로운 팔로워',               '박지훈 님이 회원님을 팔로우했습니다.',                 TRUE,  '2025-01-05 10:05:00'),
                                                                                                 (4, 'a1b2c3d4-0001-0000-0000-000000000004', 6, 'MENTORSHIP',  '멘토링 수락 완료',            '정민준 멘토님이 멘토링 신청을 수락했습니다.',          TRUE,  '2025-01-12 09:01:00'),
                                                                                                 (5, 'a1b2c3d4-0001-0000-0000-000000000005', 5, 'MENTORSHIP',  '새로운 멘토링 신청',          '한예린 님이 멘토링을 신청했습니다.',                    TRUE,  '2025-01-10 09:05:00');

-- 28. webhook_events
INSERT INTO webhook_events (id, webhook_id, status, event_type, payment_id, raw_payload, error_message, retry_count, complete_at, created_at) VALUES
                                                                                                                                                  (1, 'tx_20250301_001', 'COMPLETE', 'TRANSACTION_PAID', 'pay_20250301_001', '{"type":"Transaction.Paid","data":{"paymentId":"pay_20250301_001"}}', NULL, 0, '2025-03-01 10:00:05', '2025-03-01 10:00:03'),
                                                                                                                                                  (2, 'tx_20250310_003', 'COMPLETE', 'TRANSACTION_PAID', 'pay_20250310_003', '{"type":"Transaction.Paid","data":{"paymentId":"pay_20250310_003"}}', NULL, 0, '2025-03-10 10:00:05', '2025-03-10 10:00:03');
