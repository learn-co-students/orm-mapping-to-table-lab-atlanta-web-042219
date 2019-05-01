# require "pry"

class Student
	attr_accessor :name, :grade

	def initialize(name, grade)
		@name = name
		@grade = grade
	end

	def self.create(name:, grade:)
		new_student = Student.new(name, grade)
		new_student.save
		new_student
	end

	def self.create_table
		DB[:conn].execute(%Q[
			CREATE TABLE IF NOT EXISTS students (
	        id INTEGER PRIMARY KEY, 
	        name TEXT, 
	        grade TEXT
	        )
	    ])
	end

	def self.drop_table
		DB[:conn].execute(%Q[DROP TABLE students])
	end

	def save
		DB[:conn].execute(%Q[INSERT INTO students (name, grade) VALUES(?, ?)], @name, @grade)
	end

	def id
		DB[:conn].execute(%Q[SELECT id FROM students where name = ?], @name).flatten[0]
	end

end
