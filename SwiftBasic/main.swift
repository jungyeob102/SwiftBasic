import Foundation

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
        print("init")
        self.id = id
    }
    
    func changeID(newID: String) {
        print("호출 됐어욤")
        self.id = newID
    }
}

class UserData: UserClass {
    
    override init(id: String) {
        print("init_child")
        super.init(id: id)
    }
    
    override func changeID(newID: String) {
        print(newID)
    }
}

let temp: UserData = UserData(id: "234")
temp.changeID(newID: "123")
