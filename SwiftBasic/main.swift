//
//  main.swift
//  SwiftBasic
//
//  Created by 이중엽 on 2022/07/23.
//

//import Foundation
import Foundation

let computerChoice: Int = Int.random(in: 1 ... 10)
let myChoice = Int(readLine()!)!

if (computerChoice > myChoice) {
    print("Up")
}
else if (computerChoice == myChoice) {
    print("Same")
}
else if (computerChoice < myChoice) {
    print("Down")
}
