BEGIN TRANSACTION;
DROP TABLE IF EXISTS users;
DROP SEQUENCE IF EXISTS seq_user_id;
CREATE SEQUENCE seq_user_id
  INCREMENT BY 1
  NO MAXVALUE
  NO MINVALUE
  CACHE 1;
CREATE TABLE users (
	user_id int DEFAULT nextval('seq_user_id'::regclass) NOT NULL,
	first_name varchar(50) NOT NULL,
	last_name varchar(50) NOT NULL,
	username varchar(50) NOT NULL,
	is_teacher BOOLEAN NOT NULL,
	password_hash varchar(200) NOT NULL,
	role varchar(50) NOT NULL,
	CONSTRAINT PK_user PRIMARY KEY (user_id)
);
CREATE TABLE courses (
        course_id SERIAL PRIMARY KEY,
        course_name CHARACTER VARYING(400) NOT NULL,
        course_description TEXT,
        difficulty_level INTEGER NOT NULL CHECK(difficulty_level BETWEEN 1 AND 5),
        course_cost NUMERIC
);
CREATE TABLE teachers (
        teacher_id SERIAL,
        user_id INTEGER,
        first_name CHARACTER VARYING(400),
        last_name CHARACTER VARYING(400),
        CONSTRAINT pk_teachers PRIMARY KEY (teacher_id),
        CONSTRAINT fk_users FOREIGN KEY (user_id) REFERENCES users (user_id)
);
CREATE TABLE students (
        student_id SERIAL,
        user_id INTEGER,
        first_name CHARACTER VARYING(400),
        last_name CHARACTER VARYING(400),
        CONSTRAINT pk_students PRIMARY KEY (student_id),
        CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users (user_id)
);
CREATE TABLE teacher_courses (
        teacher_id INTEGER,
        course_id INTEGER,
        CONSTRAINT pk_teacher_courses PRIMARY KEY (teacher_id, course_id),
        CONSTRAINT fk_teachers FOREIGN KEY (teacher_id) REFERENCES teachers (teacher_id),
        CONSTRAINT fk_courses FOREIGN KEY (course_id) REFERENCES courses (course_id)
);
CREATE TABLE student_courses (
        student_id INTEGER,
        course_id INTEGER,
        CONSTRAINT pk_student_courses PRIMARY KEY (student_id, course_id),
        CONSTRAINT fk_courses FOREIGN KEY (course_id) REFERENCES courses (course_id),
        CONSTRAINT fk_students FOREIGN KEY (student_id) REFERENCES students (student_id)
);
CREATE TABLE assignments (
        course_id INTEGER NOT NULL,
        assignment_id SERIAL,
        assignment_number INTEGER NOT NULL,
        assignment_name CHARACTER VARYING(400),
        description TEXT,
        possible_points INTEGER,
        due_date DATE,
        CONSTRAINT pk_assignments PRIMARY KEY (assignment_id),
        CONSTRAINT fk_courses FOREIGN KEY (course_id) REFERENCES courses (course_id)
);
CREATE TABLE lessons (
        course_id INTEGER NOT NULL,
        lesson_id SERIAL,
        lesson_number INTEGER,
        lesson_name CHARACTER VARYING(400),
        description TEXT,
        youtube_url VARCHAR(254),
        youtube_text TEXT,
        lesson_url1 VARCHAR(254),
        lesson_url2 VARCHAR(254),
        CONSTRAINT pk_lessons PRIMARY KEY (lesson_id),
        CONSTRAINT fk_courses FOREIGN KEY (course_id) REFERENCES courses (course_id)
);
CREATE TABLE student_assignments (
        student_id INTEGER,
        homework_id INTEGER,
        student_grade NUMERIC,
        possible_points INT,
        submission TEXT,
        teacher_feedback TEXT,
        submission_date_time TIMESTAMP,
        is_submitted boolean,
        is_graded boolean,
        CONSTRAINT pk_student_assignments PRIMARY KEY (student_id, homework_id),
        CONSTRAINT fk_students FOREIGN KEY (student_id) REFERENCES students (student_id),
        CONSTRAINT fk_assignments FOREIGN KEY (homework_id) REFERENCES assignments (assignment_id)
);
COMMIT TRANSACTION;
-- ALL TABLES INSERTED INTO DATABASE GO ABOVE THIS LINE
-- ALL DATA INSERTED INTO TABLES GOES BELOW THIS LINE
-- Insert Teachers & Admins
INSERT INTO users (username, first_name, last_name, is_teacher, password_hash, role) VALUES ('walt', 'Walt', 'Impellicceiri', true, '$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC', 'ROLE_ADMIN');
INSERT INTO users (username, first_name, last_name, is_teacher, password_hash, role) VALUES ('toma', 'Tom', 'Anderson', true, '$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC', 'ROLE_ADMIN');
INSERT INTO users (username, first_name, last_name, is_teacher, password_hash, role) VALUES ('tomm', 'Tom', 'Medvitz', true, '$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC', 'ROLE_ADMIN');
-- Insert Students
INSERT INTO users (username, first_name, last_name, is_teacher, password_hash, role) VALUES ('wszabo', 'Will', 'Szabo', false, '$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');
INSERT INTO users (username, first_name, last_name, is_teacher, password_hash, role) VALUES ('jmcfadden', 'James', 'McFadden', false, '$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC', 'ROLE_USER');
INSERT INTO users (username, first_name, last_name, is_teacher, password_hash, role) VALUES ('fgiarratani', 'Frank', 'Giarratani', false, '$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC', 'ROLE_USER');
INSERT INTO users (username, first_name, last_name, is_teacher, password_hash, role) VALUES ('nwetzel', 'Nathan', 'Wetzel', false, '$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC', 'ROLE_USER');
INSERT INTO users (username, first_name, last_name, is_teacher, password_hash, role) VALUES ('vmantena', 'Vineeth', 'Mantena', false, '$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC', 'ROLE_USER');
INSERT INTO users (username, first_name, last_name, is_teacher, password_hash, role) VALUES ('gross', 'Greg', 'Ross', false, '$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC', 'ROLE_USER');
INSERT INTO users (username, first_name, last_name, is_teacher, password_hash, role) VALUES ('dmay', 'Daniel', 'May', false, '$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC', 'ROLE_USER');
INSERT INTO users (username, first_name, last_name, is_teacher, password_hash, role) VALUES ('adeise', 'Alex', 'Deise', false, '$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC', 'ROLE_USER');
INSERT INTO users (username, first_name, last_name, is_teacher, password_hash, role) VALUES ('jsteele', 'Joshua', 'Steele', false, '$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC', 'ROLE_USER');
INSERT INTO users (username, first_name, last_name, is_teacher, password_hash, role) VALUES ('rjoseph', 'Reshmi', 'Joseph', false,  '$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC', 'ROLE_USER');
INSERT INTO users (username, first_name, last_name, is_teacher, password_hash, role) VALUES ('ndelozier', 'Nick', 'DeLozier', false, '$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC', 'ROLE_USER');
INSERT INTO users (username, first_name, last_name, is_teacher, password_hash, role) VALUES ('abafile', 'Alexandra', 'Bafile', false, '$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC', 'ROLE_USER');


