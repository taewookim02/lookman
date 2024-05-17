-- 메인페이지
SELECT 
    P.PRODUCT_NO, 
    TO_CHAR(P.PRICE, '999,999,999.00') PRICE,  
    S.NAME SELLER_NAME,
    P.NAME PRODUCT_NAME, 
    PI.FILENAME, 
    NVL(ROUND(AVG(R.RATING), 1), 0) AVG_RATING, 
    COUNT(R.RATING) REVIEW_CNT
FROM PRODUCT P
LEFT JOIN REVIEW R ON P.PRODUCT_NO = R.PRODUCT_NO
JOIN PRODUCT_IMG PI ON P.PRODUCT_NO = PI.PRODUCT_NO
JOIN SELLER S ON P.SELLER_NO = S.SELLER_NO
WHERE PI.THUMBNAIL_YN = 'Y'
    AND P.DELETED_YN = 'N' 
    AND PI.DELETED_YN = 'N'
GROUP BY P.PRODUCT_NO, P.PRICE, S.NAME, P.NAME, PI.FILENAME
ORDER BY AVG_RATING DESC, PRICE DESC
;

-- 상세페이지에는 
-- 썸네일, 브랜드명, 상품제목, 상품가격, 배송정보, 썸네일 제외 사진들, 상품설명, 리뷰, 
-- 재고의 색상, 사이즈, 각 맞는 재고량이 필요합니다.
SELECT P.PRODUCT_NO, S.NAME SELLER_NAME, P.NAME NAME, P.DETAILS, P.PRICE, P.HIT
FROM PRODUCT P
JOIN SELLER S ON P.SELLER_NO = S.SELLER_NO
WHERE P.PRODUCT_NO = 5
;

-- MemberDao - getMemberNo()
SELECT MEMBER_NO
FROM MEMBER
WHERE ID = 'taewookim02@gmail.com';


-- MemberDao - login()
SELECT * 
FROM MEMBER 
WHERE ID = 'taewookim02@gmail.com' 
AND PWD = '123456789A@'
AND DELETED_YN = 'N' 
AND BAN_DATE IS NULL
;




-- DECREMENT INVENTORY QUANTITY
UPDATE INVENTORY
SET QUANTITY = QUANTITY - 1
WHERE PRODUCT_NO = 1 AND COLOR_NO = 2 AND SIZE_NO = 2
;

-- HIT INCREMENT
UPDATE PRODUCT
SET HIT = HIT + 1
WHERE PRODUCT_NO = 2;



-- REVIEW 
SELECT P.NAME, M.NAME, R.CONTENT, R.RATING
FROM REVIEW R
JOIN PRODUCT P ON R.PRODUCT_NO = P.PRODUCT_NO
JOIN MEMBER M ON M.MEMBER_NO = R.MEMBER_NO
WHERE P.PRODUCT_NO = 1
;


-- ORDER DETAILS
SELECT M.NAME, P.NAME, P.PRICE, OD.QUANTITY, P.PRICE * OD.QUANTITY
FROM ORDER_DETAIL OD
JOIN ORDERS O ON OD.ORDERS_NO = O.ORDERS_NO
JOIN MEMBER M ON O.MEMBER_NO = M.MEMBER_NO
JOIN PRODUCT P ON OD.PRODUCT_NO = P.PRODUCT_NO
WHERE M.MEMBER_NO = 1
;


-- FAQ
SELECT FA.NAME, A.NICK, F.TITLE, F.CONTENT, F.HIT
FROM FAQ F
JOIN ADMIN A ON F.ADMIN_NO = A.ADMIN_NO
JOIN FAQ_CATEGORY FA ON F.FAQ_CATEGORY_NO = FA.FAQ_CATEGORY_NO;


-- REPORT - BAN
