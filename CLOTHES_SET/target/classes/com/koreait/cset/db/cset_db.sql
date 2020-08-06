DROP SEQUENCE BOARD_SEQ;
DROP SEQUENCE ORDERS_SEQ;
DROP SEQUENCE CART_SEQ;
DROP SEQUENCE REVIEWS_SEQ;
DROP SEQUENCE PRODUCTS_SEQ;
DROP SEQUENCE MEMBERS_SEQ;
DROP SEQUENCE STOCK_SEQ;

DROP TABLE BOARD;
DROP TABLE ORDERS;
DROP TABLE CART;
DROP TABLE REVIEWS;
DROP TABLE STOCK;
DROP TABLE PRODUCTS;
DROP TABLE MEMBERS;



CREATE TABLE MEMBERS ( -- 회원 테이블
    MNO NUMBER PRIMARY KEY, --  회원번호
    MSNO VARCHAR2(14) NOT NULL UNIQUE, -- 회원주민등록번호
    MID VARCHAR2(50) NOT NULL UNIQUE, -- 회원 ID
    MNAME VARCHAR2(50) NOT NULL, -- 회원이름
    MPW VARCHAR2(50) NOT NULL, -- 회원 PW
    MADDR VARCHAR2(1000) NOT NULL, -- 회원 주소
    MPNO NUMBER(5) NOT NULL, -- 회원 우편번호
    MEMAIL VARCHAR2(100) NOT NULL UNIQUE , -- 회원 이메일
    MPHONE VARCHAR2(20) NOT NULL, -- 회원 전화번호
    MPAYMENT NUMBER, -- 회원 결제방법코드
    MPOINT NUMBER, -- 구매포인트
    MGRADE CHAR(1), -- 회원등급
    MREGDATE DATE -- 가입일
);

CREATE SEQUENCE MEMBERS_SEQ
START WITH 1
INCREMENT BY 1
MAXVALUE 99999
NOCYCLE
NOCACHE;



CREATE TABLE PRODUCTS( -- 상품 테이블
    PNO NUMBER PRIMARY KEY, -- 상품 번호
    PNAME VARCHAR2(100) NOT NULL, -- 상품명
    PFILENAME VARCHAR2(100), -- 상품 이미지
    PPRICE NUMBER NOT NULL, -- 상품 가격(단가)
    PCATEGORY VARCHAR2(100), -- 상품 구분(카테고리)
    PCATEGORY_SUB VARCHAR2(100), -- 상품 구분(카테고리) 소분류
    PBRAND VARCHAR2(100) NOT NULL ,-- 판매자 상호
    PDISRATE NUMBER-- 상품 할인율
);

CREATE SEQUENCE PRODUCTS_SEQ
START WITH 1
INCREMENT BY 1
MAXVALUE 99999
NOCYCLE
NOCACHE;


CREATE TABLE ORDERS( -- 주문 테이블
    ONO NUMBER PRIMARY KEY, -- 주문 번호
    MID VARCHAR2(50) NOT NULL REFERENCES MEMBERS (MID), -- 주문 회원 ID(외래키)
    PNO NUMBER NOT NULL REFERENCES PRODUCTS (PNO), -- 상품 번호(외래키)
    OAMOUNT NUMBER NOT NULL, -- 주문 수량
    ODATE DATE, -- 주문 일자
    OADDR VARCHAR2(300) NOT NULL, -- 배송지 주소
    OPHONE VARCHAR2(20) NOT NULL, -- 배송지 전화번호
    OPAYMENT NUMBER NOT NULL, -- 결제 방법
    ONOTE VARCHAR2(500), -- 기타 메모
    OPRICE NUMBER, -- 주문 금액
    OSIZE VARCHAR2(10) -- 주문한 상품의 사이즈
);

CREATE SEQUENCE ORDERS_SEQ
START WITH 1
INCREMENT BY 1
MAXVALUE 99999
NOCYCLE
NOCACHE;


CREATE TABLE CART( -- 장바구니 테이블
    CNO NUMBER PRIMARY KEY, -- 장바구니 번호
    MID VARCHAR2(50) NOT NULL REFERENCES MEMBERS (MID), -- 회원 ID(외래키)
    PNO NUMBER NOT NULL REFERENCES PRODUCTS (PNO), -- 상품 번호(외래키)
    CAMOUNT NUMBER NOT NULL, -- 상품 수량  
    CSIZE VARCHAR2(10)-- 장바구니에 담은 상품의 사이즈
);


CREATE SEQUENCE CART_SEQ
START WITH 1
INCREMENT BY 1
MAXVALUE 99999
NOCYCLE
NOCACHE;

CREATE TABLE BOARD( -- 게시판 테이블
    BNO NUMBER PRIMARY KEY, -- B 번호
    MID VARCHAR2(50) NOT NULL REFERENCES MEMBERS (MID), -- 회원 ID(외래키)
    BREGDATE DATE, -- B 작성일
    BTITLE VARCHAR2(200) NOT NULL, -- B 제목
    BCONTENT VARCHAR2(2000), -- B 내용
    BFILENAME VARCHAR2(200), -- 업로드할 파일 이름
    BHIT NUMBER, -- 조회수
    BPW VARCHAR2(20) NOT NULL, -- 게시글 PW (삭제용)
    BREF NUMBER, -- 댓글일 경우 원글 참조하기 위한 컬럼
    BSTEP NUMBER, --
    BDEPTH NUMBER,--
    BCLASS NUMBER -- 게시글 구분(NOTICE / Q&A / FAQ)
);



CREATE SEQUENCE BOARD_SEQ
START WITH 1
INCREMENT BY 1
MAXVALUE 99999
NOCYCLE
NOCACHE;


CREATE TABLE REVIEWS( -- 리뷰 테이블
    RNO NUMBER PRIMARY KEY, -- 리뷰 번호
    PNO NUMBER NOT NULL REFERENCES PRODUCTS (PNO), -- 상품 번호(외래키)
    MID VARCHAR2(50) NOT NULL REFERENCES MEMBERS (MID), -- 작성자 : 회원 ID(외래키)
    RCONTENT VARCHAR2(1000) NOT NULL, -- 리뷰 내용
    RFILENAME VARCHAR2(100), -- 리뷰 이미지 파일 이름
    RREGDATE DATE, -- 리뷰 작성일
    RRATING NUMBER --고객이남기는 평점
);


CREATE SEQUENCE REVIEWS_SEQ
START WITH 1
INCREMENT BY 1
MAXVALUE 99999
NOCYCLE
NOCACHE;








CREATE TABLE STOCK(
   SNO NUMBER PRIMARY KEY,
   PNO NUMBER NOT NULL REFERENCES PRODUCTS (PNO),
   PSIZE VARCHAR2(100),  --상품 사이즈
   SAMOUNT NUMBER -- 재고
);

CREATE SEQUENCE STOCK_SEQ
START WITH 1
INCREMENT BY 1
MAXVALUE 999999
NOCYCLE
NOCACHE;



DELETE FROM PRODUCTS;
COMMIT;

DROP SEQUENCE PRODUCTS_SEQ;
CREATE SEQUENCE PRODUCTS_SEQ
START WITH 1
INCREMENT BY 1
MAXVALUE 999999
NOCYCLE
NOCACHE;


/*

MNO MSNO MID MNAME MPW MADDR MPNO MEMAIL MPHONE MPAYMENT MPOINT MGRADE MREGDATE
회원번호 주민 회원아이디 이름 비번 주소 우편번호 이메일 전화번호 결제방법 구매포인트 회원등급 가입일
 */
INSERT INTO MEMBERS VALUES (MEMBERS_SEQ.nextval,'111111-1111111','ADMIN','관리자','1111','서울 청담',35186,'ADMIN@EMAIL.COM','010-0000-0000',NULL,NULL,'A',SYSDATE);
INSERT INTO MEMBERS VALUES (MEMBERS_SEQ.nextval,'211111-1111111','USER1','1사용자','1111','부산',35186,'USER1@EMAIL.COM','010-0000-0000',NULL,NULL,'D',SYSDATE);
INSERT INTO MEMBERS VALUES (MEMBERS_SEQ.nextval,'311111-1111111','USER2','2사용자','1111','대구 마포',3586,'USER2@EMAIL.COM','010-0000-0000',NULL,NULL,'D',SYSDATE);
INSERT INTO MEMBERS VALUES (MEMBERS_SEQ.nextval,'411111-1111111','USER3','3사용자','1111','제주 마포',3586,'USER3@EMAIL.COM','010-0000-0000',NULL,NULL,'D',SYSDATE);
INSERT INTO MEMBERS VALUES (MEMBERS_SEQ.nextval,'511111-1111111','USER4','4사용자','1111','경기 부천 마포',12186,'USER4@EMAIL.COM','010-0000-0000',NULL,NULL,'D',SYSDATE);
INSERT INTO MEMBERS VALUES (MEMBERS_SEQ.nextval,'611111-1111111','USER5','5사용자','1111','경기 시흥',3586,'USER5@EMAIL.COM','010-0000-0000',NULL,NULL,'D',SYSDATE);
INSERT INTO MEMBERS VALUES (MEMBERS_SEQ.nextval,'711111-1111111','USER6','6사용자','1111','강원 강릉',3586,'USER6@EMAIL.COM','010-0000-0000',NULL,NULL,'D',SYSDATE);
INSERT INTO MEMBERS VALUES (MEMBERS_SEQ.nextval,'811111-1111111','USER7','7사용자','1111','충남 대전',35186,'USER7@EMAIL.COM','010-0000-0000',NULL,NULL,'D',SYSDATE);
INSERT INTO MEMBERS VALUES (MEMBERS_SEQ.nextval,'911111-1111111','USER8','8사용자','1111','해남',35086,'USER8@EMAIL.COM','010-0000-0000',NULL,NULL,'D',SYSDATE);
INSERT INTO MEMBERS VALUES (MEMBERS_SEQ.nextval,'101111-1111111','USER9','9사용자','1111','전남 목포',3586,'USER9@EMAIL.COM','010-0000-0000',NULL,NULL,'D',SYSDATE);
INSERT INTO MEMBERS VALUES (MEMBERS_SEQ.nextval,'201111-1111111','USER10','10사용자','1111','독도',3586,'USER410@EMAIL.COM','010-0000-0000',NULL,NULL,'D',SYSDATE);
INSERT INTO MEMBERS VALUES (MEMBERS_SEQ.nextval,'202111-1111111','vpdnsldk','석진','1111','독도',3586,'vpdnsldk321@naver.com','010-0000-0000',NULL,NULL,'D',SYSDATE);


