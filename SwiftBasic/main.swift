import Foundation

struct Sample {
    //인스턴스 프로퍼티
    var age: Int = 28
    var name: String = "이중엽"
    
    //타입 프로퍼티
    //저장 타입 프로퍼티는 상수, 변수 가능
    //연산 타입 프로퍼티는 상수로만 가능
    //타입 프로퍼티는 인스턴스의 생성 여부와 상관없이 타입 프로퍼티 자체로 값이 하나로 존재한다.
    //즉, 해당 타입의 모든 인스턴스가 공용으로 사용할 수 있다.
    static let nick: String = "dodo"
    
    //인스턴트 메소드
    func sayName() {
        print("안녕하세요 \(name) 입니다.")
    }
    
    //타입 메소드
    static func sayName() {
        print("안녕하세요 \(nick) 입니다.!")
        print(">???")
    }
}

//var temp: Sample = Sample()

print(Sample.sayName())
