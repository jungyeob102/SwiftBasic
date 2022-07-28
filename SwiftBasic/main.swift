import Foundation

//연습 문제
//입력받은 문자열 중 랜덤의 문자를 출력하는 함수

@discardableResult
func randomCharacter(temp : String) -> Character {
//    let arrTemp = Array(temp)
//    let randomIndex = Int.random(in: 0 ..< arrTemp.count)
//    print(randomIndex)
//    
    let randomChar = temp.randomElement()!
    
    return randomChar
}

var inputData = readLine()!

print(randomCharacter(temp: inputData))
