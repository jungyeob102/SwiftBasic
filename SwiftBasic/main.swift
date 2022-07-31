import Foundation

var isBreak: Bool = true
while isBreak {
    let input: String = readLine()!
    
    if Int(input) != nil {
        let result: Int = Int(input)!
    
        if result == 0 {
            print("바위")
            isBreak = false
        }
        else if result == 1 {
            print("가위")
            isBreak = false
        }
        else if result == 2 {
            print("보")
            isBreak = false
        }
        else {
            print("다시 입력하시오.")
        }
    }
    else {
        print("숫자를 입력해주세요.")
    }
}
