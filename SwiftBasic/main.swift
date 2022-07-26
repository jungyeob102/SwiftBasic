import Foundation

//Boj 1157
let temp = readLine()!
let arrTemp = Array(temp.uppercased())
let length = arrTemp.count

//알파벳을 담을 빈 문자 배열 생성
var arrAlphabet = [Character]()
//알파벳의 갯수를 저장하는 빈 배열 생성
var arrResult = [Int]()

//대문자 아스키 코드 넘버 입력
for i in 65 ... 90 {
    //아스키 넘버 -> 문자 타입로 변경하여 데이터 저장
    let alphabet = Character(UnicodeScalar(i)!)
    
    //문자 배열에 추가
    arrAlphabet.append(alphabet)
    arrResult.append(0)
}

//알파벳 배열을 돌면서 동일한 문자가 있으면, 알파벳의 갯수를 1씩 증가시켜서 저장
for i in 0 ..< length {
    let temp = arrTemp[i]

    for j in 0 ..< arrAlphabet.count {
        if temp == arrAlphabet[j] {
            arrResult[j] += 1
        }
    }
}

var maxCount: Int = 0
var maxIndex: Int = 0
for i in 0 ..< arrResult.count {
    if maxCount < arrResult[i] {
        // 가장 많이 카운트 된 수를 저장
        maxCount = arrResult[i]
        
        // 가장 많이 카운트 된 수의 인덱스 넘버를 저장
        maxIndex = i
    }
}

//최대값이 중복되는지 체크
var reduplicationCount = 0
var isReduplication = false
for i in 0 ..< arrResult.count {
    if maxCount == arrResult[i] {
        reduplicationCount += 1
        
        if reduplicationCount > 1 {
            isReduplication = true
        }
    }
}

//최대값이 중복이라면 ? 출력, 그 외에는 최대값을 가진 알파벳 출력
if (isReduplication == true) {
    print("?")
} else {
    print(arrAlphabet[maxIndex])
}