-- Insert Courses
INSERT INTO courses (course_name, course_description, difficulty_level, course_cost) VALUES ('Blockchain Development', 'Demand for blockchain developers is skyrocketing. In this program, you will work with the Bitcoin and Ethereum protocols, build projects for real-world application, and gain the essential skills for a career in this dynamic space.', 3, 658);
INSERT INTO courses (course_name, course_description, difficulty_level, course_cost) VALUES ('Full Stack Web Development', 'Learn to design and develop powerful modern web applications that form the foundation for the apps, websites, and systems that people and businesses use every day.', 3, 550);
INSERT INTO courses (course_name, course_description, difficulty_level, course_cost) VALUES ('UX (User Experience) Design', 'Design impactful user experiences for products in todays digital world. Build a portfolio that showcases your ability to transform user research to high-fidelity interactive designs.', 1, 199);
INSERT INTO courses (course_name, course_description, difficulty_level, course_cost) VALUES ('Self-Driving Car Engineering', 'In this program, you will learn the techniques that power self-driving cars across the full stack of a vehicles autonomous capabilities. Using Deep Learning with radar and lidar sensor fusion, you will train the vehicle to detect and identify its surroundings to inform navigation.', 2, 348);
-- Insert lessons: Blockchain
INSERT INTO lessons (course_id, lesson_number, lesson_name, description,  youtube_url, youtube_text, lesson_url1, lesson_url2) VALUES (1, 1, 'Blockchain Fundamentals', 'Learn the basics of how the blockchain data model works by creating your own private blockchain using Node.js and Leveldb.', 'qOVAbKKSH10', 'This is the lesson for today', 'https://docs.google.com/document/d/1Ldk2PiwrRj3h2HpTAsm4lScfUHfpTXTGiBtE3gXLx3o/preview', null); 
INSERT INTO lessons (course_id, lesson_number, lesson_name, description,  youtube_url, youtube_text, lesson_url1, lesson_url2) VALUES (1, 2, 'Ethereum Smart Contracts, Tokens and Dapps', 'Advance your blockchain skillset to the second generation of blockchain services with smart contracts utilizing the Ethereum network.', 'M576WGiDBdQ', 'This is the lesson for today', 'https://docs.google.com/document/d/1FKyOU_8U-Gbbull3D3un-Navs3aevRVYxFlxMcSArOU/preview', 'https://docs.google.com/document/d/1u5CH2S4_Dx4LwrwrlsE1DLFwP7ugvCNMXZKrFfvzBKw/edit?usp=sharing');
INSERT INTO lessons (course_id, lesson_number, lesson_name, description,  youtube_url, youtube_text, lesson_url1, lesson_url2) VALUES (1, 3, 'Blockchain Architecture', 'Learn blockchain architecture and advanced concepts such as privacy, security and decentralized file management.', 'Wba_ZvpaJkk', 'This is the lesson for today', 'https://docs.google.com/document/d/1kFGzelJZ4HO8p1gltQ6HWcuMTLVYAja2kF-9p28TviY/preview', null);
INSERT INTO lessons (course_id, lesson_number, lesson_name, description,  youtube_url, youtube_text, lesson_url1, lesson_url2) VALUES (1, 4, 'Dapp with autonomous smart contracts and oracles', 'Advance your blockchain skill set by developing a decentralized application (Dapp) that will perform actions based on external triggers, and handle payments.', 'ooN6kZ9vqNQ', 'This is the lesson for today', 'https://docs.google.com/document/d/1GZqS0xq_1e-NDYF0TcEcx_BBbX0bUZrxKukc2EVI6Hc/preview', 'https://docs.google.com/document/d/1u5CH2S4_Dx4LwrwrlsE1DLFwP7ugvCNMXZKrFfvzBKw/edit?usp=sharing');
INSERT INTO lessons (course_id, lesson_number, lesson_name, description,  youtube_url, youtube_text, lesson_url1, lesson_url2) VALUES (1, 5, 'Blockchain Capstone Project', 'For your capstone project, youll use all the new skills youve acquired to build decentralized property listing application.', 'fCBu28JWOQY', 'This is the lesson for today', 'https://docs.google.com/document/d/1BcHoAPiLUhkh-IfMMMigeS_r0rs0KOANDseG-GjjExA/preview', null);
-- Insert lessons: Full Stack Web Development
INSERT INTO lessons (course_id, lesson_number, lesson_name, description, youtube_url, youtube_text, lesson_url1) VALUES (2, 1, 'SQL and Data Modeling for the Web', 'Master relational databases with the power of SQL, and leverage Python to incorporate database logic into your programs.', 'https://www.youtube.com/watch?v=HXV3zeQKqGY&ab_channel=freeCodeCamp.org', 'This is the lesson for today', 'https://docs.google.com/document/d/1BcHoAPiLUhkh-IfMMMigeS_r0rs0KOANDseG-GjjExA/edit?usp=sharing');
INSERT INTO lessons (course_id, lesson_number, lesson_name, description, youtube_url, youtube_text, lesson_url1) VALUES (2, 2, 'API Development and Documentation', 'Learn how to use APIs to control and manage web applications, including best practices for API testing and documentation.', 'https://www.youtube.com/watch?v=C_rkJRSlJS8&ab_channel=AutomationStepbyStep', 'This is the lesson for today', 'https://docs.google.com/document/d/1BcHoAPiLUhkh-IfMMMigeS_r0rs0KOANDseG-GjjExA/edit?usp=sharing');
INSERT INTO lessons (course_id, lesson_number, lesson_name, description, youtube_url, youtube_text, lesson_url1) VALUES (2, 3, 'Identity Access Management', 'Implement authentication and authorization in Flask and understand how to design against key security principle. You will also gain experience with role-based control design patterns, securing a REST API, and applying software system risk and compliance principles.', 'https://www.youtube.com/watch?v=7YcW25PHnAA&ab_channel=WebConcepts', 'This is the lesson for today', 'https://docs.google.com/document/d/1BcHoAPiLUhkh-IfMMMigeS_r0rs0KOANDseG-GjjExA/edit?usp=sharing');
INSERT INTO lessons (course_id, lesson_number, lesson_name, description, youtube_url, youtube_text, lesson_url1) VALUES (2, 4, 'Server Deployment and Containerization', 'Develop an understanding of containerized environments, use Docker to share and store containers, and deploy a Docker container to a Kubernetes cluster using AWS', 'https://www.youtube.com/watch?v=3c-iBn73dDE&ab_channel=TechWorldwithNana', 'This is the lesson for today', 'https://docs.google.com/document/d/1BcHoAPiLUhkh-IfMMMigeS_r0rs0KOANDseG-GjjExA/edit?usp=sharing');
-- Insert lessons: UX Design
INSERT INTO lessons (course_id, lesson_number, lesson_name, description, youtube_url, youtube_text, lesson_url1, lesson_url2) VALUES (3, 1, 'UX Fundamentals & Design Research', 'Product design starts with understanding the needs of users, which is gathered through comprehensive research. Learn the core principles of human-centered design and how to appropriately scope a design problem. Understand how to empathize with users when performing user research, including how to conduct in-depth interviews and create quantitative surveys, and use research data to uncover opportunities. Youll then apply psychology to design sketches, keeping the end-user in mind.', 'https://www.youtube.com/watch?v=BwrlR2mjgmI&ab_channel=SatoriGraphics', 'This is the lesson for toda', 'https://docs.google.com/document/d/1BcHoAPiLUhkh-IfMMMigeS_r0rs0KOANDseG-GjjExA/edit?usp=sharing', 'https://docs.google.com/document/d/1u5CH2S4_Dx4LwrwrlsE1DLFwP7ugvCNMXZKrFfvzBKw/edit?usp=sharing');
INSERT INTO lessons (course_id, lesson_number, lesson_name, description, youtube_url, youtube_text, lesson_url1) VALUES (3, 2, 'Concept to Low-Fidelity Prototyping', 'The best products have gone through rounds of iteration based on user research and feedback. Learn the process of a design sprint, and how to translate findings from research into a prototype that can be tested with users. Understand how to foster team collaboration and use divergent and convergent thinking to rapidly create testable prototypes. Apply user interface principles in the design of a clickable prototype, and conduct a usability test to gain valuable feedback from users that can be used in design iterations.', 'https://www.youtube.com/watch?v=Rnsk5lA52ps&ab_channel=DTAssoc', 'This is the lesson for today', 'https://docs.google.com/document/d/1BcHoAPiLUhkh-IfMMMigeS_r0rs0KOANDseG-GjjExA/edit?usp=sharing');
INSERT INTO lessons (course_id, lesson_number, lesson_name, description, youtube_url, youtube_text, lesson_url1) VALUES (3, 3, 'High-Fidelity Prototyping to Post-Launch Analysis', 'Once products have been tested for its effectiveness, they need to be enhanced for engagement. Learn advanced user interface principles to build interactive designs that are ready to be handed off to engineering for feedback. Understand how to solicit and integrate feedback from engineering to enhance the design before it is ready for development. Assess the engagement of the product through remote usability testing and other experimentation methods. Finally, youll learn how to improve design and user experiences based on engagement data in order to increase key performance indicators.', 'https://www.youtube.com/watch?v=SSo_EIwHSd4&ab_channel=SimplyExplained', 'This is the lesson for today', 'https://docs.google.com/document/d/1BcHoAPiLUhkh-IfMMMigeS_r0rs0KOANDseG-GjjExA/edit?usp=sharing');
INSERT INTO lessons (course_id, lesson_number, lesson_name, description, youtube_url, youtube_text, lesson_url1, lesson_url2) VALUES (3, 4, 'CAPSTONE - UX Portfolio Design', 'UX Designers demonstrate their skills by showcasing their designs and processes in a portfolio. Understand what should and shouldnt be included in a portfolio, as well as the key components that appeal to target audiences. Learn how to organize previous work and communicate it online, keeping the audience and your career objectives in mind. Apply storytelling and branding frameworks to create a personal profile that conveys a unique value proposition. Youll also learn best practices for maintaining and updating a UX portfolio.', 'https://www.youtube.com/watch?v=cYjVJZ6iPIw&ab_channel=CareerFoundry', 'This is the lesson for today', 'https://docs.google.com/document/d/1BcHoAPiLUhkh-IfMMMigeS_r0rs0KOANDseG-GjjExA/edit?usp=sharing', 'https://docs.google.com/document/d/1u5CH2S4_Dx4LwrwrlsE1DLFwP7ugvCNMXZKrFfvzBKw/edit?usp=sharing');
-- Insert lessons: Self Driving Cars
INSERT INTO lessons (course_id, lesson_number, lesson_name, description, youtube_url, youtube_text, lesson_url1) VALUES (4, 1, 'Computer Vision', 'In this lesson, you will develop critical Machine Learning skills that are commonly leveraged in autonomous vehicle engineering. You will learn about the life cycle of a Machine Learning project, from framing the problem and choosing metrics to training and improving models. This course will focus on the camera sensor and you will learn how to process raw digital images before feeding them into different algorithms, such as neural networks. You will build convolutional neural networks using TensorFlow and learn how to classify and detect objects in images. With this course, you will be exposed to the whole Machine Learning workflow and get a good understanding of the work of a Machine Learning Engineer and how it translates to the autonomous vehicle context.', '01sAkU_NvOY', 'This is the lesson for today', 'https://docs.google.com/document/d/1n0NJ-JPHbDwZEG8VeIku_s4jO8qgvyZTHZb3CcVPT1I/preview');
INSERT INTO lessons (course_id, lesson_number, lesson_name, description, youtube_url, youtube_text, lesson_url1) VALUES (4, 2, 'Sensor Fusion', 'In this lesson, you will learn about a key enabler for self-driving cars: sensor fusion. Besides cameras, self-driving cars rely on other sensors with complementary measurement principles to improve robustness and reliability. Therefore, you will learn about the lidar sensor and its role in the autonomous vehicle sensor suite. You will learn about the lidar working principle, get an overview of currently available lidar types and their differences, and look at relevant criteria for sensor selection. Also, you will learn how to detect objects such as vehicles in a 3D lidar point cloud using a deep-learning approach and then evaluate detection performance using a set of state-of-the-art metrics. In the second half of the course, you will learn how to fuse camera and lidar detections and track objects over time with an Extended Kalman Filter. You will get hands-on experience with multi-target tracking, where you will learn how to initialize, update and delete tracks, assign measurements to tracks with data association techniques and manage several tracks simultaneously. After completing the course, you will have a solid foundation to work as a sensor fusion engineer on self-driving cars.', 'PRg5RNU_JLk', 'This is the lesson for today', 'https://docs.google.com/document/d/13dedZXfBs_JJ474sOxkNPVh4o1PNApAcoUece9HMXzU/preview');
INSERT INTO lessons (course_id, lesson_number, lesson_name, description, youtube_url, youtube_text, lesson_url1) VALUES (4, 3, 'Localization', 'In this lesson, you will learn all about robotic localization, from one-dimensional motion models up to using three-dimensional point cloud maps obtained from lidar sensors. Youll begin by learning about the bicycle motion model, an approach to use simple motion to estimate location at the next time step, before gathering sensor data. Then, youll move onto using Markov localization in order to do 1D object tracking, as well as further leveraging motion models. From there, you will learn how to implement two scan matching algorithms, Iterative Closest Point (ICP) and Normal Distributions Transform (NDP), which work with 2D and 3D data. Finally, you will utilize these scan matching algorithms in the Point Cloud Library (PCL) to localize a simulated car with lidar sensing, using a 3D point cloud map obtained from the CARLA simulator.', 'qVyN_chiLeo', 'This is the lesson for today', 'https://docs.google.com/document/d/1OVbR3LSWw_wrwpH6RV9hu6ZT-xTDu3edtsMM4llgxNM/preview');
INSERT INTO lessons (course_id, lesson_number, lesson_name, description, youtube_url, youtube_text, lesson_url1) VALUES (4, 4, 'Planning', 'Path planning routes a vehicle from one point to another, and it handles how to react when emergencies arise. The Mercedes-Benz Vehicle Intelligence team will take you through the three stages of path planning. First, youll apply model-driven and data-driven approaches to predict how other vehicles on the road will behave. Then youll construct a finite state machine to decide which of several maneuvers your own vehicle should undertake. Finally, youll generate a safe and comfortable trajectory to execute that maneuver.', 'ixIoDYVfKA0', 'This is the lesson for today', 'https://docs.google.com/document/d/1DVMNSGl6rxxCFlAEmwLZTT7GK6_Z_GC5pUqLedm8WzA/preview');
INSERT INTO lessons (course_id, lesson_number, lesson_name, description, youtube_url, youtube_text, lesson_url1, lesson_url2) VALUES (4, 5, 'Control', 'This lesson will teach you how to control a car once you have a desired trajectory. In other words, how to activate the throttle and the steering wheel of the car to move it following a trajectory described by coordinates. The course will cover the most basic but also the most common controller: the Proportional Integral Derivative or PID controller. You will understand the basic principle of feedback control and how they are used in autonomous driving techniques.', 'XmjjmnDcduU', 'This is the lesson for today', 'https://docs.google.com/document/d/1BcHoAPiLUhkh-IfMMMigeS_r0rs0KOANDseG-GjjExA/edit?usp=sharing', 'https://docs.google.com/document/d/1u5CH2S4_Dx4LwrwrlsE1DLFwP7ugvCNMXZKrFfvzBKw/edit?usp=sharing');

