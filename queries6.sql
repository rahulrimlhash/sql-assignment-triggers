USE School;
CREATE TABLE teachers (
  id INT PRIMARY KEY,
  name VARCHAR(50),
  subject VARCHAR(50),
  experience INT,
  salary DECIMAL(10, 2)
);

INSERT INTO teachers (id, name, subject, experience, salary)
VALUES
  (1, 'Anusha', 'Chemistry', 3, 50000.00),
  (2, 'Aoarna', 'Mathematics', 5, 60000.00),
  (3, 'Rahul', 'Physics', 4, 45000.00),
  (4, 'Jazzim', 'Biology', 1, 40000.00),
  (5, 'Kiran', 'Geography',4 ,55000.00),
  (6, 'Sara', 'Art', 4, 48000.00),
  (7, 'Fahad', 'Music', 8, 35000.00),
  (8, 'Asif', 'Biology', 6, 52000.00);

DELIMITER //

CREATE TRIGGER before_insert_teacher
BEFORE INSERT ON teachers
FOR EACH ROW
BEGIN
  IF NEW.salary < 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Salary cannot be negative';
  END IF;
END;
//

DELIMITER ;


DELIMITER //
CREATE TRIGGER after_insert_teacher
AFTER INSERT ON teachers
FOR EACH ROW
BEGIN
  INSERT INTO teacher_log (teacher_id, action, timestamp)
  VALUES (NEW.id, 'Inserted', NOW());
END;
//

DELIMITER ;


DELIMITER //
CREATE TRIGGER before_delete_teacher
BEFORE DELETE ON teachers
FOR EACH ROW
BEGIN
  IF OLD.experience > 10 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete teacher with experience greater than 10 years';
  END IF;
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER after_delete_teacher
AFTER DELETE ON teachers
FOR EACH ROW
BEGIN
  INSERT INTO teacher_log (teacher_id, action, timestamp)
  VALUES (OLD.id, 'Deleted', NOW());
END;
//
DELIMITER ;




