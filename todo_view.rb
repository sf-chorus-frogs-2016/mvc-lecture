# View
# presenting our data to a human
class TodoListView
  def initialize(todo_list)
    @todo_list = todo_list
  end

  def to_s
    string = ''
    @todo_list.each do |item|
      string << "#{item[:id]} - #{item[:value]}\n"
    end
    string
  end
end