commit
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '드라이 스우시 반팔','드라이스우시반팔.jpg', 35000, '상의', '티셔츠', '나이키', 3);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, 'NSW 퓨추라반팔','NSW퓨추라반팔.jpg', 32500, '상의', '티셔츠', '나이키', 10);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '저스트두잇반팔블랙','저스트두잇반팔.jpg', 35000, '상의', '티셔츠', '나이키', 5);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '저스트두잇반팔화이트','저스트두잇반팔화이트.jpg', 35000, '상의', '티셔츠', '나이키', 10);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, 'NSW 스우시반팔','NSW스우시반팔.jpg', 32500, '상의', '티셔츠', '나이키', 5);



/*상의 티셔츠 아디다스*/
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '락업티','락업티.jpg', 23000, '상의', '티셔츠', '아디다스', 4);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '아디컬러프리머엄티셔츠','아디컬러프리머엄티셔츠.jpg', 23000, '상의', '티셔츠', '아디다스', 20);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, 'MTEC티셔츠네이비','MTEC티셔츠네이비.jpg', 23000, '상의', '티셔츠', '아디다스', 22);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, 'MTEC티셔츠카키','MTEC티셔츠카키.jpg', 23000, '상의', '티셔츠', '아디다스', 10);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '파스텔티셔츠','파스텔티셔츠.jpg', 23000, '상의', '티셔츠', '아디다스', 11);


/*상의 맨투맨후드 나이키*/
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '브러스트클럽맨투맨','브러스트클럽맨투맨.jpg', 69000, '상의', '맨투맨후드', '나이키', 4);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, 'NSW퓨추라크루탑','NSW퓨추라크루탑.jpg', 89000, '상의', '맨투맨후드', '나이키', 5);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, 'NSW에어플리스크루넥','NSW에어플리스크루넥.jpg', 59000, '상의', '맨투맨후드', '나이키', 6);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '미들체리후드','미들체리후드.jpg', 78000, '상의', '맨투맨후드', '나이키', 7);



/*상의 맨투맨후드 아디다스*/
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '릴렉스오버사이즈크루넥','릴렉스오버사이즈크루넥.jpg', 78000, '상의', '맨투맨후드', '아디다스', 4);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, 'WUPO스웻셔츠블랙','WUPO스웻셔츠블랙.jpg', 59000, '상의', '맨투맨후드', '아디다스', 5);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '3ST크루블루','3ST크루블루.jpg', 59000, '상의', '맨투맨후드', '아디다스', 6);


/*하의 청바지 페이탈리즘*/
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '무파진블루','무파진블루.jpg', 44000, '하의', '청바지', '페이탈리즘', 6);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '크롭진블루','크롭진블루.jpg', 44000, '하의', '청바지', '페이탈리즘', 5);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '샌드크림진','샌드크림진.jpg', 44000, '하의', '청바지', '페이탈리즘', 4);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '타이핏크롭진','타이핏크롭진.jpg', 44000, '하의', '청바지', '페이탈리즘', 3);



/*하의 청바지 피스워커*/
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '가먼트진','가먼트진.jpg', 59000, '하의', '청바지', '피스워커', 5);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '마인워커','마인워커.jpg', 59000, '하의', '청바지', '피스워커', 10);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '라이트크롭','라이트크롭.jpg', 59000, '하의', '청바지', '피스워커', 11);


/*하의 슬랙스 페이탈리즘*/
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '롱와이드슬랙스','롱와이드슬랙스.jpg', 39000, '하의', '슬랙스', '페이탈리즘', 5);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '스트레이트앞트임슬랙스','스트레이트앞트임슬랙스.jpg', 39000, '하의', '슬랙스', '페이탈리즘', 5);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '옆트임슬랙스','옆트임슬랙스.jpg', 39000, '하의', '슬랙스', '페이탈리즘', 4);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '크롭핏절개슬랙스','크롭핏절개슬랙스.jpg', 39000, '하의', '슬랙스', '페이탈리즘', 6);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '조거핏슬랙스','조거핏슬랙스.jpg', 39000, '하의', '슬랙스', '페이탈리즘', 20);


/*하의 슬랙스 피스워커*/
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '밴딩슬랙스','밴딩슬랙스.jpg', 59000, '하의', '슬랙스', '피스워커', 22);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '코튼린넨슬랙스','코튼린넨슬랙스.jpg', 59000, '하의', '슬랙스', '피스워커', 21);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '밴딩플리츠슬랙스','밴딩플리츠슬랙스.jpg', 59000, '하의', '슬랙스', '피스워커', 10);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '유니섹스세미와이드','유니섹스세미와이드.jpg', 59000, '하의', '슬랙스', '피스워커', 10);


/*아우터 자켓 나이키*/
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '아카데미바람막이자켓','아카데미바람막이자켓.jpg', 99000, '아우터', '자켓', '나이키', 10);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, 'NSW스우시윈드러너자켓','NSW스우시윈드러너자켓.jpg', 129000, '아우터', '자켓', '나이키', 20);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '우븐하프아노락','우븐하프아노락.jpg', 129000, '아우터', '자켓', '나이키', 10);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '스우시트랙자켓','스우시트랙자켓.jpg', 129000, '아우터', '자켓', '나이키', 10);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '우먼스우븐자켓','우먼스우븐자켓.jpg', 149000, '아우터', '자켓', '나이키', 10);

/*아우터 자켓 아디다스*/
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '락업윈드브레이커','락업윈드브레이커.jpg', 99000, '아우터', '자켓', '아디다스', 10);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '파스텔트랙탑','파스텔트랙탑.jpg', 99000, '아우터', '자켓', '아디다스', 20);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, 'AI윈드브레이커클래식','AI윈드브레이커클래식.jpg', 99000, '아우터', '자켓', '아디다스', 30);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '락업트랙탑화이트','락업트랙탑화이트.jpg', 89000, '아우터', '자켓', '아디다스', 40);


/*하의 청바지 플랙진*/

INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '[PLAC] KURZ B14 RAW','플랙0.jpg', 59000, '하의', '청바지', '플랙', 10);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, 'SLENDER 49U WSHD J736','플랙1.jpg', 59000, '하의', '청바지', '플랙', 10);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, 'STEEZE 112 WSHD','플랙2.jpg', 59000, '하의', '청바지', '플랙', 10);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, 'MILAN P04 LIGHT DESTROYED WSHD','플랙3.jpg', 59000, '하의', '청바지', '플랙', 10);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, 'MILAN P05 MID DESTROYED WSHD','플랙4.jpg', 59000, '하의', '청바지', '플랙', 10);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, 'NEU KURZ P01 MID WSHD','플랙5.jpg', 59000, '하의', '청바지', '플랙', 10);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '[PLAC]BERLIN B30 WSHD','플랙6.jpg', 59000, '하의', '청바지', '플랙', 10);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, 'MILAN 921 WSHD','플랙7.jpg', 59000, '하의', '청바지', '플랙', 10);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '[PLAC] KURZ B14 RAW','플랙8.jpg', 59000, '하의', '청바지', '플랙', 10);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, ' NEU KURZ P01 MID WSHD','플랙9.jpg', 59000, '하의', '청바지', '플랙', 10);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '[PLAC] KURZ B15 RAW','플랙10.jpg', 65000, '하의', '청바지', '플랙', 20);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '[PLAC] KURZ B16 RAW','플랙11.jpg', 65000, '하의', '청바지', '플랙', 20);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '[PLAC] KURZ B17 RAW','플랙12.jpg', 65000, '하의', '청바지', '플랙', 20);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '[PLAC] KURZ B18 RAW','플랙13.jpg', 65000, '하의', '청바지', '플랙', 20);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '[PLAC] KURZ B19 RAW','플랙14.jpg', 65000, '하의', '청바지', '플랙', 20);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '[PLAC] KURZ B20 RAW','플랙15.jpg', 65000, '하의', '청바지', '플랙', 20);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '[PLAC] KURZ B21 RAW','플랙16.jpg', 65000, '하의', '청바지', '플랙', 20);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '[PLAC] KURZ B22 RAW','플랙17.jpg', 65000, '하의', '청바지', '플랙', 20);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '[PLAC] KURZ B23 RAW','플랙18.jpg', 65000, '하의', '청바지', '플랙', 20);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '[PLAC] KURZ B24 RAW','플랙19.jpg', 65000, '하의', '청바지', '플랙', 20);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '[PLAC] KURZ B25 RAW','플랙20.jpg', 65000, '하의', '청바지', '플랙', 20);


/*하의슬랙스 무신사스탠다드*/
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '9부_벨티드_와이드','9부_벨티드_와이드.jpg', 59000, '하의', '슬랙스', '무신사스탠다드', 20);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '20SS_미니멀_스탠다드_카고_조거_슬랙스','20SS_미니멀_스탠다드_카고_조거_슬랙스.jpg', 59000, '하의', '슬랙스', '무신사스탠다드', 30);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '20SS_미니멀_스탠다드_카고_조거_슬랙스','SEMI_WIDE_BASIC_PANTS_(GREEN).jpg', 59000, '하의', '슬랙스', '무신사스탠다드', 30);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '20SS_미니멀_스탠다드_카고_조거_슬랙스','TWILL_PINTUCK_WIDE_PANTS_BEIGE.jpg', 59000, '하의', '슬랙스', '무신사스탠다드', 30);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '20SS_미니멀_스탠다드_카고_조거_슬랙스','라인_포인트_하프_팬츠_블루.jpg', 59000, '하의', '슬랙스', '무신사스탠다드', 30);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '20SS_미니멀_스탠다드_카고_조거_슬랙스','로고_테이프_하프_팬츠_화이트.jpg', 59000, '하의', '슬랙스', '무신사스탠다드', 30);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '20SS_미니멀_스탠다드_카고_조거_슬랙스','밴딩_와이드_슬랙스.jpg', 59000, '하의', '슬랙스', '무신사스탠다드', 30);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '밴딩_플리츠팬츠','밴딩_플리츠팬츠.jpg', 47520, '하의', '슬랙스', '무신사스탠다드', 30);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '브리즈_메탈_링_롱_팬츠_블랙','브리즈_메탈_링_롱_팬츠_블랙.jpg', 47520, '하의', '슬랙스', '무신사스탠다드', 30);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '브리즈_메탈_링_롱_팬츠_화이트','브리즈_메탈_링_롱_팬츠_화이트.jpg', 47520, '하의', '슬랙스', '무신사스탠다드', 30);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '블랙_스트레치_슬림_슬랙스','블랙_스트레치_슬림_슬랙스.jpg', 47520, '하의', '슬랙스', '무신사스탠다드', 30);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '세미_부츠컷_슬랙스_블랙','세미_부츠컷_슬랙스_블랙.jpg', 47520, '하의', '슬랙스', '무신사스탠다드', 30);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '우먼즈_슬림_스트레이트_슬랙스_[인디언 핑크]','우먼즈_슬림_스트레이트_슬랙스_인디언 핑크.jpg', 47520, '하의', '슬랙스', '무신사스탠다드', 30);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '우먼즈_와이드_린넨팬츠_[라이트 베이지]','우먼즈_와이드_린넨팬츠_라이트 베이지.jpg', 47520, '하의', '슬랙스', '무신사스탠다드', 30);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '웨빙벨트_쇼트_슬랙스','웨빙벨트_쇼트_슬랙스.jpg', 47520, '하의', '슬랙스', '무신사스탠다드', 30);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '이지밴딩_세미와이드_슬랙스[베이지]','이지밴딩_세미와이드_슬랙스베이지.jpg', 47520, '하의', '슬랙스', '무신사스탠다드', 30);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '이지밴딩_세미와이드_슬랙스[브라운]','이지밴딩_세미와이드_슬랙스브라운.jpg', 47520, '하의', '슬랙스', '무신사스탠다드', 30);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '코튼린넨_밴딩_크롭_팬츠','코튼린넨_밴딩_크롭_팬츠.jpg', 47520, '하의', '슬랙스', '무신사스탠다드', 30);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '테이퍼드_히든_밴딩_크롭_슬랙스_[블랙]','테이퍼드_히든_밴딩_크롭_슬랙스_블랙.jpg', 47520, '하의', '슬랙스', '무신사스탠다드', 20);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '핀턱_슬림_조거_슬랙스','핀턱_슬림_조거_슬랙스.jpg', 47520, '하의', '슬랙스', '무신사스탠다드', 20);


