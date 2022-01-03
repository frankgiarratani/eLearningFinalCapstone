INSERT INTO users (username,password_hash,role) VALUES ('user','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('admin','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_ADMIN');

INSERT INTO course (course_name, course_description, difficulty_level, course_cost) VALUES ('vampire: blood and empire', 'learn about Erzabet Bathory and Vlad Tzepez', 3, 658);
INSERT INTO course (course_name, course_description, difficulty_level, course_cost) VALUES ('intro to C++', 'learn the basics of programming', 3, 550);
INSERT INTO course (course_name, course_description, difficulty_level, course_cost) VALUES ('into to C#', 'how to be an inferior programmer', 1, 199);
INSERT INTO course (course_name, course_description, difficulty_level, course_cost) VALUES ('intro to English', 'generally the wrong decision', 2, 348);

INSERT INTO lesson (course_id, lesson_number, lesson_name, description) VALUES (1, 1, 'Gogol', 'read some Gogol');
INSERT INTO lesson (course_id, lesson_number, lesson_name, description) VALUES (1, 2, 'Tzepez', 'learn about Dracula');
INSERT INTO lesson (course_id, lesson_number, lesson_name, description) VALUES (2, 1, 'learn the basics of OOP', 'but regret it');
INSERT INTO lesson (course_id, lesson_number, lesson_name, description) VALUES (3, 1, 'basics of C#', 'maps are dictionaries');
INSERT INTO lesson (course_id, lesson_number, lesson_name, description) VALUES (4, 1, 'Chaucer', 'read the Decameron');
INSERT INTO lesson (course_id, lesson_number, lesson_name, description) VALUES (4, 2, 'Shakespeare', 'read the Tempest');

INSERT INTO assignments (course_id, lesson_number, lesson_name, description, possible_points, due_date) VALUES (1, 1, 'Gogol', 'write about Gogol', 10, '1/10/2022');
INSERT INTO assignments (course_id, lesson_number, lesson_name, description, possible_points, due_date) VALUES (1, 2, 'Tzepez', 'write about his dad', 10, '1/24/2022');
INSERT INTO assignments (course_id, lesson_number, lesson_name, description, possible_points, due_date) VALUES (2, 1, 'learn the basics of OOP', 'practice classes', 100, '1/10/2022');
INSERT INTO assignments (course_id, lesson_number, lesson_name, description, possible_points, due_date) VALUES (3, 1, 'basics of C#', 'practice dictionaries', 100, '1/12/20200');
INSERT INTO assignments (course_id, lesson_number, lesson_name, description, possible_points, due_date) VALUES (4, 1, 'Chaucer', 'write about the pot', 25, '1/15/2022');
INSERT INTO assignments (course_id, lesson_number, lesson_name, description, possible_points, due_date) VALUES (4, 2, 'Shakespeare', 'write about Caliban and Prospero', 25, '1/25/2020');




INSERT INTO student (student_id, student_name) VALUES (1, 'Nathan Wetzel');
INSERT INTO student (student_id, student_name) VALUES (2, 'William Szabo');
INSERT INTO student (student_id, student_name) VALUES (4, 'Frank Giarratani');
INSERT INTO student (student_id, student_name) VALUES (3, 'James McFadden');

INSERT INTO teacher (teacher_id, teacher_name) VALUES (5, 'Tom Anderson');
INSERT INTO teacher (teacher_id, teacher_name) VALUES (6, 'Tom Medvitz');