-- Insert assignments
INSERT INTO assignments (course_id, assignment_number, assignment_name, description, possible_points, due_date) VALUES (1, 1, 'Create Your Own Private Blockchain', 'Create your own private blockchain as you learn to architect a blockchain data model. Your focus will be on the development of a private chain of blocks which is cryptographically secure and immutable.', 10, '1/10/2022');
INSERT INTO assignments (course_id, assignment_number, assignment_name, description, possible_points, due_date) VALUES (1, 2, 'Build CryptoStar Dapp on Ethereum', 'Build a decentralized app (Dapp) that allows you to create, sell, and transfer ownership of unique star token (CryptoStar) on the Ethereum blockchain using smart contracts and the non-fungible (ERC721) token standard', 10, '1/24/2022');
INSERT INTO assignments (course_id, assignment_number, assignment_name, description, possible_points, due_date) VALUES (1, 3, 'Ethereum Dapp for Tracking Items through Supply Chain', 'Learn how to manage and audit blockchain product ownership as the product is transferred down the supply chain. Improve your notarization service with a smart contract to support transferring of ownership, product auditing, and supply chain management.', 10, '1/15/2022');
INSERT INTO assignments (course_id, assignment_number, assignment_name, description, possible_points, due_date) VALUES (1, 4, 'Flight Delay Insurance Dapp', 'Learn to build a Dapp with multiple smart contracts which are autonomously triggered by external sources, and which handle payments based on flight delay scenarios.', 10, '1/15/2022');
INSERT INTO assignments (course_id, assignment_number, assignment_name, description, possible_points, due_date) VALUES (1, 5, 'Blockchain Capstone Project', 'In this project, you will represent your ownership of the property using ZK-SNARKs and then mint tokens to represent your claim to the property. You will then make these tokens available for sale on blockchain marketplace.', 10, '1/15/2022');
INSERT INTO assignments (course_id, assignment_number, assignment_name, description, possible_points, due_date) VALUES (2, 1, 'Design a Venue Booking Database', 'For your first project, youll be building out the data models and database for an artist/venue booking application. A prototype design of the web app will be provided. Youll use SQLAlchemy and Postgresql to build out the data models upon which this site will rely. Youll write out both the raw SQL and SQLAlchemy commands to run for powering the backend functionality of the website.', 100, '1/10/2022');
INSERT INTO assignments (course_id, assignment_number, assignment_name, description, possible_points, due_date) VALUES (2, 2, 'Trivia API', 'In this project, you will use the skills youve developed to build a Trivia API. You will use APIs to control and manage a web application using existing data models. Youll be given a set of data models and the application front end. Your task will be to implement the API in Flask to make the Trivia game functional.', 100, '1/30/2022');
INSERT INTO assignments (course_id, assignment_number, assignment_name, description, possible_points, due_date) VALUES (2, 3, 'Coffee Shop Full Stack', 'The goal is to build the backend for a coffee shop application. Youll add user accounts and authentication to your application and use role-based access management strategies to control different types of user behavior in the app.', 100, '2/14/2022');
INSERT INTO assignments (course_id, assignment_number, assignment_name, description, possible_points, due_date) VALUES (2, 4, 'Deploy a Flask App to Kubernetes Using EKS', 'In this project, you will create a container for your Flask web app using Docker and deploy the container to a Kubernetes cluster using Amazon EKS. By the end of the project, you will have deployed your application live to the world, where it should be accessible by IP address. Youll use automated testing to prevent bad code from being deployed and monitor your apps performance using AWS tools.', 100, '2/28/2022');
INSERT INTO assignments (course_id, assignment_number, assignment_name, description, possible_points, due_date) VALUES (2, 5, 'Full Stack Web Developer Nanodegree Program Capstone', 'In this final capstone project, you will combine all of the new skills youve learned and developed in this course to construct a database-backed web API with user access control. You will choose what app to build and then youll design and build out all of the API endpoints needed for the application and properly secure them for use in any front end application (web or mobile).', 100, '3/10/2022');
INSERT INTO assignments (course_id, assignment_number, assignment_name, description, possible_points, due_date) VALUES (3, 1, 'Formulate a Research Report', 'The first step to designing a great product is empathizing with users and uncovering their needs. In this project, you will develop a discussion guide, recruit research participants, and synthesize findings in the form of a research report. Youll validate your insights from interviews using surveys to get a comprehensive view of the topic you are researching. The goal of this project is to ask the right questions when interviewing users to understand their experiences in order to identify design opportunities, and create initial sketches that incorporate design psychology principles.', 100, '1/12/2020');
INSERT INTO assignments (course_id, assignment_number, assignment_name, description, possible_points, due_date) VALUES (3, 2, 'Develop a Validated Low-Fidelity Prototype', 'Insights from research are inputs to the design sprint process of creating a validated design solution. In this project, you will take a product idea through the design sprint process to come up with a user-tested low-fidelity prototype of your solution. First, youll set up the infrastructure to start the design sprint and synthesize research findings. Then, youll go through ideation exercises to create paper sketches, and digital prototypes based off the paper sketches. Lastly, youll conduct a usability test of your prototype with users to validate design assumptions, and create a second iteration of the prototype based on user feedback.', 100, '1/12/2020');
INSERT INTO assignments (course_id, assignment_number, assignment_name, description, possible_points, due_date) VALUES (3, 3, 'Create and Improve a High-Fidelity Design', 'A low-fidelity prototype allows you to validate that the core functionality of your solution addresses user needs, and the next step is to ensure the interface and experience of your solution engages and delights users as much as possible. In this project, youll enhance a low-fidelity prototype through the application of a data-enhanced high-fidelity design by submitting a midterm and a final project. For the midterm project, youll source visual design inspiration to develop a style guide and component library. Then, youll use the style guide and component library to create a high-fidelity mockup of your low-fidelity prototype. For the final project, youll improve the accessibility of your design and iterate the design based on engagement data and key performance indicators.', 100, '1/12/2020');
INSERT INTO assignments (course_id, assignment_number, assignment_name, description, possible_points, due_date) VALUES (3, 4, 'Build a UX Portfolio Case Study', 'A UX portfolio is the tool that UX Designers use to display their abilities and experience to the world. In this project, you will apply portfolio design and personal branding best practices to create a starter portfolio that consists of projects completed in this Nanodegree program. First, youll reflect and document the process you went through to complete your projects. Then, youll organize assets and notes in a way that visualizes the steps you took to complete these projects. Lastly, youll develop an accompanying About Me page that conveys what makes you unique as a UX professional.', 100, '1/12/2020');
INSERT INTO assignments (course_id, assignment_number, assignment_name, description, possible_points, due_date) VALUES (4, 1, 'Object Detection in an Urban Environment', 'In this project, students will create a convolutional neural network to detect and classify objects using data from the Waymo Open Dataset. Students will be provided with a dataset of images of urban environments containing annotated cyclists, pedestrians and vehicles. First, they will perform an extensive data analysis including the computation of label distributions, display of sample images, and checking for object occlusions. Students will use this analysis to decide what augmentations are meaningful for this project. Then, they will train a neural network to detect and classify objects. Students will monitor the training with TensorBoard and decide when to end it. Finally, they will experiment with different hyperparameters to improve performance.', 10, '1/15/2022');
INSERT INTO assignments (course_id, assignment_number, assignment_name, description, possible_points, due_date) VALUES (4, 2, '3D Object Detection', 'Students will first load and preprocess 3D lidar point clouds, and then use a deep learning approach to detect and classify objects (e.g. vehicles, pedestrians). Students will evaluate and visualize the objects, including calculating key performance metrics. This project combines with the Sensor Fusion project to form a full detection pipeline.', 10, '1/15/2022');
INSERT INTO assignments (course_id, assignment_number, assignment_name, description, possible_points, due_date) VALUES (4, 3, 'Scan Matching Localization', 'In this project, students will use either ICP or NDT, two scan matching algorithms, to align point cloud scans from the CARLA simulator and recover the position of a simulated car with lidar. Students will need to achieve sufficient accuracy for the entirety of a drive within the simulated environment, updating the vehicles location appropriately as it moves and obtains new lidar data.', 10, '1/15/2022');
INSERT INTO assignments (course_id, assignment_number, assignment_name, description, possible_points, due_date) VALUES (4, 4, 'Motion Planning and Decision Making for Autonomous Vehicles', 'In this project, you will implement two of the main components of a traditional hierarchical planner: the behavior planner and the motion planner. Both will work in unison to be able to avoid static objects parked on the side of the road, avoid crashing with these vehicles by executing either a nudge or a lane change maneuver, handle any type of intersection, and track the centerline on the traveling lane.', 10, '1/15/2022');
INSERT INTO assignments (course_id, assignment_number, assignment_name, description, possible_points, due_date) VALUES (4, 5, 'Control and Trajectory Tracking for Autonomous Vehicles', 'In this project, you will apply the skills you have acquired in this course to design a PID controller to perform vehicle trajectory tracking. Given a trajectory as an array of locations, and a simulation environment, you will design and code a PID controller and test its efficiency on the CARLA simulator used in the industry. This project will help you to understand the power and the limitations of the PID controller and how feedback control is used in practice. Finally, this project is a good training for C++ coding which is the language used in the industry.', 10, '1/15/2022');