/*상의 티셔츠 브랜드 기능성티     해결ㅎ*/ 

INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, 'ADDS티셔츠그린','ADDS티셔츠그린.jpg', 39900, '상의', '티셔츠', '기능성티', 7);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, 'BLKD티셔츠그린','BLKD티셔츠그린.jpg', 39900, '상의', '티셔츠', '기능성티', 7);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, 'NSW클럽반팔티셔츠','NSW클럽반팔티셔츠.jpg', 39900, '상의', '티셔츠', '기능성티', 7);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, 'RYV티셔츠크림','RYV티셔츠크림.jpg', 39900, '상의', '티셔츠', '기능성티', 7);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, 'SB반팔티','SB반팔티.jpg', 39900, '상의', '티셔츠', '기능성티', 7);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '드라이스우시반팔라임','드라이스우시반팔라임.jpg', 39900, '상의', '티셔츠', '기능성티', 7);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '드라이스우시반팔오렌지','드라이스우시반팔오렌지.jpg', 39900, '상의', '티셔츠', '기능성티', 7);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '드라이카라티','드라이카라티.jpg', 39900, '상의', '티셔츠', '기능성티', 7);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '매치업폴로카라반팔티','매치업폴로카라반팔티.jpg', 39900, '상의', '티셔츠', '기능성티', 7);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '아웃라인트레포일티','아웃라인트레포일티.jpg', 39900, '상의', '티셔츠', '기능성티', 7);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '에센셜티화이트','에센셜티화이트.jpg', 39900, '상의', '티셔츠', '기능성티', 7);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '크롭탑멀티','크롭탑멀티.jpg', 39900, '상의', '티셔츠', '기능성티', 7);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '크롭탑블랙','크롭탑블랙.jpg', 39900, '상의', '티셔츠', '기능성티', 7);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '크롭티셔츠타이다이','크롭티셔츠타이다이.jpg', 39900, '상의', '티셔츠', '기능성티', 7);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '크롭티셔츠화이트','크롭티셔츠화이트.jpg', 39900, '상의', '티셔츠', '기능성티', 7);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '크롭프리미엄티','크롭프리미엄티.jpg', 39900, '상의', '티셔츠', '기능성티', 7);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '클럽카라티','클럽카라티.jpg', 39900, '상의', '티셔츠', '기능성티', 7);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '파크스우시반팔','파크스우시반팔.jpg', 39900, '상의', '티셔츠', '기능성티', 7);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '퓨추라크롭반팔티','퓨추라크롭반팔티.jpg', 39900, '상의', '티셔츠', '기능성티', 7);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '프리미엄티네이비','프리미엄티네이비.jpg', 39900, '상의', '티셔츠', '기능성티', 7);
INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '프리미엄티레드','프리미엄티레드.jpg', 39900, '상의', '티셔츠', '기능성티', 7);

 
/*상의 맨투맨 후드 어반스토프*/
 INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '페이스_로고_엠브로이더드_후디(그레이)','페이스_로고_엠브로이더드_후디(그레이).jpg', 59000, '상의', '맨투맨후드', '어반스토프', 10);
 INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '페이스_로고_엠브로이더드_후디(그린옐로)','페이스_로고_엠브로이더드_후디(그린옐로).jpg', 59000, '상의', '맨투맨후드', '어반스토프', 10);
 INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '페이스_로고_엠브로이더드_후디(네이비)','페이스_로고_엠브로이더드_후디(네이비).jpg', 59000, '상의', '맨투맨후드', '어반스토프', 10);
 INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '페이스_로고_엠브로이더드_후디(민트)','페이스_로고_엠브로이더드_후디(민트).jpg', 59000, '상의', '맨투맨후드', '어반스토프', 10);
 INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '페이스_로고_엠브로이더드_후디(펠드그라운)','페이스_로고_엠브로이더드_후디(펠드그라운).jpg', 59000, '상의', '맨투맨후드', '어반스토프', 10);
 
 INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '세인트페인_베리에이션_로고_후드','세인트페인_베리에이션_로고_후드.jpg', 59000, '상의', '맨투맨후드', '어반스토프', 30);
 INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, 'HOODEI_PINK','HOODEI_PINK.jpg', 59000, '상의', '맨투맨후드', '어반스토프', 30);
 INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, 'MG_SIGN_LOGO_CREWNECK_PURPLE','MG_SIGN_LOGO_CREWNECK_PURPLE.jpg', 59000, '상의', '맨투맨후드', '어반스토프', 30);
 INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, 'MG_SMALL_SIGN_LOGO_CREWNECK_BLACK','MG_SMALL_SIGN_LOGO_CREWNECK_BLACK.jpg', 59000, '상의', '맨투맨후드', '어반스토프', 30);
 INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, 'MG_SMALL_SIGN_LOGO_CREWNECK_GRAY','MG_SMALL_SIGN_LOGO_CREWNECK_GRAY.jpg', 59000, '상의', '맨투맨후드', '어반스토프', 30);
 INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, 'MG_SMALL_SIGN_LOGO_CREWNECK_GREEN','MG_SMALL_SIGN_LOGO_CREWNECK_GREEN.jpg', 59000, '상의', '맨투맨후드', '어반스토프', 30);
 INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, 'MG_SMALL_SIGN_LOGO_CREWNECK_PEACH','MG_SMALL_SIGN_LOGO_CREWNECK_PEACH.jpg', 59000, '상의', '맨투맨후드', '어반스토프', 30);
 INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, 'LOCATION_CREWNECK_JS[BEIGE]','LOCATION_CREWNECK_JS_BEIGE.jpg', 59000, '상의', '맨투맨후드', '비바스튜디오', 30);
 INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, 'LOCATION_CREWNECK_JS[IVORY]','LOCATION_CREWNECK_JS_IVORY.jpg', 59000, '상의', '맨투맨후드', '비바스튜디오', 30);
 INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, 'LOCATION_CREWNECK_JS[MIDDLE_PURPLE]','LOCATION_CREWNECK_JS_MIDDLE_PURPLE.jpg', 59000, '상의', '맨투맨후드', '비바스튜디오', 30);
 INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, 'LOCATION_LOGO_CREWNECK_IA[INDIGO_BLUE]','LOCATION_LOGO_CREWNECK_IA_INDIGO_BLUE.jpg', 59000, '상의', '맨투맨후드', '비바스튜디오', 30);
 INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, 'LOCATION_LOGO_CREWNECK_IA[PASTEL_BLUE]','LOCATION_LOGO_CREWNECK_IA_PASTEL_BLUE.jpg', 59000, '상의', '맨투맨후드', '비바스튜디오', 30);
 
 INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '스케이트_맥_후드_그레이','스케이트_맥_후드_그레이.jpg', 59000, '상의', '맨투맨후드', '트레셔', 10);
 INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '스케이트_맥_후드_네이비','스케이트_맥_후드_네이비.jpg', 59000, '상의', '맨투맨후드', '트레셔', 10);
 INSERT INTO PRODUCTS VALUES (PRODUCTS_SEQ.NEXTVAL, '스케이트_맥_후드_블랙','스케이트_맥_후드_블랙.jpg', 59000, '상의', '맨투맨후드', '트레셔', 10);

 
 
 INSERT INTO PRODUCTS VALUES ( PRODUCTS_SEQ.NEXTVAL, '더블울블레이져BLACK' , '더블울블레이져BLACK.jpg', 179000, '아우터', '자켓', '인사일런스', 0);
INSERT INTO PRODUCTS VALUES ( PRODUCTS_SEQ.NEXTVAL, '오버사이즈린넨블레이져BLACK' , '오버사이즈린넨블레이져BLACK.jpg', 144000, '아우터', '자켓', '인사일런스', 0);
INSERT INTO PRODUCTS VALUES ( PRODUCTS_SEQ.NEXTVAL, '피크드라펠울블레이져BLACK' , '피크드라펠울블레이져BLACK.jpg', 179000, '아우터', '자켓', '인사일런스', 0);
INSERT INTO PRODUCTS VALUES ( PRODUCTS_SEQ.NEXTVAL, '스트랩더블이지자켓BLACK' , '스트랩더블이지자켓BLACK.jpg', 169000, '아우터', '자켓', '인사일런스', 0);
INSERT INTO PRODUCTS VALUES ( PRODUCTS_SEQ.NEXTVAL, '트로피컬울블레이져BLACK' , '트로피컬울블레이져BLACK.jpg', 172000, '아우터', '자켓', '인사일런스', 0);

INSERT INTO PRODUCTS VALUES ( PRODUCTS_SEQ.NEXTVAL, '솔리스트오버사이즈캐시미어코트CHARCOAL' , '솔리스트오버사이즈캐시미어코트CHARCOAL.jpg', 248000, '아우터', '코트', '인사일런스', 0);
INSERT INTO PRODUCTS VALUES ( PRODUCTS_SEQ.NEXTVAL, '라이트웨이트롱트렌치코트GREY' , '라이트웨이트롱트렌치코트GREY.jpg', 179000, '아우터', '코트', '인사일런스', 0);
INSERT INTO PRODUCTS VALUES ( PRODUCTS_SEQ.NEXTVAL, '솔리스트오버사이즈캐시미어코트NAVY' , '솔리스트오버사이즈캐시미어코트NAVY.jpg', 248000, '아우터', '코트', '인사일런스', 0);
INSERT INTO PRODUCTS VALUES ( PRODUCTS_SEQ.NEXTVAL, '미니멀구스다운자켓NAVY' , '미니멀구스다운자켓NAVY.jpg', 265000, '아우터', '자켓', '인사일런스', 0);
INSERT INTO PRODUCTS VALUES ( PRODUCTS_SEQ.NEXTVAL, '마커스캐시미어로브코트BLACK' , '마커스캐시미어로브코트BLACK.jpg', 289000, '아우터', '코트', '인사일런스', 0);

