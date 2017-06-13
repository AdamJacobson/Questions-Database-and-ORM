require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class User
  attr_accessor :id, :fname, :lname

  def self.find_by_id(id)
    user = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL

    User.new(user.first)
  end

  def self.find_by_name(fname, lname)
    user = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?
    SQL

    User.new(user.first)
  end

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end
end


class Question
  attr_accessor :id, :title, :body, :user_id

  def self.find_by_id(id)
    rows = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?
    SQL

    Question.new(rows.first)
  end

  def self.find_by_author_id(user_id)
    rows = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        questions
      WHERE
        user_id = ?
    SQL

    rows.map { |row| Question.new(row) }
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @user_id = options['user_id']
  end
end


class Reply
  attr_accessor :id, :question_id, :parent_id, :user_id, :body

  def self.find_by_id(id)
    rows = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL

    Reply.new(rows.first)
  end

  def self.find_by_user_id(user_id)
    rows = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = ?
    SQL

    rows.map { |row| Reply.new(row) }
  end

  def self.find_by_question_id(question_id)
    rows = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?
    SQL

    rows.map { |row| Reply.new(row) }
  end

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @parent_id = options['parent_id']
    @user_id = options['user_id']
    @body = options['body']
  end
end