--Insert teachers
INSERT INTO teachers (user_id, first_name, last_name) VALUES (1, 'Walt', 'Impellicceiri');
INSERT INTO teachers (user_id, first_name, last_name) VALUES (2, 'Tom', 'Anderson');
INSERT INTO teachers (user_id, first_name, last_name) VALUES (3, 'Tom', 'Medvitz');
--Insert Students
INSERT INTO students (user_id, first_name, last_name) VALUES (4, 'Will', 'Szabo');
INSERT INTO students (user_id, first_name, last_name) VALUES (5, 'James', 'McFadden');
INSERT INTO students (user_id, first_name, last_name) VALUES (6, 'Frank', 'Giarratani');
INSERT INTO students (user_id, first_name, last_name) VALUES (7, 'Nathan', 'Wetzel');
INSERT INTO students (user_id, first_name, last_name) VALUES (8, 'Vineeth', 'Mantena');
INSERT INTO students (user_id, first_name, last_name) VALUES (9, 'Greg', 'Ross');
INSERT INTO students (user_id, first_name, last_name) VALUES (10, 'Daniel', 'May');
INSERT INTO students (user_id, first_name, last_name) VALUES (11, 'Alex', 'Deise');
INSERT INTO students (user_id, first_name, last_name) VALUES (12, 'Joshua', 'Steele');
INSERT INTO students (user_id, first_name, last_name) VALUES (13, 'Reshmi', 'Joseph');
INSERT INTO students (user_id, first_name, last_name) VALUES (14, 'Nick', 'DeLozier');
INSERT INTO students (user_id, first_name, last_name) VALUES (15, 'Alexandra', 'Bafile');