INSERT INTO PRODUCTS VALUES ( PRODUCTS_SEQ.NEXTVAL, '오버사이즈하프코트CREAM' , '오버사이즈하프코트CREAM.jpg', 229000, '아우터', '코트', '인사일런스', 0);
INSERT INTO PRODUCTS VALUES ( PRODUCTS_SEQ.NEXTVAL, '오버사이즈하프코트BLACK' , '오버사이즈하프코트BLACK.jpg', 229000, '아우터', '코트', '인사일런스', 0);
INSERT INTO PRODUCTS VALUES ( PRODUCTS_SEQ.NEXTVAL, '울라이너자켓BROWN' , '울라이너자켓BROWN.jpg', 188000, '아우터', '자켓', '인사일런스', 0);
INSERT INTO PRODUCTS VALUES ( PRODUCTS_SEQ.NEXTVAL, '울라이너자켓BLACK' , '울라이너자켓BLACK.jpg', 188000, '아우터', '자켓', '인사일런스', 0);
INSERT INTO PRODUCTS VALUES ( PRODUCTS_SEQ.NEXTVAL, '프론트지퍼자겟CHARCOAL' , '프론트지퍼자겟CHARCOAL.jpg', 169000, '아우터', '자켓', '인사일런스', 0);

INSERT INTO PRODUCTS VALUES ( PRODUCTS_SEQ.NEXTVAL, '오버사이즈숄카라코트BROWN' , '오버사이즈숄카라코트BROWN.jpg', 289000, '아우터', '코트', '인사일런스', 0);
INSERT INTO PRODUCTS VALUES ( PRODUCTS_SEQ.NEXTVAL, '후드파카BLACK' , '후드파카BLACK.jpg', 148000, '아우터', '자켓', '인사일런스', 0);
INSERT INTO PRODUCTS VALUES ( PRODUCTS_SEQ.NEXTVAL, '드레이프프라이트블루종BLACK' , '드레이프프라이트블루종BLACK.jpg', 142000, '아우터', '자켓', '인사일런스', 0);
INSERT INTO PRODUCTS VALUES ( PRODUCTS_SEQ.NEXTVAL, '나일론윈드브레이커BLACK' , '나일론윈드브레이커BLACK.jpg', 129000, '아우터', '자켓', '인사일런스', 0);
INSERT INTO PRODUCTS VALUES ( PRODUCTS_SEQ.NEXTVAL, '나일론윈드브레이커CREAM' , '나일론윈드브레이커CREAM.jpg', 129000, '아우터', '자켓', '인사일런스', 0);

INSERT INTO PRODUCTS VALUES ( PRODUCTS_SEQ.NEXTVAL, '오버사이즈숄카라코트BLACK' , '오버사이즈숄카라코트BLACK.jpg', 289000, '아우터', '코트', '인사일런스', 0);
INSERT INTO PRODUCTS VALUES ( PRODUCTS_SEQ.NEXTVAL, '피크더블캐시미어코트BRICKRED' , '피크더블캐시미어코트BRICKRED.jpg', 256000, '아우터', '코트', '인사일런스', 0);
INSERT INTO PRODUCTS VALUES ( PRODUCTS_SEQ.NEXTVAL, '트로피컬울발마칸코트BLACK' , '트로피컬울발마칸코트BLACK.jpg', 219000, '아우터', '코트', '인사일런스', 0);
INSERT INTO PRODUCTS VALUES ( PRODUCTS_SEQ.NEXTVAL, '체스터코트KHAKI' , '체스터코트KHAKI.jpg', 329000, '아우터', '코트', '인사일런스', 0);
INSERT INTO PRODUCTS VALUES ( PRODUCTS_SEQ.NEXTVAL, '오버핏레더자켓BLACK' , '오버핏레더자켓BLACK.jpg', 289000, '아우터', '자켓', '인사일런스', 0);

INSERT INTO PRODUCTS VALUES ( PRODUCTS_SEQ.NEXTVAL, '트로피컬울발마칸코트BEIGE' , '트로피컬울발마칸코트BEIGE.jpg', 219000, '아우터', '코트', '인사일런스', 0);
INSERT INTO PRODUCTS VALUES ( PRODUCTS_SEQ.NEXTVAL, '락업윈드브레이커BLACK' , '락업윈드브레이커BLACK.jpg', 109000, '아우터', '자켓', '아디다스', 0);
INSERT INTO PRODUCTS VALUES ( PRODUCTS_SEQ.NEXTVAL, '파이어버드트랙탑BLACK' , '파이어버드트랙탑BLACK.jpg', 109000, '아우터', '자켓', '아디다스', 0);
INSERT INTO PRODUCTS VALUES ( PRODUCTS_SEQ.NEXTVAL, '테크아노락BLACK' , '테크아노락BLACK.jpg', 109000, '아우터', '자켓', '아디다스', 0);
INSERT INTO PRODUCTS VALUES ( PRODUCTS_SEQ.NEXTVAL, '베켄바우어트랙탑BLACK' , '베켄바우어트랙탑BLACK.jpg', 99000, '아우터', '자켓', '아디다스', 0);

INSERT INTO PRODUCTS VALUES ( PRODUCTS_SEQ.NEXTVAL, 'ID자켓BLACK' , 'ID자켓BLACK.jpg', 129000, '아우터', '자켓', '아디다스', 0);
INSERT INTO PRODUCTS VALUES ( PRODUCTS_SEQ.NEXTVAL, '파스텔트랙탑' , '파스텔트랙탑.jpg', 109000, '아우터', '자켓', '아디다스', 0);
INSERT INTO PRODUCTS VALUES ( PRODUCTS_SEQ.NEXTVAL, '플레임스트라이크트랙탑BLACK' , '플레임스트라이크트랙탑BLACK.jpg', 109000, '아우터', '자켓', '아디다스', 0);
INSERT INTO PRODUCTS VALUES ( PRODUCTS_SEQ.NEXTVAL, '우븐자켓BLACK' , '우븐자켓BLACK.jpg', 119000, '아우터', '자켓', '아디다스', 0);
INSERT INTO PRODUCTS VALUES ( PRODUCTS_SEQ.NEXTVAL, '데컴패커블자켓BLACK' , '데컴패커블자켓BLACK.jpg', 99000, '아우터', '자켓', '아디다스', 0);

INSERT INTO PRODUCTS VALUES ( PRODUCTS_SEQ.NEXTVAL, '빅트레포일플리스자켓BLACK' , '빅트레포일플리스자켓BLACK.jpg', 119000, '아우터', '자켓', '아디다스', 0);
INSERT INTO PRODUCTS VALUES ( PRODUCTS_SEQ.NEXTVAL, '테크아노락GREEN' , '테크아노락GREEN.jpg', 109000, '아우터', '자켓', '아디다스', 0);
INSERT INTO PRODUCTS VALUES ( PRODUCTS_SEQ.NEXTVAL, '보아자켓WHITE' , '보아자켓WHITE.jpg', 149000, '아우터', '자켓', '아디다스', 0);
INSERT INTO PRODUCTS VALUES ( PRODUCTS_SEQ.NEXTVAL, '스트라이프풀집GREY' , '스트라이프풀집GREY.jpg', 179000, '아우터', '자켓', '아디다스', 0);
INSERT INTO PRODUCTS VALUES ( PRODUCTS_SEQ.NEXTVAL, '발란타탑NAVY' , '발란타탑NAVY.jpg', 139000, '아우터', '자켓', '아디다스', 0);




/************* ORDERS 더미데이터 **************/
INSERT INTO ORDERS VALUES (ORDERS_SEQ.nextval,'USER1',1,1,SYSDATE,'경기도 부천시 상동','010-1111-1234',1,NULL,0,'S');
INSERT INTO ORDERS VALUES (ORDERS_SEQ.nextval,'USER1',2,1,SYSDATE,'경기도 부천시 상동','010-1111-1234',1,NULL,0,'S');
INSERT INTO ORDERS VALUES (ORDERS_SEQ.nextval,'USER1',3,1,SYSDATE,'경기도 부천시 상동','010-1111-1234',1,NULL,0,'S');
INSERT INTO ORDERS VALUES (ORDERS_SEQ.nextval,'USER1',4,1,SYSDATE,'경기도 부천시 상동','010-1111-1234',1,NULL,0,'S');


INSERT INTO ORDERS VALUES (ORDERS_SEQ.nextval,'USER2',14,1,'2020-07-1','경기도 부천시 상동','010-1111-1234',1,NULL,0,'S');
INSERT INTO ORDERS VALUES (ORDERS_SEQ.nextval,'USER3',24,1,'2020-07-2','경기도 부천시 상동','010-1111-1234',1,NULL,0,'S');
INSERT INTO ORDERS VALUES (ORDERS_SEQ.nextval,'USER4',41,1,'2020-07-3','경기도 부천시 상동','010-1111-1234',1,NULL,0,'S');
INSERT INTO ORDERS VALUES (ORDERS_SEQ.nextval,'USER5',43,1,'2020-07-4','경기도 부천시 상동','010-1111-1234',1,NULL,0,'S');

INSERT INTO ORDERS VALUES (ORDERS_SEQ.nextval,'USER2',83,1,'2020-07-7','경기도 부천시 상동','010-1111-1234',1,NULL,0,'S');
INSERT INTO ORDERS VALUES (ORDERS_SEQ.nextval,'USER3',83,1,'2020-07-8','경기도 부천시 상동','010-1111-1234',1,NULL,0,'S');
INSERT INTO ORDERS VALUES (ORDERS_SEQ.nextval,'USER4',83,1,'2020-07-8','경기도 부천시 상동','010-1111-1234',1,NULL,0,'S');

INSERT INTO ORDERS VALUES (ORDERS_SEQ.nextval,'USER5',143,1,'2020-07-6','경기도 부천시 상동','010-1111-1234',1,NULL,0,'S');
INSERT INTO ORDERS VALUES (ORDERS_SEQ.nextval,'USER6',143,1,'2020-07-7','경기도 부천시 상동','010-1111-1234',1,NULL,0,'S');

INSERT INTO ORDERS VALUES (ORDERS_SEQ.nextval,'USER2',23,1,'2020-07-8','경기도 부천시 상동','010-1111-1234',1,NULL,0,'S');
INSERT INTO ORDERS VALUES (ORDERS_SEQ.nextval,'USER1',23,1,'2020-07-10','경기도 부천시 상동','010-1111-1234',1,NULL,0,'S');

