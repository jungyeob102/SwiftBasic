import Foundation

//MARK: 프로퍼티(property)
struct Sample {
    //속성 (attribute)
    @available(swift 3.0.2)
    
    //변수 (variable)
    var age: Int = 28
    var name: String = "홍길동"
}

//MARK: 저장 프로퍼티
struct Sample_1 {
    var age: Int = 28
    var name: String = "홍길동"
}

//MARK: 지연 프로퍼티
class Sample_class {
    init() {
        print("생성")
    }
}

class Sample_2 {
    lazy var data = Sample_class()
}

var temp: Sample_2 = Sample_2()

//MARK: 연산 프로퍼티
class Sample_3 {
    var result: Int = 5
    
    var temp: Int {
        get {
            return result
        }
        set(newValue) {
            result = newValue * 15
        }
    }
}

let sample3: Sample_3 = Sample_3()
sample3.temp = 1
print(sample3.temp)

//MARK: 읽기 전용 연산 프로퍼티
class Sample_4 {
    var x: Int = 10
    var y: Int = 25
    
    var volume: Int {
        get {
            return x * y
        }
    }
}

let sample4: Sample_4 = Sample_4()
print(sample4.volume)

//setter가 없기 때문에 값을 지정할 수 없다.
//sample4.volume = 4


//MARK: 타입 프로퍼티
class StudyMember {
    var nick: String
    static var gender: String = "MAN"
    
    init(arg_nick: String) {
        self.nick = arg_nick
    }
    
    func callMyGender() {
        print(StudyMember.gender)
    }
}

//각각의 인스턴스 생성
let JungYeob:StudyMember = StudyMember(arg_nick: "중엽")
let HyunHo:StudyMember = StudyMember(arg_nick: "현호")
let YeonSu:StudyMember = StudyMember(arg_nick: "연수")
let BumSu:StudyMember = StudyMember(arg_nick: "범수")

//StudyMember.gender = "Woman"

JungYeob.callMyGender()
HyunHo.callMyGender()
YeonSu.callMyGender()
BumSu.callMyGender()
