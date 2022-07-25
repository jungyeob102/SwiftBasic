//
//  main.swift
//  SwiftBasic
//
//  Created by 이중엽 on 2022/07/23.
//

//import Foundation
import Foundation

var isDone: Bool = true

while isDone {
    
    let input = readLine()!
    let temp = Int(input)
//    let computer: Int = Int.random(in: 0 ... 2)
    
    if (temp == 0) {
        print("바위")
        isDone = false
    }
    else if (temp == 1) {
        print("가위")
        isDone = false
    }
    else if (temp == 2) {
        print("보")
        isDone = false
    }
    else {
        print("일치하지 않습니다.")
    }
}
