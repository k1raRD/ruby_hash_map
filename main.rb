require_relative 'lib/hash_map'

 test = HashMap.new

 test.set('apple', 'red')
 test.set('banana', 'yellow')
 test.set('carrot', 'orange')
 test.set('dog', 'brown')
 test.set('elephant', 'gray')
 test.set('frog', 'green')
 test.set('grape', 'purple')
 test.set('hat', 'black')
 test.set('ice cream', 'white')
 test.set('jacket', 'blue')
 test.set('kite', 'pink')
 test.set('lion', 'golden')
 test.set('moon', 'silver')
 test.set('newEntry', 'silver')
 test.set('anotherNewEntry', 'silver')

 puts test.get('apple')
 p test.keys
 p test.values
 p test.entries
 p test.has?('elephant')
 p test.has?('doesNotHaveThis')
 p test.remove('jacket')
 p test.has?('jacket')
 p test.get('jacket')
 p test.length
 p test.clear
 p test.length
