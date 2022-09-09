import UIKit

/*==========================================================
 [문제 1번]
 (String, Int, Int) 타입으로 된 튜플을 변수 person이 있다.
 각 타입의 별칭은 각각 name, age, year으로 임시 값은 "홍길동", 100, 1900 이다.
 튜플 형태 변수 pesron을 생성하여 해당 변수에 담겨있는 데이터에 각각 접근하여 출력하시오.
============================================================*/

// 주석을 해제 후 입력해주세요.
var person: (name: String, age: Int, year: Int) = ("홍길동", 100, 1900)

//별표를 지우고 알맞은 답을 입력해주세요.
print("이룸: \(person.name), 나이: \(person.age), 출생년도: \(person.year)")





/*==========================================================
 [문제 2번]
 반복문 for문과 while문을 자유롭게 사용하여 tempArray의 원소를 모두
 출력하시오.
 MARK: 단, 출력하는 순서는 상관 없음
============================================================*/

var tempArray: Array<Int> = [1,2,3,4,5,6,7,8,9,10]

//for문 작성
for i in tempArray {
    print(i)
}

//while문 작성
while tempArray.isEmpty == false {
    let lastIndex = tempArray.count - 1
    print(tempArray[lastIndex])
    
    tempArray.remove(at: lastIndex)
}







/*==========================================================
 [문제 3번]
 배열과 딕셔너리, 세트의 차이점을 자유롭게 작성하시오.
============================================================*/

/*
배열
 - 순서가 정해져있다.
 - 동일한 타입만 저장이 가능하다.
 - index가 존재한다.
 - 중복 가능하다.
 
딕셔너리
 - 순서가 정해져있지 않다. -> index가 없음
 - 키와 값으로 이루어져있다.
 - 키값은 유일해야 하기 때문에 중복이 될 수 없다.
 
세트
 - 순서가 정해져있지 않다. -> index가 없음
 - 키값으로만 이루어져있다.
 - 중복없이 한번만 저장되어야 하는 데이터들을 다룰 때 사용한다.
 
 */




/*==========================================================
 [문제 4번]
 제곱을 나타나는 사용자 정의 연산자를 생성하려고 한다. 해당 연산자는 전위 연산자로
 **기호를 사용한다. ** 전위 연산자를 정의하여 sqrtNum이 100이 출력되록 하시오.
============================================================*/

//전위 연산자를 구현하시오.
prefix operator **

prefix func ** (value: Int) -> Int {
    return value * value
}

let sqrtNum = **10
print(sqrtNum)





/*==========================================================
 [문제 5번]
 클래스를 비교하는 연산자는 따로 존재하지 않는다. 이를 해결하기 위하여 Student
 클래스에는 == 연산자를 사용자 정의로 생성하려고 한다. == 연산자는 중위 연산자로
 각 Student 인스턴스의 classNum이 동일한지 판단하여 일치하면 true를 다르면
 false를 리턴한다.
 
 중위 연산자를 정의하고 print( Lee == Kim )가 true가 나오도록 하시오.
============================================================*/
class Student {
    let classNum: Int
    let name: String
    
    init (classNum: Int, name: String) {
        self.classNum = classNum
        self.name = name
    }
}

let Lee: Student = Student(classNum: 1, name: "Lee")
let Kim: Student = Student(classNum: 1, name: "Kim")

infix operator ==

func == (lhs: Student, rhs: Student) -> Bool {
    print("구현됐습니다.")
    return lhs.classNum == rhs.classNum
}

print( Lee == Kim )





/*==========================================================
 [문제 6번]
 배열에서, 배열의 요소를 교체할 수 있는 방법은 다양하다. 이 중 서브스크립트와
 정식 문법을 사용하여 배열 내 ["A", "B", "C"]를 ["a", "b", "c"]로
 교체하시오.
============================================================*/

// 1. 서브 스크립트
var alphabetArr: Array<String> = ["A", "B", "C", "D", "E", "F"]
alphabetArr[0...2] = ["a", "b" ,"c"]

print(alphabetArr)

// 2. 정식 문법
var alphabetArr2: Array<String> = ["A", "B", "C", "D", "E", "F"]
alphabetArr2.replaceSubrange( 0...2 , with: ["a", "b", "c"])

print(alphabetArr2)





/*==========================================================
 [문제 7번]
 변수 pie는 원주율을 배열로 하나씩 20개를 담고 있다. 배열 pie에서 마지막에 있는
 9의 인덱스를 구해서 해당 배열에서 삭제하시오.
============================================================*/

var pie = [3,1,4,1,5,9,2,6,5,3,5,8,9,7,9,3,2,3,8]

if let index = pie.lastIndex(of: 9) {
    print(index)
    pie.remove(at: index)
}

print(pie)





/*==========================================================
 [문제 8번]
 Time 클래스는 시간을 관리하는 클래스로 여러개 인스턴스가 필요하지 않다. 그렇기 때문에
 우리는 Time이라는 클래스를 유일한 객체인 싱글톤으로 생성하려고 한다. 아래 Tiem을
 싱글톤으로 정의하고 실제로 currentTime을 사용하시오.
============================================================*/
class Time {
//    static let shared = Time()
//
    func currentTime() -> () {
        print(Date())
    }

    private init() {}
}






/*==========================================================
 [문제 9번]
 Company 열거형에는 google, meta, apple 케이스가 존재하며, 각 케이스는
 원시값이 존재한다. 원시값을 이용하여 apple 케이스를 저장하고 있는 변수 temp를
 생성하시오.
============================================================*/
enum Company: String {
    case google =   "구글"
    case meta =     "메타"
    case apple =    "애플"
}

let temp = Company.init(rawValue: "애플")



/*==========================================================
 [문제 10번]
 numbers 배열은 Optional Int 타입으로 사이마다 nil이 저장되어 있다.
 numbers를 for문으로 돌아 원소마다 접근하여 switch문으로 값이 들어있으면 해당 값을
 출력하고, 값이 없으면 "nil"을 출력하시오.
============================================================*/
var numbers: [Int?] = [1, nil, 2, nil, 3, nil, 4, nil, 5]

for i in numbers {
    switch i {
    case .some:
        print(i!)
    case .none:
        print("nil")
    }
}




/*==========================================================
 [문제 11번]
 문제 10번의 numbers는 Optional Int 타입이기 때문에 각 원소에 접근할 때 마다
 언래핑 과정을 거쳐야 한다. 이러한 번거러움을 줄이기 위하여 numbers2라는 배열을
 생성했다. 해당 numbers2 는 numbers에서 nil값을 제외한 순수한 Int 타입의
 배열이다.
 numbers2를 numbers 배열을 이용하여 Int 타입의 배열로 다시 정리하여 출력하시오.
============================================================*/


let numbers2 = numbers.compactMap { $0 }

print(numbers2)