INSERT INTO ORDERS VALUES (ORDERS_SEQ.nextval,'USER4',13,1,'2020-07-8','경기도 부천시 상동','010-1111-1234',1,NULL,0,'S');


 
 /******** BOARD, REIVEWS 더미데이터 ***********/
/*REVIEW INSERT*/
 INSERT INTO REVIEWS (RNO, PNO, MID, RCONTENT, RFILENAME, RREGDATE, RRATING)
VALUES (REVIEWS_SEQ.NEXTVAL, 1, 'USER1', '이 티셔츠의 색감이 정말 좋아요 다른거 살까하다가 이거 샀는데 잘한 선택인거 같아요!', 'nike01.jpg' ,SYSDATE, 5);
 INSERT INTO REVIEWS (RNO, PNO, MID, RCONTENT, RFILENAME, RREGDATE, RRATING)
VALUES (REVIEWS_SEQ.NEXTVAL, 1, 'USER2', '사이즈도 딱 맞고 색도 너무 예뻐요! 다른 색도 사고 싶네여~!!', 'nike02.jpg' ,SYSDATE, 4);
 INSERT INTO REVIEWS (RNO, PNO, MID, RCONTENT, RFILENAME, RREGDATE, RRATING)
VALUES (REVIEWS_SEQ.NEXTVAL, 1, 'USER3', '티셔츠 색감이 너무 좋아요! 친구 생일 선물로 사줬더니 참 좋아하네요!!', '' ,SYSDATE, 5);
INSERT INTO REVIEWS (RNO, PNO, MID, RCONTENT, RFILENAME, RREGDATE, RRATING)
VALUES (REVIEWS_SEQ.NEXTVAL, 1, 'USER4', '오매불망 기다렸는데 무슨 배송이 일주일씩이나 걸리나요;;; 약속도 다 지나고 와서 당황스럽네요;;', '' ,SYSDATE, 1);
 INSERT INTO REVIEWS (RNO, PNO, MID, RCONTENT, RFILENAME, RREGDATE, RRATING)
VALUES (REVIEWS_SEQ.NEXTVAL, 1, 'USER5', '사이즈가 너무 작고 색깔도 칙칙해서 반품하고 싶네여...그래도 배송비가 아까우니까 잠옷으로 입을게여...', '' ,SYSDATE, 2);
INSERT INTO REVIEWS (RNO, PNO, MID, RCONTENT, RFILENAME, RREGDATE, RRATING)
VALUES (REVIEWS_SEQ.NEXTVAL, 1, 'USER6', '오매불망 기다렸는데 무슨 배송이 일주일씩이나 걸리나요;;; 약속도 다 지나고 와서 당황스럽네요;;', '' ,SYSDATE, 1);
INSERT INTO REVIEWS (RNO, PNO, MID, RCONTENT, RFILENAME, RREGDATE, RRATING)
VALUES (REVIEWS_SEQ.NEXTVAL, 1, 'USER7', '색감이 너무 이뻐여!! 다음에 또 구매 하려고 하는데 재입고하기만 기다리고 있겠습니다!', 'nike03.jpg' ,SYSDATE, 5);
INSERT INTO REVIEWS (RNO, PNO, MID, RCONTENT, RFILENAME, RREGDATE, RRATING)
VALUES (REVIEWS_SEQ.NEXTVAL, 1, 'USER8', '여름에 시원하게 입으려고 샀는데 정말 잘산거 같아요 소재가 정말 시원해요 너무 예쁘네요!', '' ,SYSDATE, 5);
INSERT INTO REVIEWS (RNO, PNO, MID, RCONTENT, RFILENAME, RREGDATE, RRATING)
VALUES (REVIEWS_SEQ.NEXTVAL, 1, 'USER1', '사이즈도 딱 맞고 색도 너무 예뻐요! 다른 색도 사고 싶네여~!!!!!!!', '' ,SYSDATE, 4);
INSERT INTO REVIEWS (RNO, PNO, MID, RCONTENT, RFILENAME, RREGDATE, RRATING)
VALUES (REVIEWS_SEQ.NEXTVAL, 2, 'USER1', '사이즈도 딱 맞고 색도 너무 예뻐요! 다른 색도 사고 싶네여~!!', '' ,SYSDATE, 4);
 INSERT INTO REVIEWS (RNO, PNO, MID, RCONTENT, RFILENAME, RREGDATE, RRATING)
VALUES (REVIEWS_SEQ.NEXTVAL, 3, 'USER1', '티셔츠 색감이 너무 좋아요! 친구 생일 선물로 사줬더니 참 좋아하네요!!', '' ,SYSDATE, 5);
INSERT INTO REVIEWS (RNO, PNO, MID, RCONTENT, RFILENAME, RREGDATE, RRATING)
VALUES (REVIEWS_SEQ.NEXTVAL, 18, 'USER1', '색감이 너무 이뻐여!! 다음에 또 구매 하려고 하는데 재입고하기만 기다리고 있겠습니다!', '' ,SYSDATE, 5);
INSERT INTO REVIEWS (RNO, PNO, MID, RCONTENT, RFILENAME, RREGDATE, RRATING)
VALUES (REVIEWS_SEQ.NEXTVAL, 4, 'USER1', '여름에 시원하게 입으려고 샀는데 정말 잘산거 같아요 소재가 정말 시원해요 너무 예쁘네요!', '' ,SYSDATE, 5);
INSERT INTO REVIEWS (RNO, PNO, MID, RCONTENT, RFILENAME, RREGDATE, RRATING)
VALUES (REVIEWS_SEQ.NEXTVAL, 10, 'USER1', '사이즈도 딱 맞고 색도 너무 예뻐요! 다른 색도 사고 싶네여~!!!!!!!', '' ,SYSDATE, 4);


