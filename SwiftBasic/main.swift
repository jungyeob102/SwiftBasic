import Foundation

//inout 키워드를 사용하면 메모리 주소를 참조
//상수가 아닌 변수로 저장
func swap (a: inout Int, b: inout Int)
{
    let temp = a
    a = b
    b = temp
}

var temp1: Int = 1
var temp2: Int = 2
swap(a: &temp1, b: &temp2)

print(temp1)
print(temp2)
