import Foundation

let numbers: [Int] = [0,1,2,3,4]

var doubleNumbers: [Int] = numbers.map({ (number: Int) -> Int in return number * 2})
print(doubleNumbers)

var doubleNumbers2: [Int] = numbers.map({return $0 * 2})
print(doubleNumbers2)

var doubleNumbers3: [Int] = numbers.map() {return $0 * 2}
print(doubleNumbers3)

var doubleNumbers4: [Int] = numbers.map() {$0 * 2}
print(doubleNumbers4)

var doubleNumbers5: [Int] = numbers.map{$0 * 2}
print(doubleNumbers5)
