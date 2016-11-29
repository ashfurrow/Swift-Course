import Foundation

print("hello world")


let name = "Ash"
let age = 26
print(name)
print("Hello my name is \(name) and I am \(age) years old")
// Talk about type inference

var number = 3
number = 5
// Talk about constants

let numbers = [1,2,3]
let strings = ["Ash", "Samuel", "Marga"]

// Fast enumeration
for string in strings {
    print(string)
}

// ".each" based
strings.map({ (string: String) -> Void in
    print(string)
})

strings.map{ (string: String) -> Void in
    print(string)
}

strings.filter { (string: String) -> Bool in
    return string.hasPrefix("A")
}

strings.filter { $0.hasPrefix("A") }

let luckyNumbers = ["Ash": 17, "Samuel": 11, "Marga": 4243]

for (key, value) in luckyNumbers {
    print("The lucky number of \(key) is \(value)")
}
