class List
  attr_accessor :list

  def initialize
    @list = []
    File.read('./data').split("\n").each do |line|
      id, value = line.split(' - ')
      @list << {id: id, value: value}
    end
    list_all if ARGV[0] == 'list'
    add_task if ARGV[0] == 'add'
    delete_task if ARGV[0] == 'remove'
  end

  def list_all
    @list.each { |task| puts "#{task[:id]} - #{task[:value]}"}
  end

  def add_task
    task = { id: Time.now.to_i, value: ARGV[1..-1].join(' ') }
    @list << task
    self.save
  end

  def delete_task
    @list.delete_if do |item|
      ARGV[1] == item[:id]
    end
    self.save
  end

  def save
    File.open('./data', 'w') do |file|
      @list.each do |item|
        file.puts "#{item[:id]} - #{item[:value]}"
      end
    end
  end
end

List.new
