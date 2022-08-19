import Foundation


/*============================================
 값 타입 vs 참조 타입
============================================*/

//값타입
struct UserStruct {
    var id: String

    init(id: String) {
        self.id = id
    }
    
    mutating func changeID(newID: String) {
        self.id = newID
    }
}

//참조타입
class UserClass {
    var id: String

    init(id: String) {
        self.id = id
    }
    
    func changeID(newID: String) {
        print("호출 됐어욤")
        self.id = newID
    }
}

class UserData: UserClass {
    
    override func changeID(newID: String) {
        print(newID)
    }
}

let temp: UserData = UserData(id: "234")
temp.changeID(newID: "123")


/*============================================
 클래스 상속
============================================*/

class Human {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        print("human init 1단계")
        self.name = name
        self.age = age
    }
}

class Student: Human {
    //저장 프로퍼티
    var grade: Int?
    var major: String
    
    //연산 프로퍼티
    var info: Int? {
        get {
            return grade == nil ? 10 : self.grade
        }
        set {
            self.grade = newValue
        }
    }
    
    //지정 초기자(init)
    init(name: String, age: Int, grade: Int?) {
        print("student init 1단계")
        // 자식 클래스의 인스턴스 프로퍼티의 값이 할당되기 이전에 부모 클래스의 init을 호출할 수 없음
        self.grade = grade == nil ? 10 : grade
        self.major = "asdf"
        super.init(name: name, age: age)
        
        print("student init 2단계")
        self.info = 5
        self.call()
    }
    
    //이름을 제외한 모든 값들을 기본값(Default)으로 설정해주고 싶을 때 사용하는 convenience init
    //편의 초기자(conveience init)
    convenience init(name: String, major: String) {
        print("conveience init 1단계")
        
        // self.init에서 덮어 씌워지기 때문에 안됨
//        self.major = major
        self.init(name: name, age: 8, grade: 1)
        
        print("conveience init 2단계")
        self.major = major
        self.call()
    }
    
    func call() {
        print("안녕하세요")
    }
}

let jungyeob: Student = Student(name: "LeeJungYeob", major: "Law")
//호출 순서 : conveience init -> child init -> parent init

/*총 2단계 초기화를 진행
 1) 1단계
     1. 지정 또는 편의 init 호출
     2. jungyeob 인스턴스를 위한 메모리 할당
     3. Student 내부에 정의된 모든 저장 프로퍼티에 값이 있는지 확인 ( 모든 저장 프로퍼티 초기화 완료 )
     4. 지정 init은 부모 클래스에게 init 양도 (super.init)
     5. 부모 클래스는 최상위 클래스 까지 이 작업을 반복 ( student -> human 종료 )
 
 2) 2단계
    1. 최상위 클래스에서 최하위 클래스까지 따라 내려오면서 인스턴스를 사용자 정의 -> 이 단계에서 self를 통해 프로퍼티 값을 수정할 수 있으며, 메소드 호출이 가능
 */

print("-------------------------------------")
print("-------------------------------------")

//init을 따로 지정해주지 않은 경우 부모 클래스의 init을 자동 상속
//부모의 지정 init을 자동 또는 override를 통해 모두 동일한 init을 사용할 수 있다면 conveience init역시 자동 상속
class Child: Student {
    //부모 클래스 init 자동 상속 --> conveience init 자동 상속
    
    func cry() {
        print("아!!!!!!!")
    }
}

