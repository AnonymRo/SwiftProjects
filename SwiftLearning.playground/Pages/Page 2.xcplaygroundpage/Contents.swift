/*:
 [< Previous](@previous)                     [Home](Introduction)                     [Next >](@next)
 ## Swift exercises
 
 - Experiment:
 Make another subclass of NamedShape called Circle that takes a radius and a name as arguments to its initializer. \
Implement an area() and a simpleDescription() method on the Circle class.
 */
import Foundation

class NamedShape {
    var numberOfSides: Int = 0
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

class Circle: NamedShape {
    var circleRadius: Int = 0
    let pi: Double = 3.14
    
    init(circleRadius: Int, name: String) {
        self.circleRadius = circleRadius
        super.init(name: name)
    }
    
    func area() -> Double {
        let radius = Double(circleRadius)
        return pi * pow(radius, 2)
    }
    
    override func simpleDescription() -> String {
        return "A circle with the radius of \(circleRadius) has an area of \(area())."
    }
}

let test = Circle(circleRadius: 5, name: "My test circle")
test.area()
test.simpleDescription()
