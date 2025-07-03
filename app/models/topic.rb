class Topic
  attr_accessor :id, :name, :posts

  def initialize(id:, name:)
    @id = id
    @name = name
    @posts = []
  end
end
