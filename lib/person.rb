class Person
  attr_reader :family_name
  attr_reader :first_name
  attr_reader :birthday

  def initialize(family_name:, first_name:, gender:, birthday:)
    raise ArgumentError unless [:male, :female].include? gender
    raise ArgumentError if family_name.to_s =~ /\A\s*\z/
    raise ArgumentError if first_name.to_s =~ /\A\s*\z/
    @family_name = family_name.to_s
    @first_name = first_name.to_s
    @gender = gender
    @birthday = birthday
  end

  def full_name
    "#{family_name}#{first_name}"
  end

  def male?
    @gender == :male
  end

  def female?
    !male?
  end

  def can_marry?(person)
    self.male? != person.male?
  end
end
