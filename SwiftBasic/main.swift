//행, 열 입력
var xy: Array = (readLine()!).split(separator: " ")

let x: Int = Int(xy[0])!
let y: Int = Int(xy[1])!

var map: [[Int]] = [[Int]]()

for _ in 0 ..< x {
    let lineNumber = Array(readLine()!).map{Int(String($0))!}
    map.append(lineNumber)
}

var discovered: [(Int, Int)] = [(Int, Int)]()
var distance : [[Int]] = Array(repeating: Array(repeating: 0, count:y), count:x)
distance[0][0] = 1

func BFS(_ pos_x: Int, _ pos_y: Int) {
    discovered.append((pos_x,pos_y))
    map[pos_x][pos_y] = 0
    
    while (discovered.isEmpty == false) {
        let nextPos = discovered.removeFirst()
        
        for i in [(1,0),(-1,0),(0,1),(0,-1)] {
            let (nx,ny) = (nextPos.0 + i.0, nextPos.1 + i.1)
            
            if (0..<x).contains(nx) && (0..<y).contains(ny) && map[nx][ny] == 1 {
                map[nx][ny] = 0
                discovered.append((nx,ny))
                distance[nx][ny] = distance[nextPos.0][nextPos.1] + 1
            }
        }
    }
}

BFS(0,0)
print(distance[x-1][y-1])
