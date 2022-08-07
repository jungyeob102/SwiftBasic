
var dic: [String: Bool] = [:]

for i in 65 ... 90 {
    if let temp = UnicodeScalar(i) {
        dic.updateValue(false, forKey: String(temp))
    }
}

dic["D"] = true

print(dic.keys.sorted())
