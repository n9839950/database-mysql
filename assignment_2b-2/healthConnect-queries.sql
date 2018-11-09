-- query 1
SELECT CONCAT(firstName, ' ', surname) AS fullName, nickName, job FROM users
   WHERE suburb LIKE 'Stafford%'
   
-- query 2
SELECT nickName, mentorNickname FROM users WHERE mentorNickname IS NOT NULL

-- query 3
SELECT hp.healthPracID, hp.firstName, hp.surname, COUNT(*) FROM healthpractitioners hp
  INNER JOIN treatmentrecords tr on tr.healthPracId = hp.healthPracId
    INNER JOIN users on tr.nickname = users.nickname
    GROUP BY hp.healthPracId
    

-- query 4
SELECT firstName, city FROM users WHERE nickname NOT IN
    (SELECT pa.nickname FROM postauthors pa 
        INNER JOIN posts p ON pa.postID = p.postID
     UNION
     SELECT users.nickname from users 
        INNER JOIN postcomments pc on users.nickname = pc.nickname) 
        
-- query 5
SELECT i.illnessID, i.name, COUNT(*) AS reports,
 MIN(datestarted), max(datestarted), AVG(degree)
   FROM illness i 
     INNER JOIN treatmentrecords t ON t.illnessID = i.illnessID
     GROUP BY i.illnessID
     

-- query 6
-- no FULL OUTER JOIN
SELECT coalesce(A.nickname, B.nickname) AS nickname, 
  coalesce(commentCount, 0) AS commentCount, coalesce(postCount, 0) AS postCount FROM 
   (SELECT nickname, COUNT(postID) AS commentCount FROM postcomments GROUP BY nickname) AS A
   LEFT JOIN
   (SELECT nickname, COUNT(postID) AS postCount FROM postauthors GROUP BY nickname) AS B
   ON A.nickname = B.nickname
   
UNION  

SELECT coalesce(A.nickname, B.nickname) AS nickname, 
  coalesce(commentCount, 0) AS commentCount, coalesce(postCount, 0) AS postCount FROM
   (SELECT nickname, COUNT(postID) AS commentCount FROM postcomments GROUP BY nickname) AS A
   RIGHT JOIN
   (SELECT nickname, COUNT(postID) AS postCount FROM postauthors GROUP BY nickname) AS B
   ON A.nickname = B.nickname


-- task 3 insert
INSERT INTO users(nickname, firstName, surname, birthYear) VALUES('stormy','Sam', 'Rodgers', 1982)

-- task 3 delete
DELETE FROM phonenumber where phoneNumber LIKE '07%';

-- task 3 update
UPDATE healthpractitioners 
  SET streetNumber = '72', street = 'Evergreen Terrace', city = 'Springfield'
  WHERE surname = 'Smith' AND streetNumber = '180' AND
     street = 'Zelda Street' and city = 'Linkburb';

-- task 4 index
-- this table already has a primary key on the postid. There' no need for another
-- index on that same column.
ALTER TABLE `healthconnect`.`posts` 
ADD INDEX `index2` (`postID` ASC);

-- task 4 create view
CREATE VIEW healthy AS
 SELECT users.nickname, firstname, surname, birthyear FROM users
  LEFT JOIN treatmentrecords tr ON users.nickname = tr.nickname
  WHERE illnessid IS NULL;
  
-- task 5
-- likely to cause errors since the users don't actually exists
GRANT insert, delete ON healthconnect.users to 'wayne';
REVOKE insert, delete ON healthconnect.users FROM 'jake';

