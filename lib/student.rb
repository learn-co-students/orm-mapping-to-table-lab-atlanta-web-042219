require 'pry'
class Student
  attr_accessor :name, :grade
  attr_reader :id
 
  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    query = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade INTEGER
    )
    SQL

    DB[:conn].execute(query)

  end

  def self.drop_table
    query = <<-SQL
    DROP TABLE students
    SQL

    DB[:conn].execute(query)

  end

  def save
    query = <<-SQL
    INSERT INTO students (name, grade)
    VALUES (?, ?)
    SQL

    DB[:conn].execute(query, self.name, self.grade)
    
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  def self.create(attributes)
    student = Student.new(attributes[:name], attributes[:grade])
    student.save
    student
  end



end
