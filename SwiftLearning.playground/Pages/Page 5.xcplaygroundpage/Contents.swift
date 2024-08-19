/*: [Previous](@previous)             [Next](@next)
 
 
 - Experiment: Add another requirement to ExampleProtocol. What changes do you need to make to SimpleClass and SimpleStructure so that they still conform to the protocol?
 
 */
protocol ExampleProtocol {
    var simpleDescription: String { get }
    mutating func adjust()
}

class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A very simple class."
    var secondRequirement: Int = 10
    var anotherProperty: Int = 69105
    func adjust() {
        simpleDescription += "  Now \(secondRequirement)% adjusted."
    }
}
var a = SimpleClass()
a.adjust()
let aDescription = a.simpleDescription
print(aDescription)

struct SimpleStructure: ExampleProtocol {
    var simpleDescription: String = "A simple structure"
    var secondRequirement: Int = 20
    mutating func adjust() {
        simpleDescription += " (\(secondRequirement)% adjusted)"
    }
}
var b = SimpleStructure()
b.adjust()
let bDescription = b.simpleDescription
print(bDescription)



extension Int: ExampleProtocol {
    var simpleDescription: String {
        return "The number \(self)"
    }
    mutating func adjust() {
        self += 42
    }
 }
print(7.simpleDescription)

/*:
 
 - Experiment: Write an extension for the Double type that adds an absoluteValue property.
 
 */
extension Double: ExampleProtocol {
    var simpleDescription: String {
        return "The number \(self)"
    }
    var absoluteValue: Double {
        return self < 0 ? -self : self
    }
    mutating func adjust() {
        self += 22
    }
}

let absoluteNumber: Double = -42.0
print(absoluteNumber.absoluteValue, terminator: "")
