-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 20, 2022 at 08:23 AM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 7.4.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `students_club_management`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `calculate_club_anniversary` (IN `clubname` VARCHAR(255), OUT `anniversary` INT)   BEGIN 
	DECLARE uid varchar(255);
    DECLARE start_date date;
    SET uid = (SELECT club_name FROM club WHERE clubname = club.club_name);
    SET start_date = (SELECT club_start_date FROM club WHERE club.club_name=uid);
    SET anniversary = (SELECT datediff(CURRENT_DATE(),start_date)/365);
    IF uid != NUll THEN 
    	UPDATE club 
        SET Anniversary = @anniversary WHERE club_name=uid;
	END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `calculate_experience` (IN `ID` VARCHAR(255), OUT `experience` INT)   BEGIN 
	DECLARE uid varchar(255);
    DECLARE join_date date;
    SET uid = (SELECT fac_Id FROM faculty WHERE ID = faculty.fac_Id);
    SET join_date = (SELECT fac_join_date FROM faculty WHERE faculty.fac_Id=uid);
    SET experience = (SELECT datediff(CURRENT_DATE(),join_date)/365);
    IF uid != NUll THEN 
    	UPDATE faculty 
        SET fac_experience = @experience WHERE fac_Id=uid;
	END IF;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `No_of_events` (`clubName` VARCHAR(255)) RETURNS VARCHAR(255) CHARSET utf8mb4 DETERMINISTIC BEGIN
	DECLARE message varchar(255) ;
	DECLARE no_of_events int;
	SET no_of_events = (SELECT COUNT(*) from club_events where clubName=club_events.club_name);
	IF no_of_events>2 THEN
  		SET message = Concat('Number of events:',convert(no_of_events,char),',cannot organise more events');
	ELSE
    	SET message = Concat('Number of events:',convert(no_of_events,char),',can organise more events');
	END IF;
  	RETURN message;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `club`
--

CREATE TABLE `club` (
  `club_name` varchar(255) NOT NULL,
  `club_head` varchar(255) DEFAULT NULL,
  `club_capacity` int(11) DEFAULT NULL,
  `club_type` varchar(255) DEFAULT NULL,
  `club_coordinated_by` varchar(255) DEFAULT NULL,
  `club_start_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `club`
--

INSERT INTO `club` (`club_name`, `club_head`, `club_capacity`, `club_type`, `club_coordinated_by`, `club_start_date`) VALUES
('HackerSpace', 'PESSTU009', 2, 'Technical', 'Ross Geller', '2018-06-11'),
('Hashtag', 'PESSTU004', 3, 'Cultural', 'Raymond Holt', '2014-08-13'),
('Pixelloid', 'PESSTU006', 2, 'Photography', 'Amy', '2019-12-25'),
('Shunya', 'PESSTU002', 1, 'Mathematical', 'Natasha', '2015-04-09'),
('Swarantraka', 'PESSTU007', 2, 'Singing', 'Tsunade', '2016-08-30'),
('Zerospace', 'PESSTU003', 1, 'Technical', 'Kakashi', '2020-10-18');

-- --------------------------------------------------------

--
-- Table structure for table `club_events`
--

CREATE TABLE `club_events` (
  `event_name` varchar(255) NOT NULL,
  `event_location` varchar(255) DEFAULT NULL,
  `event_date` date DEFAULT NULL,
  `club_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `club_events`
--

INSERT INTO `club_events` (`event_name`, `event_location`, `event_date`, `club_name`) VALUES
('Aatmatrisha', 'Ring road', '2022-04-16', 'Shunya'),
('Avions', 'Yelahanka', '2022-02-25', 'Zerospace'),
('In-genius', 'Ring road', '2022-09-10', 'HackerSpace'),
('Maaya', 'Electronic City', '2022-11-12', 'Hashtag'),
('Shaken and stirred', 'Jayanagar', '2022-07-17', 'Swarantraka'),
('What-a-shot', 'Lal bagh', '2022-12-25', 'Pixelloid');

-- --------------------------------------------------------

--
-- Table structure for table `college`
--

CREATE TABLE `college` (
  `clg_name` varchar(255) NOT NULL,
  `clg_club_name` varchar(255) DEFAULT NULL,
  `event_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `college`
--

INSERT INTO `college` (`clg_name`, `clg_club_name`, `event_name`) VALUES
('BMS', 'tech', 'In-genius'),
('DSCE', 'singing', 'Shaken and stirred'),
('JSS', 'math', 'Maaya'),
('MSR', 'space', 'Avions'),
('RNSIT', 'dance', 'Maaya'),
('RVCE', 'photography', 'What-a-shot'),
('RVITM', 'hacking', 'In-genius');

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `course_name` varchar(255) DEFAULT NULL,
  `course_Id` varchar(255) NOT NULL,
  `dept_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`course_name`, `course_Id`, `dept_name`) VALUES
('Hydraulic Engineering', 'UE19CV301', 'Civil Engineerinng'),
('Aerodynamics', 'UE20AE101\r\n', 'Aeronautic engineering'),
('Avionics', 'UE20AE102', 'Aeronautic engineering'),
('Problem solving with C', 'UE20CS151', 'Computer Science Engineering'),
('Data Structures and Algorithms', 'UE20CS202', 'Computer Science Engineering'),
('Engineering Mechanics-Statics', 'UE20CV101', 'Civil Engineerinng'),
('Foundation in Electronic circuits', 'UE20EC101', 'Electronics and Communication Engineering'),
('Elements of Electrical Engineering', 'UE20EE101', 'Electronics and Communication Engineering'),
('Mechanical Engineering Sciences', 'UE20ME101', 'Mechanical Engineering'),
('Robotics', 'UE20ME202', 'Mechanical Engineering');

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `dept_name` varchar(255) NOT NULL,
  `dept_ID` varchar(11) DEFAULT NULL,
  `dept_capacity` int(11) DEFAULT NULL,
  `dept_chairperson` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`dept_name`, `dept_ID`, `dept_capacity`, `dept_chairperson`) VALUES