--Insert teacher courses
INSERT INTO teacher_courses (teacher_id, course_id) VALUES (1, 1);
INSERT INTO teacher_courses (teacher_id, course_id) VALUES (2, 2);
INSERT INTO teacher_courses (teacher_id, course_id) VALUES (3, 3);
INSERT INTO teacher_courses (teacher_id, course_id) VALUES (3, 4);
--Insert student courses
INSERT INTO student_courses (student_id, course_id) VALUES (1, 1);
INSERT INTO student_courses (student_id, course_id) VALUES (1, 4);
INSERT INTO student_courses (student_id, course_id) VALUES (2, 2);
INSERT INTO student_courses (student_id, course_id) VALUES (2, 3);
INSERT INTO student_courses (student_id, course_id) VALUES (3, 3);
INSERT INTO student_courses (student_id, course_id) VALUES (3, 4);
INSERT INTO student_courses (student_id, course_id) VALUES (4, 1);
INSERT INTO student_courses (student_id, course_id) VALUES (4, 3);
INSERT INTO student_courses (student_id, course_id) VALUES (5, 2);
INSERT INTO student_courses (student_id, course_id) VALUES (5, 4);
INSERT INTO student_courses (student_id, course_id) VALUES (6, 1);
INSERT INTO student_courses (student_id, course_id) VALUES (6, 4);
INSERT INTO student_courses (student_id, course_id) VALUES (7, 3);
INSERT INTO student_courses (student_id, course_id) VALUES (8, 4);
INSERT INTO student_courses (student_id, course_id) VALUES (9, 1);
INSERT INTO student_courses (student_id, course_id) VALUES (9, 2);
INSERT INTO student_courses (student_id, course_id) VALUES (9, 3);
INSERT INTO student_courses (student_id, course_id) VALUES (10, 1);
INSERT INTO student_courses (student_id, course_id) VALUES (10, 4);
INSERT INTO student_courses (student_id, course_id) VALUES (11, 2);
INSERT INTO student_courses (student_id, course_id) VALUES (11, 3);
INSERT INTO student_courses (student_id, course_id) VALUES (12, 2);
INSERT INTO student_courses (student_id, course_id) VALUES (12, 3);



