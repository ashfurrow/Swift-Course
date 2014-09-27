// Playground - noun: a place where people can play

import Foundation

let a = 0
// Really same as let a: Int = 0

// var b: Int = nil won't work
let b: Int? = nil

// let c = a + b won't work
if let unwrappedB = b {
    let c = a + unwrappedB
} else {
    "b is nil"
}

if let b = b {
    let c = a + b
}

let c = a + (b ?? 0)

struct Number {
    var innerNumber: Int = 0
}

struct Dinges {
    var number: Number? = nil
}

var dinges = Dinges()
dinges.number = Number()

if var number = dinges.number {
    number.innerNumber = 5
}

dinges.number?.innerNumber = 15

let innerNumber = dinges.number?.innerNumber
// innerNumber is an optional, since the above expression could be nil
