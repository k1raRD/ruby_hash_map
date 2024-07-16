require_relative 'linked_list'

# Represents a HashMap
class HashMap
  def initialize
    @buckets = Array.new(16, nil)
    @load_factor = 0.75
  end

  def hash(key)
    hash_code = 0
    prime_number = 31
    key.each_char { |char| hash_code = (prime_number * hash_code) + char.ord }

    hash_code
  end

  def set(key, value)
    hash_key = hash(key) % @buckets.size

    @buckets[hash_key] = LinkedList.new if @buckets[hash_key].nil?
    @buckets[hash_key].prepend(key, value)
    growth_buckets
  end

  def get(key)
    hash_key = hash(key) % @buckets.size
    return nil if @buckets[hash_key].nil?

    index_key = @buckets[hash_key].find(key)
    @buckets[hash_key].at(index_key)&.value
  end

  def has?(key)
    !get(key).nil?
  end

  def remove(key)
    return nil unless has?(key)

    hash_key = hash(key) % @buckets.size
    index_key = @buckets[hash_key].find(key)
    puts index_key
    @buckets[hash_key].remove_at(index_key).value
  end

  def length
    @buckets.reduce(0) { |sum, bucket| sum + (bucket&.size || 0) }
  end

  def clear
    @buckets = Array.new(16, nil)
  end

  def keys
    keys = []
    @buckets.compact.each do |bucket|
      temp_bucket = bucket.clone
      stored_entry = temp_bucket.pop
      until stored_entry.nil?
        keys << stored_entry&.key
        stored_entry = temp_bucket.pop
      end
    end
    keys
  end

  def values
    values = []
    @buckets.compact.each do |bucket|
      temp_bucket = bucket.clone
      stored_entry = temp_bucket.pop
      until stored_entry.nil?
        values << stored_entry&.value
        stored_entry = temp_bucket.pop
      end
    end
    values
  end

  def entries
    entries = []
    @buckets.compact.each do |bucket|
      temp_bucket = bucket.clone
      stored_entry = temp_bucket.pop
      until stored_entry.nil?
        entry = [stored_entry.key, stored_entry&.value]
        entries << entry
        stored_entry = temp_bucket.pop
      end
    end
    entries
  end

  def size
    @buckets.size
  end

  private

  def buckets_in_use
    @buckets.compact.size
  end

  def growth_buckets
    buckets_limit = @buckets.size * @load_factor
    @buckets += Array.new(16) if buckets_limit.to_i <= buckets_in_use
  end
end
