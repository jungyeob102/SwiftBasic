
import Foundation

/*
 이 전화 키패드에서 왼손과 오른손의 엄지손가락만을 이용해서 숫자만을 입력하려고 합니다.
 맨 처음 왼손 엄지손가락은 * 키패드에 오른손 엄지손가락은 # 키패드 위치에서 시작하며, 엄지손가락을 사용하는 규칙은 다음과 같습니다.
 엄지손가락은 상하좌우 4가지 방향으로만 이동할 수 있으며 키패드 이동 한 칸은 거리로 1에 해당합니다.
 왼쪽 열의 3개의 숫자 1, 4, 7을 입력할 때는 왼손 엄지손가락을 사용합니다.
 오른쪽 열의 3개의 숫자 3, 6, 9를 입력할 때는 오른손 엄지손가락을 사용합니다.
 가운데 열의 4개의 숫자 2, 5, 8, 0을 입력할 때는 두 엄지손가락의 현재 키패드의 위치에서 더 가까운 엄지손가락을 사용합니다.
 4-1. 만약 두 엄지손가락의 거리가 같다면, 오른손잡이는 오른손 엄지손가락, 왼손잡이는 왼손 엄지손가락을 사용합니다.
 순서대로 누를 번호가 담긴 배열 numbers, 왼손잡이인지 오른손잡이인 지를 나타내는 문자열 hand가 매개변수로 주어질 때, 각 번호를 누른 엄지손가락이 왼손인 지 오른손인 지를 나타내는 연속된 문자열 형태로 return 하도록 solution 함수를 완성해주세요.

 [제한사항]
 numbers 배열의 크기는 1 이상 1,000 이하입니다.
 numbers 배열 원소의 값은 0 이상 9 이하인 정수입니다.
 hand는 "left" 또는 "right" 입니다.
 "left"는 왼손잡이, "right"는 오른손잡이를 의미합니다.
 왼손 엄지손가락을 사용한 경우는 L, 오른손 엄지손가락을 사용한 경우는 R을 순서대로 이어붙여 문자열 형태로 return 해주세요.
 */
import Foundation

func makeTuple(_ num: Int) -> (Int,Int) {
//    0,1,2,0,1,2
    let x: Int = (num - 1) % 3
    let y: Int = (num - 1) / 3
    
    let result: (Int, Int) = (y,x)
    return result
}

//(0,0) (0,1) (0,2)
//(1,0) (1,1) (1,2)
//(2,0) (2,1) (2,2)
//(3,0) (3,1) (3,2)

func checkHand(_ lastNum: inout Int, _ hand:String, _ leftPos: inout Int, _ rightPos: inout Int) -> Character {
    
    let left = makeTuple(leftPos)
    let right = makeTuple(rightPos)
    let currPos = makeTuple(lastNum)
    
    let distanceLeft: Int = abs((left.0 - currPos.0) + (left.1 - currPos.1))
    let distanceRight: Int = abs((right.0 - currPos.0) + (right.1 - currPos.1))
    
    if distanceLeft < distanceRight {
        leftPos = lastNum
        return "L"
    }
    else if distanceRight < distanceLeft {
        rightPos = lastNum
        return "R"
    }
    else {
        if hand == "right" {
            rightPos = lastNum
            return "R"
        }
        else {
            leftPos = lastNum
            return "L"
        }
    }
}

func solution(_ numbers:[Int], _ hand:String) -> String {
    var result: Array<Character> = []
    var lastLeftPos: Int = 10
    var lastRightPos: Int = 12
    var currPos: Int
    
    for idx in 0 ..< numbers.count {
        currPos = numbers[idx]
        
        //왼손 사용
        if numbers[idx] == 1 || numbers[idx] == 4 || numbers[idx] == 7 {
            result.append("L")
            lastLeftPos = numbers[idx]
        }
        //오른손 사용
        else if numbers[idx] == 3 || numbers[idx] == 6 || numbers[idx] == 9 {
            result.append("R")
            lastRightPos = numbers[idx]
        }
        else {
            let temp: Character = checkHand(&currPos, hand, &lastLeftPos, &lastRightPos)
            result.append(temp)
        }
    }

    return String(result)
}

let testNunbers = [1, 3, 4, 5, 8, 2, 1, 4, 5, 9, 5]
let testHand = "right"

print(solution(testNunbers, testHand))