('Aeronautic engineering', 'PES005', 2, 'Professor Proton'),
('Civil Engineerinng', 'PES004', 2, 'Amy'),
('Computer Science Engineering', 'PES001', 2, 'Walter'),
('Electronics and Communication Engineering', 'PES002', 2, 'Ross Geller'),
('Mechanical Engineering', 'PES003', 2, 'Dr.stone');

-- --------------------------------------------------------

--
-- Table structure for table `emergency_contact`
--

CREATE TABLE `emergency_contact` (
  `emergency_name` varchar(255) DEFAULT NULL,
  `contact_info` bigint(10) NOT NULL,
  `relationship` varchar(255) DEFAULT NULL,
  `related_to` varchar(13) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `emergency_contact`
--

INSERT INTO `emergency_contact` (`emergency_name`, `contact_info`, `relationship`, `related_to`) VALUES
('Steve Rogers', 9564210654, 'Friend', 'PESSTU001'),
('Daenarys', 6178161801, 'Aunt', 'PESSTU002'),
('Missy', 7113220045, 'Sister', 'PESSTU003'),
('Joey', 8245007441, 'Friend', 'PESSTU004'),
('Sasuke', 6874650400, 'Brother', 'PESSTU005'),
('Jane', 7984804564, 'Friend', 'PESSTU006'),
('Ace', 9780004411, 'Brother', 'PESSTU007'),
('Charles ', 9870048940, 'Brother', 'PESSTU008'),
('Kushina', 8797070701, 'Mother', 'PESSTU009'),
('Mikkel Kahnwald', 6456006451, 'Father', 'PESSTU010');

-- --------------------------------------------------------

--
-- Table structure for table `faculty`
--

CREATE TABLE `faculty` (
  `fac_name` varchar(255) NOT NULL,
  `fac_Id` varchar(11) NOT NULL,
  `fac_join_date` date DEFAULT NULL,
  `dept_name` varchar(255) DEFAULT NULL,
  `salary` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `faculty`
--

INSERT INTO `faculty` (`fac_name`, `fac_Id`, `fac_join_date`, `dept_name`, `salary`) VALUES
('Dr.stone', 'PESFAC001', '2012-10-01', 'Mechanical Engineering', 100000),
('Natasha', 'PESFAC002', '2019-07-24', 'Electronics and Communication Engineering', 90000),
('Kakashi', 'PESFAC003', '2012-01-17', 'Computer Science Engineering', 120000),
('Amy', 'PESFAC004', '2021-12-15', 'Civil Engineerinng', 85000),
('Walter', 'PESFAC005', '2010-11-24', 'Computer Science Engineering', 150000),
('Professor Proton', 'PESFAC006', '2018-09-12', 'Aeronautic engineering', 105000),
('Raymond Holt', 'PESFAC007', '2021-12-15', 'Mechanical Engineering', 94000),
('Ross Geller', 'PESFAC008', '2020-08-10', 'Electronics and Communication Engineering', 90000),
('Jiraiya', 'PESFAC009', '2019-02-20', 'Aeronautic engineering', 98000),
('Tsunade', 'PESFAC010', '2022-06-11', 'Civil Engineerinng', 120106);

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `student_Id` varchar(13) NOT NULL,
  `student_name` varchar(255) DEFAULT NULL,
  `batch` int(4) DEFAULT NULL,
  `contact_no` bigint(10) DEFAULT NULL,
  `club_name` varchar(255) DEFAULT NULL,
  `dept_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`student_Id`, `student_name`, `batch`, `contact_no`, `club_name`, `dept_name`) VALUES
('PESSTU001', 'Tony stark', 2018, 9554234955, 'Hashtag', 'Computer Science Engineering'),
('PESSTU002', 'Jon snow', 2019, 8322111156, 'Shunya', 'Civil Engineerinng'),
('PESSTU003', 'Sheldon', 2019, 7156483213, 'Zerospace', 'Electronics and Communication Engineering'),
('PESSTU004', 'Chandler', 2019, 7645981652, 'Hashtag', 'Electronics and Communication Engineering'),
('PESSTU005', 'Itachi', 2019, 9659883213, 'Hashtag', 'Mechanical Engineering'),
('PESSTU006', 'Jesse Pinkman', 2020, 6760974501, 'Pixelloid', 'Computer Science Engineering'),
('PESSTU007', 'Luffy', 2020, 9814146544, 'Swarantraka', 'Civil Engineerinng'),
('PESSTU008', 'Jake ', 2020, 7168618682, 'Swarantraka', 'Electronics and Communication Engineering'),
('PESSTU009', 'Naruto', 2020, 6575768450, 'HackerSpace', 'Aeronautic engineering'),
('PESSTU010', 'Jonas Kahnwald', 2020, 7050365600, 'Pixelloid', 'Aeronautic engineering'),
('PESSTU011', 'Chota Bheem', 2019, 6624040461, 'HackerSpace', 'Aeronautic engineering');

--
-- Triggers `student`
--
DELIMITER $$
CREATE TRIGGER `updateClubCapacity` AFTER INSERT ON `student` FOR EACH ROW BEGIN
  UPDATE club
  SET club.club_capacity = club.club_capacity + 1
  WHERE club.club_name = New.club_name;
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `club`
--
ALTER TABLE `club`
  ADD PRIMARY KEY (`club_name`),
  ADD KEY `Club_head` (`club_head`),
  ADD KEY `Coordinated_by` (`club_coordinated_by`);

--
-- Indexes for table `club_events`
--
ALTER TABLE `club_events`
  ADD PRIMARY KEY (`event_name`),
  ADD KEY `club` (`club_name`);

--
-- Indexes for table `college`
--
ALTER TABLE `college`
  ADD PRIMARY KEY (`clg_name`),
  ADD KEY `event_name` (`event_name`);

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`course_Id`),
  ADD KEY `Dept` (`dept_name`);

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`dept_name`),
  ADD UNIQUE KEY `ID` (`dept_ID`),
  ADD KEY `Chairperson` (`dept_chairperson`);

--
-- Indexes for table `emergency_contact`
--
ALTER TABLE `emergency_contact`
  ADD KEY `key` (`related_to`),
  ADD KEY `related_to` (`related_to`);

--
-- Indexes for table `faculty`
--
ALTER TABLE `faculty`
  ADD PRIMARY KEY (`fac_Id`),
  ADD UNIQUE KEY `Name` (`fac_name`),
  ADD KEY `Department` (`dept_name`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`student_Id`),
  ADD KEY `Club` (`club_name`),
  ADD KEY `Dept` (`dept_name`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `club`
--
ALTER TABLE `club`
  ADD CONSTRAINT `club_ibfk_1` FOREIGN KEY (`Club_head`) REFERENCES `student` (`student_Id`),
  ADD CONSTRAINT `club_ibfk_2` FOREIGN KEY (`club_coordinated_by`) REFERENCES `faculty` (`fac_name`);

--
-- Constraints for table `club_events`
--
ALTER TABLE `club_events`
  ADD CONSTRAINT `club_events_ibfk_1` FOREIGN KEY (`club_name`) REFERENCES `club` (`club_name`);

--
-- Constraints for table `college`
--
ALTER TABLE `college`
  ADD CONSTRAINT `college_ibfk_1` FOREIGN KEY (`event_name`) REFERENCES `club_events` (`event_name`);

--
-- Constraints for table `courses`
--
ALTER TABLE `courses`
  ADD CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`dept_name`) REFERENCES `department` (`dept_name`);

--
-- Constraints for table `department`
--
ALTER TABLE `department`
  ADD CONSTRAINT `department_ibfk_1` FOREIGN KEY (`dept_chairperson`) REFERENCES `faculty` (`fac_name`);

--
-- Constraints for table `emergency_contact`
--
ALTER TABLE `emergency_contact`
  ADD CONSTRAINT `emergency_contact_ibfk_1` FOREIGN KEY (`related_to`) REFERENCES `student` (`student_Id`);

--
-- Constraints for table `faculty`
--
ALTER TABLE `faculty`
  ADD CONSTRAINT `faculty_ibfk_1` FOREIGN KEY (`dept_name`) REFERENCES `department` (`dept_name`);

--
-- Constraints for table `student`
--
ALTER TABLE `student`
  ADD CONSTRAINT `student_ibfk_1` FOREIGN KEY (`club_name`) REFERENCES `club` (`club_name`),
  ADD CONSTRAINT `student_ibfk_2` FOREIGN KEY (`dept_name`) REFERENCES `department` (`dept_name`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
