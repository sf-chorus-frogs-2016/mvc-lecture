
# Controller
# take a request, handle it, and respond
class Controller
  def initialize
    load_todo_list
  end

  def run_command(command, argument)
    if self.respond_to?(command)
      argument == '' ? send(command) : send(command, argument)
    else
      puts "unknown command #{command} with argument #{argument}"
    end
  rescue ArgumentError
    puts "improper argument #{argument} for command #{command}"
  end

  # the list action
  def list
    render_todo_list
  end

  def add(todo_list_item_value)
    @todo_list.add(todo_list_item_value)
    @todo_list.save
    render_todo_list
  end

  def remove(item_id)
    @todo_list.remove(item_id)
    @todo_list.save
    render_todo_list
  end

  def help
    actions = self.class.instance_methods(false).reject do |action|
      [:run_command, :help].include? action
    end
    actions.each do |action|
      puts action.to_s
    end
  end

  private

  def load_todo_list
    @todo_list = TodoList.new
    @todo_list.load
  end

  def render_todo_list
    puts TodoListView.new(@todo_list)
  end
end
