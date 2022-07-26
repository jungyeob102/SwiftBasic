//
//  main.swift
//  SwiftBasic
//
//  Created by 이중엽 on 2022/07/23.
//

//import Foundation
import Foundation

//문자열 배열로 변경
//1. 배열 생성 후 append 이용

//문자 입력받기
let alphabet = readLine()!

//문자 배열 생성 (빈 값)
var arr = [Character]()

//반복문을 통한 문자 입력
for i in alphabet {
    arr.append(i)
}
