require_relative 'node'

# Represent a LinkedList data structure
class LinkedList
  attr_reader :head, :tail, :size

  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def prepend(key, value)
    new_node = Node.new(key, value, @head)
    @head = new_node
    @tail = new_node if @tail.nil?
    @size += 1
  end

  def append(value)
    new_node = Node.new(key, value)
    @head = new_node if @head.nil?
    @tail = new_node
    @size += 1
  end

  def at(index)
    return nil if index.nil? || index > size

    current_node = @head
    index.times do
      current_node = current_node.next_node
    end
    current_node
  end

  def pop
    return nil if size < 1

    current_node = @head
    while current_node && current_node.next_node != @tail
      current_node = current_node.next_node
    end
    deleted_node = @tail
    @tail = current_node
    deleted_node
  end

  def contains?(key)
    current_node = @head
    contains = false
    until current_node.nil?
      contains = true if current_node.key == key
      current_node = current_node.next_node
    end
    contains
  end

  def find(key)
    current_node = @head
    index = 0
    found = false
    until current_node.nil?
      found = true if current_node.key == key
      current_node = current_node.next_node
      index += 1 unless found
    end
    index if found
  end

  def insert_at(key, value, index)
    raise ArgumentError.new('Error: you selected an index outside of the list.') if index > size

    if index.zero?
      prepend(key, value)
    else
      new_node = Node.new(key, value, at(index))
      prev_node = at(index - 1)
      prev_node.next_node = new_node
      @tail = new_node if new_node.next_node.nil?
    end
  end

  def remove_at(index)
    raise ArgumentError.new('Error: you selected an index outside of the list.') if (index > size || index.nil?)

    node_deleted = at(index)
    if size == 1
      clear
    elsif index.zero?
      @head = at(1)
    elsif at(index) == @tail
      @tail = at(index - 1)
      @tail.next_node = nil
    else
      prev_node = at(index - 1)
      prev_node.next_node = at(index + 1)
    end
    node_deleted
  end

  def to_s
    current_node = @head
    until current_node.nil?
      print "(#{current_node.key}: #{current_node.value}) -> "
      current_node = current_node.next_node
    end
    print 'nil'
  end

  private

  def clear
    @head.next_node = nil
    @tail.next_node = nil
    @head = nil
    @tail = nil
  end
end
