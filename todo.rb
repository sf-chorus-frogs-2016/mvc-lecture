# Model
# saving and loading
# adding and removing
# persisting our data
# dealing with business logic around our data
class TodoList
  def initialize
    @list = []
  end

  def each
    @list.each { |item| yield(item) }
  end

  def add(value)
    @list << {
      id: generate_unique_id,
      value: value
    }
  end

  def remove(item_id)
    @list.delete_if do |item|
      item[:id] == item_id
    end
  end

  def save
    File.open('./data', 'w') do |file|
      @list.each do |item|
        file.puts "#{item[:id]} - #{item[:value]}"
      end
    end
  end

  def load
    @list = []
    File.read('./data').split("\n").each do |line|
      id, value = line.split(' - ')
      @list << { id: id, value: value }
    end
  end

  private

  def generate_unique_id
    Time.now.to_i
  end
end
