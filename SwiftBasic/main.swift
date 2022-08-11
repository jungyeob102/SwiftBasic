import Foundation

var arrTemp: Array<Int> = [1,2,3,4,5,6]
let temp = arrTemp.sorted{ $0 > $1 }


func makeIncrementer(forIncrement amount: Int) -> (() -> Int) {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

let incrementByTwo: (() -> Int) = makeIncrementer(forIncrement: 2)

let first: Int = incrementByTwo()
print(first)

let second: Int = incrementByTwo()
print(second)

//클로저와 함수는 참조 타입!
//따라서 클로저와 함수를 담은 상수 또는 변수를 다른 상수 또는 변수에 할당한다면 두 상수가 모두 같은 클로저 또는 함수를 가리킨다.
