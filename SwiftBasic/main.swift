import Foundation

//연습 문제
//팩토리얼

func factorial(_ num : Int) -> (Int) {

    var result = 1

    for i in 1 ... num {
        result *= i
    }
    
    return result
}

print(factorial(5))
