//
//  Todo.swift
//  Test
//
//  Created by 이중엽 on 2022/08/16.
//

import UIKit

struct Todo: Codable, Equatable {
    let id: Int
    var isDone: Bool
    var detail: String
    var isToday: Bool
    
    mutating func update(isDone: Bool, detail: String, isToday:Bool) {
        //구조체는 속성(프로퍼티)를 인스턴스 메소드 내부에서 수정할 수 없음 -> @mutating 키워드(속성) 추가
        self.isDone = isDone
        self.detail = detail
        self.isToday = isToday
    }
    
    //비교 연산자 함수
    //상수 id를 통해 비교 (다른 값들은 변할 가능성 있음)
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}

class TodoManager {
    
}
