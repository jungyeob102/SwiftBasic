func solution(_ s:String) -> Bool {
    let s_count = s.count
    let s_arr = Array(s).map{String($0)}
    
    guard (s_count == 4 || s_count == 6) else {return false}
    
    for i in 0 ..< s_count {
        if Int(s_arr[i]) == nil {
            return false
        }
    }
    
    return true
}
