require_relative './lib/hash_map'

hash_map = HashMap.new

hash_map.set("hola", "klok")
puts hash_map.get("hola")
