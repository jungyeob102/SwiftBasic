import Foundation

//함수의 가변매개변수
func abc(numbers: Double...) {
    //가변 매개변수는 Array(배열) 형태로 저장 됨
    for number in numbers {
        print(number)
    }
}

//함수를 다른 변수에 담을 수 있음
var temp: (Double...) -> Void = abc(numbers:)
