-- CBT System Database Schema
-- Updated: Feb 13, 2026
--
-- Default Credentials:
--   Admin  => username: admin | password: admin123
--   Staff  => username: admin | password: staff123
--

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hynitr_cbt`
--

-- --------------------------------------------------------

--
-- Table structure for table `login`
-- password   = used by Staff panel login (staff/functions/functions.php)
-- admpword   = used by Admin panel login (admin/functions/functions.php)
--

CREATE TABLE IF NOT EXISTS `login` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `school` text NOT NULL,
  `username` text NOT NULL,
  `password` text NOT NULL,
  `admpword` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Default login credentials
-- Admin  password: admin123  (MD5: 0192023a7bbd73250516f069df18b500)
-- Staff  password: staff123  (MD5: de9bf5643eabf80f4a56fda3bbb84483)
--

INSERT INTO `login` (`id`, `school`, `username`, `password`, `admpword`) VALUES
(1, 'CBT System', 'admin', 'de9bf5643eabf80f4a56fda3bbb84483', '0192023a7bbd73250516f069df18b500');

-- --------------------------------------------------------

--
-- Table structure for table `timer`
-- Stores exam configuration per subject
--

CREATE TABLE IF NOT EXISTS `timer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subject` text NOT NULL,
  `hour` text NOT NULL,
  `min` text NOT NULL,
  `attempt` int(10) NOT NULL,
  `instruct` text NOT NULL,
  `acesscode` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Sample exam configuration
--

INSERT INTO `timer` (`id`, `subject`, `hour`, `min`, `attempt`, `instruct`, `acesscode`) VALUES
(1, 'sample_exam', '0', '30', 10, '<p>Attempt all questions. No going back once you submit.</p>', 'cbtexam');

-- --------------------------------------------------------

--
-- Table structure for table `result`
-- Stores student exam results
--

CREATE TABLE IF NOT EXISTS `result` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stud_id` text NOT NULL,
  `names` text NOT NULL,
  `subject` text NOT NULL,
  `year` year(4) NOT NULL,
  `tstart` text NOT NULL,
  `score` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `student`
-- Registered students (exam ID + name)
--

CREATE TABLE IF NOT EXISTS `student` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `examid` text NOT NULL,
  `name` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Sample students
--

INSERT INTO `student` (`id`, `examid`, `name`) VALUES
(1, 'STU001', 'John Doe'),
(2, 'STU002', 'Jane Smith');

-- --------------------------------------------------------

--
-- Sample subject table: `sample_exam`
-- Each exam subject gets its own table with this structure
--

CREATE TABLE IF NOT EXISTS `sample_exam` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `sn` text DEFAULT NULL,
  `question` text DEFAULT NULL,
  `oa` text DEFAULT NULL,
  `ob` text DEFAULT NULL,
  `oc` text DEFAULT NULL,
  `od` text DEFAULT NULL,
  `correct` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Sample questions
--

INSERT INTO `sample_exam` (`id`, `sn`, `question`, `oa`, `ob`, `oc`, `od`, `correct`) VALUES
(1, '1', 'What does CBT stand for?', 'Computer Based Training', 'Computer Based Test', 'Central Board of Testing', 'Certified Board Test', 'Computer Based Test'),
(2, '2', 'Which language is used for web development?', 'Python', 'Java', 'PHP', 'All of the above', 'All of the above'),
(3, '3', 'What does HTML stand for?', 'Hyper Text Markup Language', 'High Tech Modern Language', 'Hyper Transfer Markup Language', 'Home Tool Markup Language', 'Hyper Text Markup Language'),
(4, '4', 'Which of these is a database system?', 'Apache', 'MySQL', 'Bootstrap', 'jQuery', 'MySQL'),
(5, '5', 'What does CSS stand for?', 'Computer Style Sheets', 'Creative Style System', 'Cascading Style Sheets', 'Colorful Style Sheets', 'Cascading Style Sheets');

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
