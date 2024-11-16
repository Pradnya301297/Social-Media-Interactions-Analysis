/* 1. Identify Users by Location
 Write a query to find all posts made by usersin specific locations such as 'Agra', 'Maharashtra', and 'West Bengal'.
 Hint: Focus on filtering users by location.*/

SELECT user_id, post_id, location 
FROM users 
JOIN posts ON users.user_id = posts.user_id 
WHERE location IN ('Agra', 'Maharashtra', 'West Bengal');

/*2. Determine the Most Followed Hashtags
Write a query to list the top 5 most-followed hashtags on the platform.
Hint: Join relevant tables to calculate the total follows for each hashtag.*/

SELECT hashtag, COUNT(follow_id) AS total_follows 
FROM hashtags 
JOIN hashtag_follows ON hashtags.hashtag_id = hashtag_follows.hashtag_id 
GROUP BY hashtag 
ORDER BY total_follows DESC 
LIMIT 5;

/*3. Find the Most Used Hashtags
Identify the top 10 most-used hashtags in posts.
Hint: Count how many times each hashtag appears in posts*/

SELECT hashtag, COUNT(post_id) AS usage_count 
FROM post_hashtags 
JOIN hashtags ON post_hashtags.hashtag_id = hashtags.hashtag_id 
GROUP BY hashtag 
ORDER BY usage_count DESC 
LIMIT 10;

/* 4. Identify the Most Inactive User
Write a query to find users who have never made any posts on the
platform.
Hint: Use a subquery to identify these users.*/

SELECT user_id, username 
FROM users 
WHERE user_id NOT IN (SELECT DISTINCT user_id FROM posts);

/*5. Identify the Posts with the Most Likes
Write a query to find the posts that have received the highest number of
likes.
Hint: Count the number of likes for each post.*/

SELECT post_id, COUNT(like_id) AS like_count 
FROM likes 
GROUP BY post_id 
ORDER BY like_count DESC 
LIMIT 5;

/*6. Calculate Average Posts per User
Write a query to determine the average number of posts made by users.
Hint: Consider dividing the total number of posts by the number of unique users.*/

SELECT AVG(post_count) 
FROM (
    SELECT COUNT(post_id) AS post_count 
    FROM posts 
    GROUP BY user_id
) AS user_posts;

/* 7. Track the Number of Logins per User
Write a query to track the total number of logins made by each user.
Hint: Join user and login tables.*/

SELECT user_id, COUNT(login_id) AS total_logins 
FROM logins 
GROUP BY user_id;

/*8. Identify a User Who Liked Every Single Post
Write a query to find any user who has liked every post on the platform.
Hint: Compare the number of posts with the number of likes by this user.*/

SELECT user_id 
FROM likes 
GROUP BY user_id 
HAVING COUNT(DISTINCT post_id) = (SELECT COUNT(*) FROM posts);

/*9. Find Users Who Never Commented
Write a query to find users who have never commented on any post.
Hint: Use a subquery to exclude users who have commented.*/

SELECT user_id, username 
FROM users 
WHERE user_id NOT IN (SELECT DISTINCT user_id FROM comments);

/*10. Identify a User Who Commented on Every Post
Write a query to find any user who has commented on every post on the platform.
Hint: Compare the number of posts with the number of comments by this user.*/

SELECT user_id 
FROM comments 
GROUP BY user_id 
HAVING COUNT(DISTINCT post_id) = (SELECT COUNT(*) FROM posts);

/*11. Identify Users Not Followed by Anyone
Write a query to find users who are not followed by any other users.
Hint: Use the follows table to find users who have no followers.*/

SELECT user_id, username 
FROM users 
WHERE user_id NOT IN (SELECT followed_user_id FROM follows);

/* 12. Identify Users Who Are Not Following Anyone
Write a query to find users who are not following anyone.
Hint: Use the follows table to identify users who are not following others.*/

SELECT user_id, username 
FROM users 
WHERE user_id NOT IN (SELECT follower_user_id FROM follows);

/*13. Find Users Who Have Posted More than 5 Times
Write a query to find users who have made more than five posts.
Hint: Group the posts by user and filter the results based on the number of posts.*/

SELECT user_id, COUNT(post_id) AS post_count 
FROM posts 
GROUP BY user_id 
HAVING post_count > 5;

/*14. Identify Users with More than 40 Followers
Write a query to find users who have more than 40 followers.
Hint: Group the followers and filter the result for those with a high follower count.*/

SELECT followed_user_id, COUNT(follower_user_id) AS follower_count 
FROM follows 
GROUP BY followed_user_id 
HAVING follower_count > 40;

/*15. Search for Specific Words in Comments
Write a query to find comments containing specific words like "good" or "beautiful."
Hint: Use regular expressions to search for these words.*/

SELECT comment_id, comment_text 
FROM comments 
WHERE comment_text LIKE '%good%' OR comment_text LIKE '%beautiful%';

/*16. Identify the Longest Captions in Posts
Write a query to find the posts with the longest captions.
Hint: Calculate the length of each caption and sort them to find the top 5 longest ones.*/

SELECT post_id, caption, LENGTH(caption) AS caption_length
FROM posts
ORDER BY caption_length DESC
LIMIT 5;



