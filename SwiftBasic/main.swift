import Foundation

//연습 문제
//팩토리얼

func factorial(_ num : Int) -> (Int) {
    print(num)
    if num <= 1 {
        return 1
    }
    return num * factorial(num - 1)
}

print(factorial(10))
