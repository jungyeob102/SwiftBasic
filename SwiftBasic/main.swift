import Foundation

var arr: [Int] = []
var maxNum: Int = 0
var maxNumIndex: Int = 0

for _ in 1 ... 9 {
    let comp: String = readLine()!
    
    if Int(comp) != nil {
        arr.append(Int(comp)!)
    }
}

let count = arr.count

for i in 0 ..< count {
    if arr[i] > maxNum {
        maxNum = arr[i]
        maxNumIndex = i + 1
    }
}

print(maxNum)
print(maxNumIndex)
