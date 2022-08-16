import Foundation

struct User {
    var id: String

    init(id: String) {
        self.id = id
    }
    
    mutating func changeID(newID: String) {
        self.id = newID
    }
}

var DoDo: User = User(id: "DoDo")
//DoDo / DoDoCopy는 아직까진 같은 메모리를 참조
var DoDoCopy: User = DoDo
