import Foundation

struct MyPos {
    var x = 0
    var y = 0
    
    mutating func setMyPos(pos_x: Int, pos_y: Int) {
        self.x = pos_x
        self.y = pos_y
    }
    
    mutating func setOrgPos(pos_x: Int, pos_y: Int) {
        self.x = pos_x
        self.y = pos_y
    }
}

func DFS(myPos: inout MyPos, map: inout Array<Array<Int>>, visited_map: inout Array<Array<Bool>>, isFirst: Bool) {
    //처음 위치 저장
    if isFirst {
        myPos.setOrgPos(pos_x: myPos.x, pos_y: myPos.y)
    }
    
    //첫 방문
    visited_map[myPos.y][myPos.x] = true
    
    //오른쪽 탐색
    if ((visited_map[myPos.y][myPos.x + 1] == false) && (map[myPos.y][myPos.x + 1] == 1)) {
        myPos.setMyPos(pos_x: myPos.x + 1, pos_y: myPos.y)
    }
    //아래 탐색
    else if ((visited_map[myPos.y + 1][myPos.x] == false) && (map[myPos.y + 1][myPos.x] == 1)) {
        myPos.setMyPos(pos_x: myPos.x, pos_y: myPos.y + 1)
    }
    //왼쪽 탐색
    else if ((visited_map[myPos.y][myPos.x - 1] == false) && (map[myPos.y][myPos.x - 1] == 1)) {
        myPos.setMyPos(pos_x: myPos.x - 1, pos_y: myPos.y)
    }
    //위쪽 탐색
    else if ((visited_map[myPos.y - 1][myPos.x] == false) && (map[myPos.y - 1][myPos.x] == 1)) {
        myPos.setMyPos(pos_x: myPos.x, pos_y: myPos.y - 1)
    }
    
    //안간곳이면 탐색
    if visited_map[myPos.y][myPos.x] == false {
        DFS(myPos: &myPos, map: &map, visited_map: &visited_map, isFirst: false)
    }
}

let testCase = Int(readLine()!)!

for _ in 0 ..< testCase {
    //MARK: 기본 값 설정
    let info: Array = (readLine()!).split(separator: " ")
    let pos_x: Int = Int(info[0])!
    let pos_y: Int = Int(info[1])!
    let count: Int = Int(info[2])!
    
    //MARK: 기본 맵 생성
    var map: [[Int]] = Array(repeating: Array(repeating: 0, count: pos_x), count: pos_y)
    var visited_map: [[Bool]] = Array(repeating: Array(repeating: false, count: pos_x), count: pos_y)
    
    for _ in 0 ..< count {
        let map_info: Array = (readLine()!).split(separator: " ")
        let x: Int = Int(map_info[0])!
        let y: Int = Int(map_info[1])!
        
        map[y][x] = 1
    }
    var myPos: MyPos = MyPos()
    DFS(myPos: &myPos, map: &map, visited_map: &visited_map, isFirst: true)
}
