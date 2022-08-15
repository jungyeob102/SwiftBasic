import Foundation

var comChoice = Int.random(in: 1 ... 100)
var myChoice = 0

while true {
    let userInput = readLine()
    
    if let input = userInput {
        if let number = Int(input) {
            myChoice = number
        }
    }
    
    if comChoice > myChoice {
        print("up")
    }
    else if comChoice < myChoice {
        print("down")
    }
    else {
        print("bingo")
        break
    }
}