/******** BOARD INSERT *********/
-- 1. 공지사항
INSERT INTO BOARD(BNO, MID, BREGDATE, BTITLE, BCONTENT, BFILENAME, BHIT, BPW, BREF, BSTEP, BDEPTH, BCLASS)
VALUES(BOARD_SEQ.NEXTVAL, 'ADMIN', SYSDATE, '[07월 신용카드 무이자 행사 안내]', '▶ 기간 : 2020년 07월 1일 ~ 2020년 07월 31일
▶ 금액 : 5만원 이상

▣ 무이자 안내
▶ 대상카드사

1. 현대카드: 2, 3, 4, 5, 6, 7개월 무이자

2. 삼성카드: 2, 3, 4, 5, 6개월 무이자

3. 비씨카드: 2, 3, 4, 5, 6개월 무이자

4. NH농협카드: 2, 3, 4, 5, 6개월 무이자

5. 신한카드: 2, 3, 4, 5, 6개월 무이자

6. KB국민카드: 2, 3, 4, 5, 6개월 무이자

7. 하나카드 (하나SK/외환): 2, 3, 4, 5, 6개월 무이자

8. 롯데카드: 2, 3, 4, 5개월 무이자

9. 전북카드 : 2, 3개월 무이자', NULL, 3, '1111', BOARD_SEQ.CURRVAL, 0, 0, 0);
INSERT INTO BOARD(BNO, MID, BREGDATE, BTITLE, BCONTENT, BFILENAME, BHIT, BPW, BREF, BSTEP, BDEPTH, BCLASS)
VALUES(BOARD_SEQ.NEXTVAL, 'ADMIN', SYSDATE, '댓글은 마음의 창입니다', '안녕하세요 관리자입니다.

최근 들어 눈살이 찌푸려지게 하는 댓글과 리뷰들이 종종 보이고 있습니다.

저희 Clothes-set은 악풀이나 악성 리뷰들에 대해 강경히 대응 할 것을 알려드립니다.

댓글이나 리뷰를 작성 하시기 전에 내 댓글이 지나치게 공격적이거나 불필요한 비방 및 욕설을 포함하고 있지는 않은지

한 번쯤 생각해보시기 바랍니다.

댓글은 마음의 창입니다. 

저희 Clothes-set을 방문해주시는 고객님들은 패션 감각만큼이나 멋진 마음씨를 가지고 계시리라 믿습니다.

관리자 올림', NULL, 3, '1111', BOARD_SEQ.CURRVAL, 0, 0, 0);
INSERT INTO BOARD(BNO, MID, BREGDATE, BTITLE, BCONTENT, BFILENAME, BHIT, BPW, BREF, BSTEP, BDEPTH, BCLASS)
VALUES(BOARD_SEQ.NEXTVAL, 'ADMIN', SYSDATE, '8월 착용샷 이벤트 당첨자 발표', '2020년 5월 착용샷 이벤트 당첨자를 발표합니다

수많은 경쟁자를 뚫고 당첨되신 회원님은 바로...

[황석진]님 입니다!!

아이템들을 너무나 감각있게 소화해 주셨고 사진도 너무나 예쁘게 찍어주셨습니다

앞으로 매달 착용샷 이벤트가 있으니 많은 참여 부탁드립니다

', 'notice001.jpg', 3, '1111', BOARD_SEQ.CURRVAL, 0, 0, 0);

INSERT INTO BOARD(BNO, MID, BREGDATE, BTITLE, BCONTENT, BFILENAME, BHIT, BPW, BREF, BSTEP, BDEPTH, BCLASS)
VALUES(BOARD_SEQ.NEXTVAL, 'ADMIN', SYSDATE, '대리구매 이용 자제를 당부드립니다.', '대리구매 이용 시 사기 피해가 발생될 수 있으며, 

개인 정보가 노출되어 악용될 수 있습니다.

대리구매로 발생되는 피해는 [Clothes-set]에서 책임지지 않사오니 이용 자제를 당부드립니다.', NULL, 0, '1111', BOARD_SEQ.CURRVAL, 0, 0, 0);

Insert into BOARD (BNO,MID,BREGDATE,BTITLE,BCONTENT,BFILENAME,BHIT,BPW,BREF,BSTEP,BDEPTH,BCLASS) values (BOARD_SEQ.NEXTVAL,'ADMIN',to_date('20/07/17','RR/MM/DD'),'배송 전 환불 관련 안내','- 배송비는 우체국택배 착불 이용시에만 편도1,800원 / 왕복3,600원 해당되며 선불, 타택배이용으로 추가되는금액은 추가입금해주셔야됩니다.

- 무료배송 혜택 받아보신경우 취소 후 구매금액 변동으로 배송비 발생할수있습니다.

- 입금후 3층게시판으로 입금문의주셔야 확인가능합니다.

- 불량&오배송&입고지연&품절의경우 수수료 차감없이처리됩니다.

- 에스크로 결제가아닌 일반실시간계좌이체의경우 부분취소 도와드리고있으며,

　환불 접수된 날로부터 영업일기준 5-7일 이내 환불 금액이 입금됩니다.',null,0,'1111',BOARD_SEQ.CURRVAL,0,0,0);
Insert into BOARD (BNO,MID,BREGDATE,BTITLE,BCONTENT,BFILENAME,BHIT,BPW,BREF,BSTEP,BDEPTH,BCLASS) values (BOARD_SEQ.NEXTVAL,'ADMIN',to_date('20/07/17','RR/MM/DD'),'개인정보 취급방침',' 

안녕하세요?  CLOTHES-SET입니다.
CLOTHES-SET는 보다 나은 서비스 제공을 위해 2013년 6 월 11 일 부터 개인정보 취급방침이 아래와 같이 개정됩니다.


      1. 주요 개정사항 : 개인정보 취급위탁 업체 변경

      2. 변경내용 ( 개인정보취급방침 전문보기)

      * 수탁업체 : SIIC Inc / Simplex Sientific Technology Co., Ltd.      * 위탁업무 : 고객상담업무

      3. 개정시기 2013년 6 월 11 일

      4. 관련문의  고객센터 ( Tel : 1688-1360 /  E-mail :moonkyungmin@itsc.com)


     CLOTHES-SET은 고객의 개인정보를 소중히 취급하고 있으며, 보다 안전하게 보호할 것을 약속 드립 
  니다.

     감사합니다. 


 ',null,0,'1111',BOARD_SEQ.CURRVAL,0,0,0);
Insert into BOARD (BNO,MID,BREGDATE,BTITLE,BCONTENT,BFILENAME,BHIT,BPW,BREF,BSTEP,BDEPTH,BCLASS) values (BOARD_SEQ.NEXTVAL,'ADMIN',to_date('20/07/17','RR/MM/DD'),'미입금 주문 자동취소기한 단축 안내','고객님들의 상품 주문에 좀 더 확실한 구매결정으로

 많은 고객들에게 좀 더 빠르게 상품을 구입 가능 하고자

 미입금 주문 자동취소가

 기존 10일에서 -> 5일 로 변경되어 진행될 예정입니다.


 이에 따라 주문 후 반드시 5일 이내에 입금을 해주셔야 주문이 유효합니다.


주문시 기재하신 결제정보

[입금자명 / 결제금액 / 은행] 등 동일한 정보로

입금이 해주셔야 빠르게 상품 준비가 시작될 수 있습니다.


(단, 상품이 조기 품절될 수 있으니 상품의 품절여부를 확인해주세요.)


더 예쁘고 새로운 신상들로 고객만족을 위해 최선을 다하겠습니다.

저희 쇼핑몰을 이용해주셔서 진심으로 감사합니다^^


 ',null,0,'1111',BOARD_SEQ.CURRVAL,0,0,0);
Insert into BOARD (BNO,MID,BREGDATE,BTITLE,BCONTENT,BFILENAME,BHIT,BPW,BREF,BSTEP,BDEPTH,BCLASS) values (BOARD_SEQ.NEXTVAL,'ADMIN',to_date('20/07/17','RR/MM/DD'),'고객보상제도','CLOTHES-SET 고객보상제도

상품 품절, 상품 하자, 오배송, 배송 지연 등 예기치 못한 불편을 겪으셨나요?
고객님들의 불편을 최소화하기 위해 고객보상제도를 마련했습니다.

개별 문자 발송으로 입고지연 안내드리는 경우,
따로 적립금이 지급되지 않는 점 양해 부탁드려요~!
   - 상품 품절 => 500POINT 적립
   - 불량 / 오배송 => 500POINT 적립
   - 입고 지연 ( 5일 이상 ) => 1000POINT적립
',null,1,'1111',BOARD_SEQ.CURRVAL,0,0,0);
Insert into BOARD (BNO,MID,BREGDATE,BTITLE,BCONTENT,BFILENAME,BHIT,BPW,BREF,BSTEP,BDEPTH,BCLASS) values (BOARD_SEQ.NEXTVAL,'ADMIN',to_date('20/07/17','RR/MM/DD'),'이용약관 변경 안내','안녕하세요. CLOTHES-SET입니다.
항상 저희 쇼핑몰을 이용해주셔서 진심으로 감사드립니다.
고객님들께 보다 나은 서비스 제공을 위해 CLOTHES-SET ''이용약관''이 2020년 
7월 17일부터 아래요 같이 개정됩니다.

   - 개정사항
     공정거래위원회 전자상거래업체 표준약관을 준용한 조항추가 및 일부 모호한 문구 수정 등
   	
   - 변경 내용
	▶ 변경된 이용약관 전문 보기
	▶ (구) 이용약관 전문 보기

   - 개정 시기
     2020년 7월 17일부터 효력 발생

   - 관련문의 
     고객센터 (TEL : 1566 - 0000)

CLOTHES-SET은 앞으로 고객님들께 더 큰 만족을 드리기 위해 최선을 다하겠습니다.
감사합니다.',null,4,'1111',BOARD_SEQ.CURRVAL,0,0,0);

-- Q&A

INSERT INTO BOARD(BNO, MID, BREGDATE, BTITLE, BCONTENT, BFILENAME, BHIT, BPW, BREF, BSTEP, BDEPTH, BCLASS)
VALUES(BOARD_SEQ.NEXTVAL, 'USER1', SYSDATE, '주문을 취소하고 싶어요', '주문을 취소하고 싶은데 어떻게 하면 되나요?', NULL, 3, '1111', BOARD_SEQ.CURRVAL, 0, 0, 1);
INSERT INTO BOARD(BNO, MID, BREGDATE, BTITLE, BCONTENT, BFILENAME, BHIT, BPW, BREF, BSTEP, BDEPTH, BCLASS)
VALUES(BOARD_SEQ.NEXTVAL, 'USER1', SYSDATE, '환불하고 싶어요', '옷이 별로 마음에 안들어요.
환불은 어떻게 하면 되나요?', NULL, 3, '1111', BOARD_SEQ.CURRVAL, 0, 0, 1);
INSERT INTO BOARD(BNO, MID, BREGDATE, BTITLE, BCONTENT, BFILENAME, BHIT, BPW, BREF, BSTEP, BDEPTH, BCLASS)
VALUES(BOARD_SEQ.NEXTVAL, 'USER2', SYSDATE, '반품을 보낼 때 배송비를 동봉하지 않았어요', '환불 받을 금액에서 자동으로 차감되나요?
아니면 따로 입금을 해야 하나요?', NULL, 3, '1111', BOARD_SEQ.CURRVAL, 0, 0, 1);
INSERT INTO BOARD(BNO, MID, BREGDATE, BTITLE, BCONTENT, BFILENAME, BHIT, BPW, BREF, BSTEP, BDEPTH, BCLASS)
VALUES(BOARD_SEQ.NEXTVAL, 'USER2', SYSDATE, '주문 내역을 확인하고 싶어요', '이 사이트가 처음이어서 잘 모르겠네요ㅠㅠ
알려주시면 감사하겠습니다!', NULL, 3, '1111', BOARD_SEQ.CURRVAL, 0, 0, 1);
INSERT INTO BOARD(BNO, MID, BREGDATE, BTITLE, BCONTENT, BFILENAME, BHIT, BPW, BREF, BSTEP, BDEPTH, BCLASS)
VALUES(BOARD_SEQ.NEXTVAL, 'USER3', SYSDATE, '', '', NULL, 3, '1111', BOARD_SEQ.CURRVAL, 0, 0, 1);
Insert into BOARD (BNO,MID,BREGDATE,BTITLE,BCONTENT,BFILENAME,BHIT,BPW,BREF,BSTEP,BDEPTH,BCLASS) 
values (BOARD_SEQ.NEXTVAL,'USER2',to_date('20/07/17','RR/MM/DD'),'포인트 내역 확인하고 싶어요',null,null,1,'1111',BOARD_SEQ.CURRVAL,0,0,1);
Insert into BOARD (BNO,MID,BREGDATE,BTITLE,BCONTENT,BFILENAME,BHIT,BPW,BREF,BSTEP,BDEPTH,BCLASS) 
values (BOARD_SEQ.NEXTVAL,'USER4',to_date('20/07/17','RR/MM/DD'),'휴대폰 번호가 바뀌었는데 변경할 수 있나요?',null,null,2,'1111',BOARD_SEQ.CURRVAL,0,0,1);
Insert into BOARD (BNO,MID,BREGDATE,BTITLE,BCONTENT,BFILENAME,BHIT,BPW,BREF,BSTEP,BDEPTH,BCLASS) 
values (BOARD_SEQ.NEXTVAL,'USER5',to_date('20/07/17','RR/MM/DD'),'리뷰작성은 어디서 하나요?',null,null,1,'1111',BOARD_SEQ.CURRVAL,0,0,1);
Insert into BOARD (BNO,MID,BREGDATE,BTITLE,BCONTENT,BFILENAME,BHIT,BPW,BREF,BSTEP,BDEPTH,BCLASS) 
values (BOARD_SEQ.NEXTVAL,'USER6',to_date('20/07/17','RR/MM/DD'),'회원가입은 어떻게 하나요?',null,null,2,'1111',BOARD_SEQ.CURRVAL,0,0,1);
Insert into BOARD (BNO,MID,BREGDATE,BTITLE,BCONTENT,BFILENAME,BHIT,BPW,BREF,BSTEP,BDEPTH,BCLASS) 
values (BOARD_SEQ.NEXTVAL,'USER2',to_date('20/07/17','RR/MM/DD'),'로그인이 안돼요',null,null,1,'1111',BOARD_SEQ.CURRVAL,0,0,1);
INSERT INTO BOARD(BNO, MID, BREGDATE, BTITLE, BCONTENT, BFILENAME, BHIT, BPW, BREF, BSTEP, BDEPTH, BCLASS)
VALUES(BOARD_SEQ.NEXTVAL, 'USER3', SYSDATE, '상품 상태가 이상해요', '옷이 여기저기 탈색되었고 마감도 좀 이상해요
품질 관리에 신경좀 써주세요 기분이 정말 나쁘네요
보상은 어떻게 받으면 돼요?', 'board002.jpg', 3, '1111', BOARD_SEQ.CURRVAL, 0, 0, 1);
Insert into BOARD (BNO,MID,BREGDATE,BTITLE,BCONTENT,BFILENAME,BHIT,BPW,BREF,BSTEP,BDEPTH,BCLASS) 
values (BOARD_SEQ.NEXTVAL,'USER8',to_date('20/07/17','RR/MM/DD'),'주문 내역을 확인하고 싶어요.','이전에 주문했던 상품이 너무 마음에 들어서 다시 주문하려 합니다
혹시 어디서 과거 주문 이력을 확인할 수 있나요?' ,null,1,'1111',BOARD_SEQ.CURRVAL,0,0,1);
Insert into BOARD (BNO,MID,BREGDATE,BTITLE,BCONTENT,BFILENAME,BHIT,BPW,BREF,BSTEP,BDEPTH,BCLASS) 
values (BOARD_SEQ.NEXTVAL,'USER7',to_date('20/07/17','RR/MM/DD'),'주문 후 옵션, 배송지 변경은 어떻게 하나요?',null,null,1,'1111',BOARD_SEQ.CURRVAL,0,0,1);
Insert into BOARD (BNO,MID,BREGDATE,BTITLE,BCONTENT,BFILENAME,BHIT,BPW,BREF,BSTEP,BDEPTH,BCLASS) 
values (BOARD_SEQ.NEXTVAL,'USER9',to_date('20/07/17','RR/MM/DD'),'포인트 내역 확인하고 싶어요',null,null,1,'1111',BOARD_SEQ.CURRVAL,0,0,1);
Insert into BOARD (BNO,MID,BREGDATE,BTITLE,BCONTENT,BFILENAME,BHIT,BPW,BREF,BSTEP,BDEPTH,BCLASS) 
values (BOARD_SEQ.NEXTVAL,'USER2',to_date('20/07/17','RR/MM/DD'),'휴대폰 번호가 바뀌었는데 변경할 수 있나요?',null,null,2,'1111',BOARD_SEQ.CURRVAL,0,0,1);
Insert into BOARD (BNO,MID,BREGDATE,BTITLE,BCONTENT,BFILENAME,BHIT,BPW,BREF,BSTEP,BDEPTH,BCLASS) 
values (BOARD_SEQ.NEXTVAL,'USER3',to_date('20/07/17','RR/MM/DD'),'리뷰작성은 어디서 하나요?',null,null,1,'1111',BOARD_SEQ.CURRVAL,0,0,1);
Insert into BOARD (BNO,MID,BREGDATE,BTITLE,BCONTENT,BFILENAME,BHIT,BPW,BREF,BSTEP,BDEPTH,BCLASS) 
values (BOARD_SEQ.NEXTVAL,'USER4',to_date('20/07/17','RR/MM/DD'),'회원가입은 어떻게 하나요?',null,null,2,'1111',BOARD_SEQ.CURRVAL,0,0,1);
Insert into BOARD (BNO,MID,BREGDATE,BTITLE,BCONTENT,BFILENAME,BHIT,BPW,BREF,BSTEP,BDEPTH,BCLASS) 
values (BOARD_SEQ.NEXTVAL,'USER3',to_date('20/07/17','RR/MM/DD'),'로그인이 안돼요',null,null,1,'1111',BOARD_SEQ.CURRVAL,0,0,1);

INSERT INTO BOARD(BNO, MID, BREGDATE, BTITLE, BCONTENT, BFILENAME, BHIT, BPW, BREF, BSTEP, BDEPTH, BCLASS)
VALUES(BOARD_SEQ.NEXTVAL,'ADMIN', SYSDATE, '주문 취소 관련 안내 드립니다', '주문은 MY 페이지 메뉴에서 직접 취소 가능 합니다.

- 결제대기/결제완료/상품준비중 : 주문/배송조회에서 고객님께서 직접 주문취소 가능

- 배송준비중 : 판매자 배송 준비 기간으로 3영업일(주말 제외) 간 주문취소가 되지 않으며, 
   만약 3영업일 이내 주문 취소를 원하실 경우
판매자에게 Q&A/카톡/전화로 직접 주문취소 요청 하시어 가능 여부를 확인해 주셔야 합니다.', NULL, 1,'1111', 10, 1,	1,	1);

INSERT INTO BOARD(BNO, MID, BREGDATE, BTITLE, BCONTENT, BFILENAME, BHIT, BPW, BREF, BSTEP, BDEPTH, BCLASS)
VALUES(BOARD_SEQ.NEXTVAL,'ADMIN', SYSDATE,'환불 관련 안내 드립니다', '"교환/반품 모두 내의 [환불요청] 버튼을 클릭 후 진행 가능하십니다.

- 교환의 경우 환불요청 버튼을 눌러 주신 뒤 교환 처리가 완료된 후 환불요청 취소 해 주시면 됩니다.
환불/교환 요청 접수 시 택배 회수 시스템을 제공되지 않으며 각 스토어마다 환불 및 교환의 규정에 차이가 있을 수 있으므로
구매하셨던 판매자 고객센터로 직접 관련 문의 해 주셔야 확인 가능한 점 참고 부탁드립니다.
혹, 판매자 고객센터와 연결이 어려우신 경우
주문/배송조회 ▶ 상품사진클릭 ▶ 상세페이지 ▶ Q&A 게시글 작성 해 주시면
영업일 기준 24시간 이내 답변 받아 보실 수 있습니다."', NULL,1, '1111',  11  ,1, 1, 1);

INSERT INTO BOARD(BNO, MID, BREGDATE, BTITLE, BCONTENT, BFILENAME, BHIT, BPW, BREF, BSTEP, BDEPTH, BCLASS)
VALUES(BOARD_SEQ.NEXTVAL,'ADMIN', SYSDATE,'포인트 내역 확인 안내 드립니다', '"안녕하세요 고객님

언제나 저희 [Clothes-Set]을 이용해주셔서 감사합니다

회원님의 포인트 내역은 우측 상단의 [마이페이지]에 들어가시면 확인하실 수 있습니다

감사합니다"', NULL, 1, '1111', 23,1, 1, 1 );

INSERT INTO BOARD(BNO, MID, BREGDATE, BTITLE, BCONTENT, BFILENAME, BHIT, BPW, BREF, BSTEP, BDEPTH, BCLASS)
VALUES(BOARD_SEQ.NEXTVAL,'ADMIN', SYSDATE,'주문내역 확인 안내 드립니다', '"안녕하세요 고객님

언제나 저희 [Clothes-Set]을 이용해주셔서 감사합니다

회원님의 주문내역은 우측 상단의 [마이페이지] 우선 클릭하시고

[마이페이지]에서 좌측 상단의 [주문 내역 확인] 링크에 접속하시면 확인하실 수 있습니다

감사합니다"', NULL, 1, '1111', 13,1, 1, 1 );

INSERT INTO BOARD(BNO, MID, BREGDATE, BTITLE, BCONTENT, BFILENAME, BHIT, BPW, BREF, BSTEP, BDEPTH, BCLASS)
VALUES(BOARD_SEQ.NEXTVAL,'ADMIN', SYSDATE,'상품 이상 관련', '"안녕하세요 고객님

언제나 저희 [Clothes-Set]을 이용해주셔서 감사합니다

무엇보다 먼저 고객님의 기분을 상하게 해드린 점 진심으로 사과드립니다.

우선 admin@clothesset.com으로 제품 상태가 자세히 보이는 사진과 업체명을 보내주시면

즉시 업체에 알려 교환해드리도록 하겠습니다

배송비는 업체에서 부담할 것입니다

다시한 번 죄송하다는 말씀 드립니다

감사합니다"', NULL, 1, '1111', 20,1, 1, 1 );


/******** STOCK INSERT *********/
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,1,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,1,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,1,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,2,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,2,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,2,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,3,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,3,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,3,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,4,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,4,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,4,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,5,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,5,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,5,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,6,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,6,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,6,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,7,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,7,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,7,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,8,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,8,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,8,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,9,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,9,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,9,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,10,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,10,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,10,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,11,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,11,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,11,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,12,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,12,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,12,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,13,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,13,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,13,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,14,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,14,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,14,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,15,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,15,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,15,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,16,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,16,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,16,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,17,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,17,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,17,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,18,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,18,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,18,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,19,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,19,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,19,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,20,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,20,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,20,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,21,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,21,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,21,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,22,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,22,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,22,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,23,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,23,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,23,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,24,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,24,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,24,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,25,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,25,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,25,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,26,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,26,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,26,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,27,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,27,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,27,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,28,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,28,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,28,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,29,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,29,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,29,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,30,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,30,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,30,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,31,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,31,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,31,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,32,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,32,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,32,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,33,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,33,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,33,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,34,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,34,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,34,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,35,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,35,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,35,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,36,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,36,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,36,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,37,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,37,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,37,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,38,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,38,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,38,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,39,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,39,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,39,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,40,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,40,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,40,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,41,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,41,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,41,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,42,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,42,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,42,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,43,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,43,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,43,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,44,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,44,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,44,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,45,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,45,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,45,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,46,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,46,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,46,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,47,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,47,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,47,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,48,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,48,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,48,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,49,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,49,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,49,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,50,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,50,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,50,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,51,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,51,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,51,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,52,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,52,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,52,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,53,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,53,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,53,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,54,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,54,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,54,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,55,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,55,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,55,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,56,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,56,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,56,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,57,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,57,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,57,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,58,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,58,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,58,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,59,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,59,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,59,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,60,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,60,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,60,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,61,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,61,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,61,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,62,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,62,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,62,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,63,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,63,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,63,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,64,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,64,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,64,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,65,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,65,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,65,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,66,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,66,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,66,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,67,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,67,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,67,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,68,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,68,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,68,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,69,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,69,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,69,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,70,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,70,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,70,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,71,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,71,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,71,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,72,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,72,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,72,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,73,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,73,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,73,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,74,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,74,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,74,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,75,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,75,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,75,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,76,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,76,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,76,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,77,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,77,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,77,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,78,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,78,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,78,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,79,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,79,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,79,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,80,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,80,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,80,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,81,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,81,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,81,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,82,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,82,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,82,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,83,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,83,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,83,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,84,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,84,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,84,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,85,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,85,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,85,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,86,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,86,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,86,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,87,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,87,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,87,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,88,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,88,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,88,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,89,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,89,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,89,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,90,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,90,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,90,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,91,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,91,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,91,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,92,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,92,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,92,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,93,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,93,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,93,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,94,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,94,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,94,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,95,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,95,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,95,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,96,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,96,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,96,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,97,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,97,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,97,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,98,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,98,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,98,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,99,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,99,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,99,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,100,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,100,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,100,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,101,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,101,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,101,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,102,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,102,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,102,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,103,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,103,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,103,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,104,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,104,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,104,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,105,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,105,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,105,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,106,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,106,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,106,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,107,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,107,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,107,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,108,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,108,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,108,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,109,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,109,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,109,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,110,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,110,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,110,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,111,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,111,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,111,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,112,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,112,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,112,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,113,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,113,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,113,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,114,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,114,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,114,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,115,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,115,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,115,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,116,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,116,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,116,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,117,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,117,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,117,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,118,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,118,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,118,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,119,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,119,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,119,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,120,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,120,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,120,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,121,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,121,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,121,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,122,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,122,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,122,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,123,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,123,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,123,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,124,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,124,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,124,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,125,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,125,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,125,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,126,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,126,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,126,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,127,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,127,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,127,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,128,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,128,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,128,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,129,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,129,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,129,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,130,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,130,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,130,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,131,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,131,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,131,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,132,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,132,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,132,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,133,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,133,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,133,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,134,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,134,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,134,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,135,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,135,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,135,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,136,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,136,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,136,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,137,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,137,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,137,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,138,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,138,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,138,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,139,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,139,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,139,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,140,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,140,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,140,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,141,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,141,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,141,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,142,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,142,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,142,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,143,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,143,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,143,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,144,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,144,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,144,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,145,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,145,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,145,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,146,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,146,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,146,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,147,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,147,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,147,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,148,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,148,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,148,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,149,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,149,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,149,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,150,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,150,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,150,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,151,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,151,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,151,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,152,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,152,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,152,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,153,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,153,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,153,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,154,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,154,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,154,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,155,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,155,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,155,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,156,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,156,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,156,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,157,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,157,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,157,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,158,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,158,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,158,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,159,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,159,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,159,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,160,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,160,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,160,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,161,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,161,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,161,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,162,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,162,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,162,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,163,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,163,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,163,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,164,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,164,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,164,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,165,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,165,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,165,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,166,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,166,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,166,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,167,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,167,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,167,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,168,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,168,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,168,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,169,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,169,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,169,'L',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,170,'S',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,170,'M',30);
INSERT INTO STOCK VALUES(STOCK_SEQ.NEXTVAL,170,'L',30);


/******** REVIEWS INSERT *********/
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 1, 'USER6', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 1, 'USER2', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 2, 'USER6', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 2, 'USER8', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 3, 'USER5', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 3, 'USER3', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 4, 'USER6', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 4, 'USER10', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 5, 'USER3', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 5, 'USER9', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 6, 'USER8', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 6, 'USER1', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 7, 'USER1', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 7, 'USER8', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 8, 'USER2', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 8, 'USER10', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 9, 'USER10', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 9, 'USER9', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 10, 'USER2', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 10, 'USER3', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 11, 'USER3', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 11, 'USER9', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 12, 'USER3', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 12, 'USER7', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 13, 'USER7', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 13, 'USER10', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 14, 'USER5', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 14, 'USER3', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 15, 'USER4', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 15, 'USER10', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 16, 'USER2', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 16, 'USER2', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 17, 'USER3', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 17, 'USER7', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 18, 'USER3', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 18, 'USER4', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 19, 'USER4', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 19, 'USER3', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 20, 'USER6', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 20, 'USER6', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 21, 'USER5', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 21, 'USER10', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 22, 'USER1', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 22, 'USER4', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 23, 'USER4', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 23, 'USER1', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 24, 'USER2', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 24, 'USER4', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 25, 'USER7', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 25, 'USER4', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 26, 'USER3', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 26, 'USER10', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 27, 'USER3', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 27, 'USER1', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 28, 'USER5', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 28, 'USER5', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 29, 'USER8', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 29, 'USER4', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 30, 'USER4', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 30, 'USER2', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 31, 'USER4', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 31, 'USER9', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 32, 'USER9', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 32, 'USER2', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 33, 'USER6', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 33, 'USER5', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 34, 'USER2', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 34, 'USER9', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 35, 'USER6', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 35, 'USER4', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 36, 'USER4', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 36, 'USER8', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 37, 'USER9', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 37, 'USER7', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 38, 'USER9', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 38, 'USER4', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 39, 'USER3', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 39, 'USER4', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 40, 'USER6', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 40, 'USER10', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 41, 'USER5', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 41, 'USER4', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 42, 'USER6', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 42, 'USER3', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 43, 'USER9', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 43, 'USER3', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 44, 'USER3', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 44, 'USER6', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 45, 'USER10', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 45, 'USER3', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 46, 'USER4', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 46, 'USER3', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 47, 'USER4', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 47, 'USER8', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 48, 'USER7', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 48, 'USER2', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 49, 'USER4', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 49, 'USER3', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 50, 'USER4', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 50, 'USER7', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 51, 'USER10', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 51, 'USER2', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 52, 'USER6', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 52, 'USER4', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 53, 'USER2', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 53, 'USER7', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 54, 'USER6', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 54, 'USER8', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 55, 'USER9', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 55, 'USER4', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 56, 'USER8', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 56, 'USER7', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 57, 'USER8', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 57, 'USER6', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 58, 'USER8', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 58, 'USER1', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 59, 'USER9', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 59, 'USER10', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 60, 'USER4', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 60, 'USER4', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 61, 'USER10', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 61, 'USER5', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 62, 'USER2', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 62, 'USER9', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 63, 'USER10', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 63, 'USER5', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 64, 'USER9', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 64, 'USER9', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 65, 'USER8', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 65, 'USER2', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 66, 'USER2', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 66, 'USER7', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 67, 'USER6', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 67, 'USER3', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 68, 'USER6', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 68, 'USER4', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 69, 'USER9', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 69, 'USER1', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 70, 'USER8', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 70, 'USER1', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 71, 'USER7', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 71, 'USER1', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 72, 'USER6', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 72, 'USER7', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 73, 'USER7', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 73, 'USER9', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 74, 'USER10', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 74, 'USER1', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 75, 'USER9', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 75, 'USER3', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 76, 'USER10', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 76, 'USER7', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 77, 'USER3', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 77, 'USER6', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 78, 'USER4', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 78, 'USER1', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 79, 'USER8', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 79, 'USER6', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 80, 'USER6', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 80, 'USER2', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 81, 'USER4', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 81, 'USER8', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 82, 'USER2', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 82, 'USER7', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 83, 'USER6', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 83, 'USER9', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 84, 'USER2', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 84, 'USER9', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 85, 'USER6', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 85, 'USER3', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 86, 'USER1', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 86, 'USER1', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 87, 'USER1', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 87, 'USER1', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 88, 'USER2', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 88, 'USER8', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 89, 'USER6', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 89, 'USER1', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 90, 'USER10', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 90, 'USER5', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 91, 'USER3', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 91, 'USER6', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 92, 'USER2', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 92, 'USER6', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 93, 'USER7', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 93, 'USER8', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 94, 'USER2', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 94, 'USER2', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 95, 'USER9', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 95, 'USER8', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 96, 'USER10', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 96, 'USER5', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 97, 'USER10', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 97, 'USER3', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 98, 'USER8', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 98, 'USER8', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 99, 'USER7', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 99, 'USER10', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 100, 'USER5', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 100, 'USER5', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 101, 'USER5', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 101, 'USER6', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 102, 'USER9', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 102, 'USER4', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 103, 'USER5', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 103, 'USER1', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 104, 'USER9', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 104, 'USER7', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 105, 'USER3', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 105, 'USER4', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 106, 'USER9', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 106, 'USER7', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 107, 'USER9', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 107, 'USER8', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 108, 'USER10', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 108, 'USER3', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 109, 'USER8', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 109, 'USER7', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 110, 'USER2', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 110, 'USER9', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 111, 'USER4', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 111, 'USER10', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 112, 'USER8', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 112, 'USER10', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 113, 'USER3', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 113, 'USER6', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 114, 'USER4', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 114, 'USER1', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 115, 'USER6', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 115, 'USER5', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 116, 'USER6', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 116, 'USER6', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 117, 'USER5', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 117, 'USER10', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 118, 'USER2', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 118, 'USER1', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 119, 'USER1', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 119, 'USER10', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 120, 'USER6', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 120, 'USER4', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 121, 'USER8', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 121, 'USER10', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 122, 'USER6', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 122, 'USER1', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 123, 'USER6', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 123, 'USER8', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 124, 'USER1', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 124, 'USER2', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 125, 'USER9', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 125, 'USER1', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 126, 'USER3', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 126, 'USER8', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 127, 'USER2', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 127, 'USER1', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 128, 'USER5', '이 가격을 주고 살��한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 128, 'USER2', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 129, 'USER6', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 129, 'USER7', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 130, 'USER6', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 130, 'USER9', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 131, 'USER1', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 131, 'USER8', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 132, 'USER4', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 132, 'USER5', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 133, 'USER4', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 133, 'USER2', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 134, 'USER1', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 134, 'USER7', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 135, 'USER3', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 135, 'USER10', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 136, 'USER10', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 136, 'USER3', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 137, 'USER7', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 137, 'USER9', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 138, 'USER9', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 138, 'USER10', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 139, 'USER6', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 139, 'USER10', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 140, 'USER7', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 140, 'USER7', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 141, 'USER5', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 141, 'USER7', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 142, 'USER1', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 142, 'USER4', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 143, 'USER6', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 143, 'USER5', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 144, 'USER6', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 144, 'USER6', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 145, 'USER9', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 145, 'USER1', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 146, 'USER6', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 146, 'USER9', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 147, 'USER1', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 147, 'USER9', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 148, 'USER3', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 148, 'USER9', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 149, 'USER6', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 149, 'USER2', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 150, 'USER1', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 150, 'USER1', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 151, 'USER8', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 151, 'USER6', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 152, 'USER2', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 152, 'USER5', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 153, 'USER5', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 153, 'USER2', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 154, 'USER6', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 154, 'USER3', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 155, 'USER5', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 155, 'USER7', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 156, 'USER1', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 156, 'USER3', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 157, 'USER7', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 157, 'USER9', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 158, 'USER4', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 158, 'USER5', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 159, 'USER6', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 159, 'USER1', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 160, 'USER7', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 160, 'USER6', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 161, 'USER2', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 161, 'USER8', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 162, 'USER3', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 162, 'USER6', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 163, 'USER7', '그저 그런 옷입니다. 비싼데 생각보다 옷감도 그닥인거 같고.. 잘 모르겠네요', 'review2.jpg', SYSDATE, 3);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 163, 'USER4', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 164, 'USER2', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 164, 'USER1', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 165, 'USER9', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 165, 'USER10', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 166, 'USER4', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 166, 'USER6', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 167, 'USER3', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 167, 'USER9', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 168, 'USER4', '이 가격에 이 옷을 사다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 168, 'USER3', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 169, 'USER8', '꽤나 비싸게 샀다고 생각하는데.. 배송 늦는 건 말할것도 없고 옷도 한가운데가 찢어져서 왔어요', 'null', SYSDATE, 1);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 169, 'USER10', '이 가격에 이 옷을 ��다니! 너무 좋아요! 옷감, 가격, 핏 모두 만족해요. 배송도 빨랐어요!', 'review4.jpg', SYSDATE, 5);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 170, 'USER1', '이 가격을 주고 살만한 제품은 아니라 생각해요... 너무 비쌈', 'review1.jpg', SYSDATE, 2);
INSERT INTO REVIEWS VALUES(REVIEWS_SEQ.NEXTVAL, 170, 'USER3', '상당히 괜찮은 제품입니다. 다만 실제 색감이 사진과 달라요', 'review3.jpg', SYSDATE, 4);


COMMIT