--Insert student assignments
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, is_submitted, is_graded) VALUES (2, 1, null, 10, null, CURRENT_TIMESTAMP, true, false);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, is_submitted, is_graded)VALUES (2, 2, null, 10, null, null, false, false);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded)VALUES (3, 4, 80, 100, null, 'well formulated.', CURRENT_TIMESTAMP, true, true);


INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded) VALUES (1, 1, 3, 10, 'https://docs.google.com/document/d/1f-fY8I5eYuSTf_FJ7DTzpDdiiM5en7F-Mqpog3ZONJ0/edit', 'Try doing the reading before class', CURRENT_TIMESTAMP, true, true);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded) VALUES (1, 2, 9, 10, 'https://docs.google.com/document/d/1f-fY8I5eYuSTf_FJ7DTzpDdiiM5en7F-Mqpog3ZONJ0/edit', 'You are really going places, kid!', CURRENT_TIMESTAMP, true, true);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded) VALUES (1, 3, null, 10, 'https://docs.google.com/document/d/1f-fY8I5eYuSTf_FJ7DTzpDdiiM5en7F-Mqpog3ZONJ0/edit', null, CURRENT_TIMESTAMP, true, false);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded) VALUES (1, 4, null, 10, null, null, CURRENT_TIMESTAMP, false, false);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded) VALUES (1, 5, null, 10, null, null, CURRENT_TIMESTAMP, false, false);


INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded)VALUES (4, 1, 7, 10, 'https://docs.google.com/document/d/1imV_lourf5z7uwV4w8Pc0FEs_GYXCJ2xnp3gB3oRkmI/edit', '7 out of 10 isnt bad but I think you can do better', CURRENT_TIMESTAMP, true, true);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded)VALUES (4, 2, 9, 10, 'https://docs.google.com/document/d/1imV_lourf5z7uwV4w8Pc0FEs_GYXCJ2xnp3gB3oRkmI/edit', '9 out of 10, that is more like it', CURRENT_TIMESTAMP, true, true);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded)VALUES (4, 3, 2, 10, 'https://docs.google.com/document/d/1imV_lourf5z7uwV4w8Pc0FEs_GYXCJ2xnp3gB3oRkmI/edit', 'did you even try at all?', CURRENT_TIMESTAMP, true, true);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded)VALUES (4, 4, null, 10, null, null, CURRENT_TIMESTAMP, false, false);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded)VALUES (4, 5, null, 10, null, null, CURRENT_TIMESTAMP, false, false);

INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded)VALUES (6, 1, 9, 10, 'https://docs.google.com/document/d/1Pj6lL8euMEfLkt79bAaXSzbyU-iP6jUjWBCCYmzGo6I/edit', 'All you did was copy the first hit on google into a document.', CURRENT_TIMESTAMP, true, true);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded)VALUES (6, 2, 7, 10, null, null, CURRENT_TIMESTAMP, false, false);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded)VALUES (6, 3, null, 10, null, null, CURRENT_TIMESTAMP, false, false);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded)VALUES (6, 4, null, 10, null, null, CURRENT_TIMESTAMP, false, false);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded)VALUES (6, 5, null, 10, null, null, CURRENT_TIMESTAMP, false, false);

INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded)VALUES (9, 1, 6, 10, 'https://docs.google.com/document/d/1ABxX7yj_g-bvxN1tL3rGl9E1n1ytqdi9n0sCmTGyOWE/edit', 'All you did was copy the first hit on google into a document. Get it together, ya bum!', CURRENT_TIMESTAMP, true, true);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded)VALUES (9, 2, 8, 10, 'https://docs.google.com/document/d/1ABxX7yj_g-bvxN1tL3rGl9E1n1ytqdi9n0sCmTGyOWE/edit', 'Good work. ', CURRENT_TIMESTAMP, true, true);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded)VALUES (9, 3, null, 10, 'https://docs.google.com/document/d/1ABxX7yj_g-bvxN1tL3rGl9E1n1ytqdi9n0sCmTGyOWE/edit', null, CURRENT_TIMESTAMP, true, false);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded)VALUES (9, 4, null, 10, null, null, CURRENT_TIMESTAMP, false, false);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded)VALUES (9, 5, null, 10, null, null, CURRENT_TIMESTAMP, false, false);

INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded)VALUES (10, 1, 10, 10, 'https://docs.google.com/document/d/1tqH8hFkDuIDMte6N09r1a9DYRvRFfWz2uaXT3iJkM74/edit', '10 out of 10 on the first assignment. Wow.', CURRENT_TIMESTAMP, true, true);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded)VALUES (10, 2, 10, 10, 'https://docs.google.com/document/d/1tqH8hFkDuIDMte6N09r1a9DYRvRFfWz2uaXT3iJkM74/edit', 'Stellar work', CURRENT_TIMESTAMP, true, true);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded)VALUES (10, 3, null, 10, 'https://docs.google.com/document/d/1tqH8hFkDuIDMte6N09r1a9DYRvRFfWz2uaXT3iJkM74/edit', null, CURRENT_TIMESTAMP, true, false);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded)VALUES (10, 4, null, 10, null, null, CURRENT_TIMESTAMP, false, false);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded)VALUES (10, 5, null, 10, null, null, CURRENT_TIMESTAMP, false, false);

INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded) VALUES (1, 15, 6, 10, 'https://docs.google.com/document/d/1zN8XdWEhjLH7HvBdgQxY_hEyOmM79BJXc4W9bRsC1LY/edit', 'Nice work', CURRENT_TIMESTAMP, true, true);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded) VALUES (3, 15, 9, 10, 'https://docs.google.com/document/d/1zN8XdWEhjLH7HvBdgQxY_hEyOmM79BJXc4W9bRsC1LY/edit', 'Super duper!', CURRENT_TIMESTAMP, true, true);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded) VALUES (5, 15, 7, 10, 'https://docs.google.com/document/d/1zN8XdWEhjLH7HvBdgQxY_hEyOmM79BJXc4W9bRsC1LY/edit', 'See me after class.', CURRENT_TIMESTAMP, true, true);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded) VALUES (6, 15, 4, 10, 'https://docs.google.com/document/d/1zN8XdWEhjLH7HvBdgQxY_hEyOmM79BJXc4W9bRsC1LY/edit', 'Do you need some help?', CURRENT_TIMESTAMP, true, true);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded) VALUES (8, 15, null, 10, 'https://docs.google.com/document/d/1zN8XdWEhjLH7HvBdgQxY_hEyOmM79BJXc4W9bRsC1LY/edit', null, CURRENT_TIMESTAMP, true, false);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded) VALUES (10, 15, null, 10, null, null, CURRENT_TIMESTAMP, false, false);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded) VALUES (1, 16, 10, 10, 'https://docs.google.com/document/d/1zN8XdWEhjLH7HvBdgQxY_hEyOmM79BJXc4W9bRsC1LY/edit', 'See me after class.', CURRENT_TIMESTAMP, true, true);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded) VALUES (3, 16, 8, 10, 'https://docs.google.com/document/d/1zN8XdWEhjLH7HvBdgQxY_hEyOmM79BJXc4W9bRsC1LY/edit', 'Good effort.', CURRENT_TIMESTAMP, true, true);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded) VALUES (5, 16, 7, 10, 'https://docs.google.com/document/d/1zN8XdWEhjLH7HvBdgQxY_hEyOmM79BJXc4W9bRsC1LY/edit', 'See me after class.', CURRENT_TIMESTAMP, true, true);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded) VALUES (6, 16, 5, 10, 'https://docs.google.com/document/d/1zN8XdWEhjLH7HvBdgQxY_hEyOmM79BJXc4W9bRsC1LY/edit', 'You only did half of the assignment', CURRENT_TIMESTAMP, true, true);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded) VALUES (8, 16, null, 10, 'https://docs.google.com/document/d/1zN8XdWEhjLH7HvBdgQxY_hEyOmM79BJXc4W9bRsC1LY/edit', null, CURRENT_TIMESTAMP, true, false);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded) VALUES (10, 16, null, 10, null, null, CURRENT_TIMESTAMP, false, false);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded) VALUES (1, 17, 2, 10, 'https://docs.google.com/document/d/1zN8XdWEhjLH7HvBdgQxY_hEyOmM79BJXc4W9bRsC1LY/edit', 'What happened?', CURRENT_TIMESTAMP, true, true);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded) VALUES (3, 17, 5, 10, 'https://docs.google.com/document/d/1zN8XdWEhjLH7HvBdgQxY_hEyOmM79BJXc4W9bRsC1LY/edit', 'Noice!', CURRENT_TIMESTAMP, true, true);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded) VALUES (5, 17, 10, 10, 'https://docs.google.com/document/d/1zN8XdWEhjLH7HvBdgQxY_hEyOmM79BJXc4W9bRsC1LY/edit', 'You are going places, kid!', CURRENT_TIMESTAMP, true, true);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded) VALUES (6, 17, null, 10, 'https://docs.google.com/document/d/1zN8XdWEhjLH7HvBdgQxY_hEyOmM79BJXc4W9bRsC1LY/edit', null, CURRENT_TIMESTAMP, true, false);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded) VALUES (8, 17, null, 10, 'https://docs.google.com/document/d/1zN8XdWEhjLH7HvBdgQxY_hEyOmM79BJXc4W9bRsC1LY/edit', null, CURRENT_TIMESTAMP, true, false);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded) VALUES (10, 17, null, 10, null, null, CURRENT_TIMESTAMP, false, false);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded) VALUES (1, 18, null, 10, null, null, CURRENT_TIMESTAMP, false, false);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded) VALUES (3, 18, null, 10, null, null, CURRENT_TIMESTAMP, false, false);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded) VALUES (5, 18, null, 10, null, null, CURRENT_TIMESTAMP, false, false);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded) VALUES (6, 18, null, 10, null, null, CURRENT_TIMESTAMP, false, false);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded) VALUES (8, 18, null, 10, null, null, CURRENT_TIMESTAMP, false, false);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded) VALUES (10, 18, null, 10, null, null, CURRENT_TIMESTAMP, false, false);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded) VALUES (1, 19, null, 10, null, null, CURRENT_TIMESTAMP, false, false);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded) VALUES (3, 19, null, 10, null, null, CURRENT_TIMESTAMP, false, false);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded) VALUES (5, 19, null, 10, null, null, CURRENT_TIMESTAMP, false, false);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded) VALUES (6, 19, null, 10, null, null, CURRENT_TIMESTAMP, false, false);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded) VALUES (8, 19, null, 10, null, null, CURRENT_TIMESTAMP, false, false);
INSERT INTO student_assignments (student_id, homework_id, student_grade, possible_points, submission, teacher_feedback, submission_date_time, is_submitted, is_graded) VALUES (10, 19, null, 10, null, null, CURRENT_TIMESTAMP, false, false);

