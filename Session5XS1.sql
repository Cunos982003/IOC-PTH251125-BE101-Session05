Set search_path to students;
CREATE TABLE students(
                         student_id SERIAL PRIMARY KEY,
                         full_name varchar(100),
                         major varchar(50)
);
CREATE TABLE courses(
                        course_id serial primary key ,
                        course_name varchar(100),
                        credit int
);
CREATE TABLE enrollments(
                            student_id int references students(student_id),
                            course_id int references courses(course_id),
                            score NUMERIC(5,2)
);

--ALIAS
SELECT
    s.full_name AS "Tên sinh viên",
    c.course_name AS "Môn học",
    e.score AS "Điểm"
FROM students AS s
         JOIN enrollments AS e ON s.student_id = e.student_id
         JOIN courses AS c ON c.course_id = e.course_id;
--Aggregate Functions
SELECT
    s.full_name AS "Tên sinh viên",
    AVG(e.score) AS "Điểm trung bình",
    MAX(e.score) AS "Điểm cao nhất",
    MIN(e.score) AS "Điểm thấp nhất"
FROM students s
         JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.full_name;
--GROUP BY / HAVING
SELECT
    s.major,
    AVG(e.score) AS avg_score
FROM students s
         JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.major
HAVING AVG(e.score) > 7.5;
--JOIN
SELECT s.student_id,s.full_name,s.major,c.credit,e.score
FROM students s join enrollments e on s.student_id = e.student_id
                join courses c on e.course_id = c.course_id;
--SUBQUERY
SELECT
    s.full_name,
    AVG(e.score) AS avg_score
FROM students s
         JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.full_name
HAVING AVG(e.score) > (
    SELECT AVG(score) FROM enrollments
);
--UNION
SELECT DISTINCT student_id
FROM enrollments
WHERE score >= 9

UNION

SELECT DISTINCT student_id
FROM enrollments;

--INTERSECT
SELECT DISTINCT student_id
FROM enrollments
WHERE score >= 9

INTERSECT

SELECT DISTINCT student_id
FROM enrollments;
