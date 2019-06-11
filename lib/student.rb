class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.each {|attrib, value| self.send("#{attrib}=", value)}
      # :name => name,
      # :location => location,
      # :twitter => twitter,
      # :linkedin => linkedin,
      # :github => github,
      # :blog => blog,
      # :profile_quote => profile_quote,
      # :bio => bio,
      # :profile_url => profile_url
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each {|hash| Student.new(hash)}

  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |key, value|
      self.send("#{key}=", value)
    end

  end

  def self.all
    @@all
  end
end
