/*:
 # Functions
 */
/* Defining functions */
func greet(Person: String) -> String {
    return "Hello, " + Person + "!"
}

func greetAgain(Person: String) -> String {
    return "Hello again, " + Person + "!"
}

/* Function without parameters */
func noParameter() -> String {
    return "No parameter"
}

/* Function with multiple parameters */
func greet(Person: String, alreadyGreeted: Bool) -> String {
    if alreadyGreeted {
        return greetAgain(Person: Person)
    } else {
        return greet(Person: Person)
    }
}
print(greet(Person: "Seba", alreadyGreeted: true))

/* Function with no return values */
func greetWithNoReturnValue(Person: String) {
    print("Hello, \(Person)!")
}
greetWithNoReturnValue(Person: "Dave")

/* Function with multiple return values */
func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}
let numbers = minMax(array: [100, 2, 5, 17, 20, 11, 90])
print("The minimum bound of the array is \(numbers.min) and the maximum bound is \(numbers.max)")

/* Optional tuple return type */
func optionalMinMax(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty { return nil }
    var optionalMin = array[0]
    var optionalMax = array[0]
    
    for index in array[1..<array.count] {
        if index < optionalMin {
            optionalMin = index
        } else if index > optionalMax {
            optionalMax = index
        }
    }
    return (optionalMin, optionalMax)
}
let optionalArray = optionalMinMax(array: [])
print("The minimum bound of the optionalArray is \(optionalArray?.min ?? 0) and the maximum bound is \(optionalArray?.max ?? 0)")

/* Function with an implicit return */
func implicitReturn(Person: String) -> String {
    "Hello, " + Person + "!"
}
print(implicitReturn(Person: "Paula"))

/* Function argument labels and parameters name */
func someFunction(firstParameterName: Int, secondParameterName: Int) {
    // In the function body, firstParameterName and secondParameterName
    // refer to the argument values for the first and second parameters
}
someFunction(firstParameterName: 1, secondParameterName: 2)

/* Specifying argument labels */
func yetAnotherGreet(Person: String, from location: String) -> String {
    return "Hello, \(Person). Glad you could visit from \(location)."
}
print(yetAnotherGreet(Person: "Seba", from: "Arad"))

/* Omitting argument labels */
func anotherFunction(_ firstParameter: Int, secondParameter: Int) {
    print("The first parameter is \(firstParameter) and the second parameter is \(secondParameter)")
}
anotherFunction(1, secondParameter: 2)

/* Default parameter values */
func defaultParameter(_ firstParameter: Int, _ secondParameter: Int = 12) {
    print("\(firstParameter) and \(secondParameter)")
}
defaultParameter(2)
defaultParameter(2, 5)

/* Variadic parameters */
func arithmeticMean(_ numbers: Double...) -> Double{
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
let number: Double = arithmeticMean(1, 2, 3, 4, 5)
print(number)

/* In-Out parameters */
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}
var firstInt = 1
var secondInt = 3
swapTwoInts(&firstInt, &secondInt)
print("a is now equal to \(firstInt) and b is now equal to \(secondInt)")

/* Function types and how to use them */
func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}
func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
    return a * b
}
var mathFunction: (Int, Int) -> Int = addTwoInts
print("Result: \(mathFunction(2, 3))")
mathFunction = multiplyTwoInts
print("Result: \(mathFunction(2, 3))")

/*Function types as parameter types */
func printMathFunction(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}
printMathFunction(addTwoInts, 2, 3)
printMathFunction(multiplyTwoInts, 2, 3)

/* Function types as return types */
func stepForward(_ input: Int) -> Int {
    return input + 1
}
func stepBackward(_ input: Int) -> Int {
    return input - 1
}
func chooseStepFunction(_ step: Bool) -> (Int) -> Int {
    return step ? stepBackward : stepForward(_:)
}
var currentValue = 3
let backwardStep: (Int) -> Int = chooseStepFunction(currentValue > 0)
while currentValue != 0 {
    print("\(currentValue)...")
    currentValue = backwardStep(currentValue)
}
print("Zero!")

/* Nested functions */
func anotherChooseStepFunction(_ step: Bool) -> (Int) -> Int {
    func anotherStepForward(_ input: Int) -> Int { return input + 1 }
    func anotherStepBackwards(_ input: Int) -> Int { return input - 1 }
    return step ? anotherStepBackwards : anotherStepForward
}
var anotherValue = 0
let forwardStep: (Int) -> Int = anotherChooseStepFunction(false)
repeat {
    print("\(anotherValue)...")
    anotherValue = forwardStep(anotherValue)
} while anotherValue <= 100
