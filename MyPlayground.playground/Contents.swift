import Foundation
import UIKit

class Person {
    
    init(age: Int, name: String) {
        self.age = age
        self.name = name
    }
    
    var age: Int
    var name: String
}

var person1: Person = Person(age: 10, name: "중엽")

var temp: Int = Int.random(in: 100 ... 200)

print(temp)

let unicodeScalarValue: String = "\u{2665}"
print(unicodeScalarValue)

var isSameString: Bool = false
