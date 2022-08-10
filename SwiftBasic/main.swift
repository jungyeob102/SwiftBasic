class Owner {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

enum Temp {
    case dog(name: String, owner: Owner)
    case cat
}

let man: Owner = Owner.init(name: "이중엽")

var dog1: Temp? = Temp.dog(name: "태식", owner: man)

switch dog1 {
case let .dog(a, b):
    print(a)
    print(b.name)
case .cat: break
case nil:
    print("값 없음")
}
