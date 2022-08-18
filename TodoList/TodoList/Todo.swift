//
//  Todo.swift
//  Test
//
//  Created by 이중엽 on 2022/08/16.
//

import UIKit

//MARK: - Struct - Todo
///**Struct Todo**
///- note: Todo 객체 단위
///- authors: 이중엽
///- Requires: 프로토콜: Codable, Equatable
struct Todo: Codable, Equatable {
    //MARK: - Struct - Todo - Property
    let id: Int
    var isDone: Bool
    var detail: String
    var isToday: Bool
    
    //MARK: - Struct - Todo - Method
    ///**Struct Todo 비교 연산자**
    ///- note: 상수인 id를 통해 같은지 비교 - 각각의 todo는 unique id 값을 가지고 있음
    ///- note: 값타입인 구조체는 인스턴스 메소드 내부에서 프로퍼티를 변경할 수 없기 때문에 mutating 키워드 입력
    ///- parameters:
    ///     - lhs: left hand side - 좌변 - 첫번째 매개변수
    ///     - rhs: right hand side - 우변 - 두번째 매개변수
    ///- returns: Todo 객체를 반환
    mutating func update(isDone: Bool, detail: String, isToday:Bool) {
        //구조체는 속성(프로퍼티)를 인스턴스 메소드 내부에서 수정할 수 없음 -> @mutating 키워드(속성) 추가
        self.isDone = isDone
        self.detail = detail
        self.isToday = isToday
    }
    
    ///**Struct Todo 비교 연산자**
    ///- note: 상수인 id를 통해 같은지 비교 - 각각의 todo는 unique id 값을 가지고 있음
    ///- note: equatable 프로토콜을 상속받았기에 정의 가능
    ///- parameters:
    ///     - lhs: left hand side - 좌변 - 첫번째 매개변수
    ///     - rhs: right hand side - 우변 - 두번째 매개변수
    ///- returns: Todo 객체를 반환
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}

//MARK: - Class - TodoManager
///**Class TodoManager**
///- note: Todos 객체를 관리
///- Authors: 이중엽
class TodoManager {
    
    //MARK: Class - TodoManger - Property
    static let shared = TodoManager()       //싱글톤 객체 생성
    static var lastId: Int = 0              //마지막 아이디 저장
    var todos: [Todo] = []                  //todo 리스트 모음
    
    //MARK: Class - TodoManager - Method
    ///**Class TodoManager init**
    ///- note: private - 인스턴스 생성 방지
    private init() {}
    
    ///**Class TodoManager method**
    ///- note: todo 객체를 생성 및 생성된 todo 객체에 unique id 부여
    ///- parameters:
    ///     - detail: 메모 내용
    ///     - isToday: Today 할 일인지를 체크
    ///- returns: Todo 객체를 반환
    func createTodo(detail: String, isToday: Bool) -> Todo {
        let nextId = TodoManager.lastId + 1
        TodoManager.lastId = nextId
        
        return Todo(id: nextId, isDone: false, detail: detail, isToday: isToday)
    }
    
    ///**Class TodoManager  method**
    ///- note: todo 객체를 todos 리스트에 추가 및 storage에 저장
    ///- parameters:
    ///     - todo: 추가할 todo 객체
    ///- returns:
    func addTodo(_ todo: Todo) {
        todos.append(todo)
        saveTodo()
    }
    
    ///**Class TodoManager  method**
    ///- note: todo 객체를 todos 리스트에서 삭제 및 storage에 저장
    ///- parameters:
    ///     - todo: 삭제할 todo 객체
    ///- returns:
    func deleteTodo(_ todo: Todo) {
        todos = todos.filter{ $0.id != todo.id }
        saveTodo()
    }
    
    ///**Class TodoManager  method**
    ///- note: todos 리스트에 있는 todo 객체의 정보를 수정  및 storage에 저장
    ///- parameters:
    ///     - todo: 정보를 수정할 todo 객체
    ///- returns:
    func updateTodo(_ todo: Todo) {
        //todos의 배열 앞에서부터 조회하여 todo와 가장 먼저 일치한 값의 index를 반환
        guard let index = todos.firstIndex(of: todo) else { return }
        todos[index].update(isDone: todo.isDone, detail: todo.detail, isToday: todo.isToday)
        saveTodo()
    }
    
    ///**Class TodoManager  method**
    ///- note: todos 리스트 정보를  "todos.json" 파일로 변환하여  저장
    ///- parameters:
    ///- returns:
    func saveTodo() {
        Storage.store(todos, to: .documents, as: "todo.json")
    }
    
    ///**Class TodoManager  method**
    ///- note: "todos.json" 파일을 다시 todos 배열로  변환하여  저장
    ///- parameters:
    ///- returns:
    func retrieveTodo() {
        todos = Storage.retrieve("todos.json", from: .documents, as: [Todo].self) ?? []
        
        let lastId = todos.last?.id ?? 0
        TodoManager.lastId = lastId
    }
}

//MARK: - Class - TodoViewModel
///**Class TodoViewModel**
///- note: Todo 뷰 모델
///- Authors: 이중엽
class TodoViewModel {
    
    //MARK: - Class - TodoViewModel - Enum
    ///**Class TodoManager  enum**
    ///- note: collection View의 Section
    enum Section: Int, CaseIterable {
        case today
        case upcoming
        
        var title: String {
            switch self {
            case .today: return "Today"
            default: return "Upcoming"
            }
        }
    }
    
    //MARK: - Class - TodoViewModel - Property
    private let manager = TodoManager.shared
    
    var todos: [Todo] {
        return manager.todos
    }
    
    var todayTodos: [Todo] {
        return todos.filter { $0.isToday == true}
    }
    
    var upcomingTodos: [Todo] {
        return todos.filter { $0.isToday == false}
    }
    
    var numOfSection: Int {
        return Section.allCases.count
    }
    
    //MARK: - Class - TodoViewModel - Method
    func addTodo(_ todo: Todo) {
        manager.addTodo(todo)
    }
    
    func deleteTodo(_ todo: Todo) {
        manager.deleteTodo(todo)
    }
    
    func updateTodo(_ todo: Todo) {
        manager.updateTodo(todo)
    }
    
    func loadTasks() {
        manager.retrieveTodo()
    }
}
