import Foundation

//연습 문제
//소수 판별

func isPrimeNumber(num : Int) -> () {
    for i in 2 ..< num {
        if (num % i == 0) {
            print("소수가 아닙니다.")
            return
        }
    }
    
    print("소수입니다.")
}

var inputData = Int(readLine()!)!
isPrimeNumber(num: inputData)
