/*:
 # Structures and classes
 */
/* Definition syntax */
//Since structures and classes are Swift types, it's useful to match the capitalization standard for types (UpperCamelCase)
struct Resolution {
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

/* Creating an instance */
let someResolution = Resolution()
let someVideoMode = VideoMode()

/* Accessing properties */
print("The width of someResolution is \(someResolution.width)")
print("The width of someVideoMode is \(someVideoMode.resolution.width)")

someVideoMode.resolution.width = 1280
print("New resolution for someVideoMode is \(someVideoMode.resolution.width)")

/*:
 # Properties
 */
/* Stored properties */
struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
// the range represents integer values 0, 1, and 2
rangeOfThreeItems.firstValue = 6
// the range represents integer values 6, 7, and 8

/* Stored properties of constant structure instance */
let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
// the range represents integer values 0, 1, and 2
//rangeOfFourItems.firstValue = 6 -> this will generate an error because struct is a value type

/* Lazy stored properties */
class DataImporter {
    /*
     DataImporter is a class to import data from an external file.
     The class is assumed to take a nontrivial amount of time to initialize.
     */
    var filename = "data.txt"
    // the DataImporter class would provide data importing functionality here
}

class DataManager {
    lazy var importer = DataImporter()
    var data: [String] = []
    // the DataManager class would provide data management functionality here
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")

print(manager.importer.filename)

/* Computed properties */
struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.width / 2)
        }
    }
}
var square = Rect(origin: Point(x: 0.0, y: 0.0),
                  size: Size(width: 10.0, height: 10.0))
let initialSquarecenter = square.center
// initialSquareCenter is at (5.0, 5.0)
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at \(square.origin.x), \(square.origin.y)")

/* Read-Only computed properties (only have a getter) */
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("The volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")

/* Property observers */
class StepCounter {
    var totalSteps: Int = 0 {
        willSet {
            print("About to set totalSteps to \(newValue)")
        }
        didSet {
            if totalSteps > oldValue {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200
//About to set totalSteps to 200
//Added 200 steps
stepCounter.totalSteps = 500
//About to set totalSteps to 500
//Added 300 steps

/* Property wrappers */
@propertyWrapper
struct TwelveOrLess {
    private var number = 0
    var wrappedValue: Int {
        get { number }
        set { number = min(newValue, 12) }
    }
}
struct Rectangle {
    @TwelveOrLess var height: Int
    @TwelveOrLess var width: Int
}

var rectangle = Rectangle()
print(rectangle.height)

rectangle.height = 13
//rectangle.height will be set to 12
print(rectangle.height)

/* Setting initial values for wrapped properties */
@propertyWrapper
struct SmallNumber {
    private var maximum: Int
    private var number: Int
    
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, maximum) }
    }
    
    init() {
        maximum = 12
        number = 0
    }
    
    init(wrappedValue: Int) {
        maximum = 12
        number = min(wrappedValue, maximum)
    }
    
    init(wrappedValue: Int, maximum: Int) {
        self.maximum = maximum
        number = min(wrappedValue, maximum)
    }
}

struct NarrowRectangle {
    @SmallNumber(wrappedValue: 2, maximum: 5) var height: Int
    @SmallNumber(wrappedValue: 3, maximum: 4) var width: Int
}

var narrowRectangle = NarrowRectangle()
//prints 2 3
print(narrowRectangle.height, narrowRectangle.width)

/* Type properties */
struct SomeStructure {
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty: Int {
        return 1
    }
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty: Int {
        return 6
    }
}
class SomeClass {
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}
class SubClass: SomeClass {
    override class var overrideableComputedTypeProperty: Int {
        return 87
    }
}
print(SomeStructure.storedTypeProperty)
// Prints "Some value."
SomeStructure.storedTypeProperty = "Another value."
print(SomeStructure.storedTypeProperty)
// Prints "Another value."
print(SomeEnumeration.computedTypeProperty)
// Prints "6"
print(SomeClass.computedTypeProperty)
// Prints "27"
print(SomeClass.overrideableComputedTypeProperty)
print(SubClass.overrideableComputedTypeProperty)

/* Audio level meter */
struct AudioChannel {
    static let thresholdLevel: Int = 10
    static var maxInputLevelForAllChannels: Int = 0
    
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}

var leftChannel  = AudioChannel()
var rightChannel = AudioChannel()

leftChannel.currentLevel = 7
print(leftChannel.currentLevel)
print(AudioChannel.maxInputLevelForAllChannels)

rightChannel.currentLevel = 12
print(rightChannel.currentLevel)
print(AudioChannel.maxInputLevelForAllChannels)

/*:
 # Methods
 */
/* Instance methods */
class Counter {
    var count = 0;
    func increment() {
        count += 1
    }
    func increment(by amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}
let counter = Counter()
//Counter become 1
counter.increment()
//Counter become 6
counter.increment(by: 5)
//Counter is reseted to 0
counter.reset()

/* The self Property */
struct PointStructure {
    var x = 0.0, y = 0.0
    func isToTheRightOf(x: Double) -> Bool {
        return self.x > x
    }
}
let somePoint = PointStructure(x: 4.0, y: 5.0)
if somePoint.isToTheRightOf(x: 1.0) {
    print("somePoint is to the right of the line where x = 1.0")
}

/* Modifying Value Types from Within Instance Methods */
struct PointStructure2 {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}
//or
struct PointStructure3 {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = PointStructure3(x: x + deltaX, y: y + deltaY)
    }
}
var anotherPoint = PointStructure2(x: 1.0, y: 2.0)
anotherPoint.moveBy(x: 3.0, y: 5.0)
print("The point is now at \(anotherPoint.x), \(anotherPoint.y)")

var yetAnotherPoint = PointStructure3(x: 2.0, y: 4.5)
yetAnotherPoint.moveBy(x: 3.5, y: 2.0)
print("The point is now at \(yetAnotherPoint.x), \(yetAnotherPoint.y)")

/* Mutating methods for enumarations */
enum TriStateSwitch {
    case off, low, high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}
var ovenLightState = TriStateSwitch.off
//The next state for overLightState will be low
ovenLightState.next()

/* Type methods */
class SomeClass2 {
    class func someTypeMethod() {
        // type method implementation goes here
    }
}
//Here, we call the type method directly on the type itself, not on an instance of that type
SomeClass2.someTypeMethod()
/*:
 # Subscripts
 */
/* Subscript syntax */
struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 3)
print("Three times six is \(threeTimesTable[6])")

/* Subscript options */
struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}
var matrix = Matrix(rows: 2, columns: 2)
matrix[0,1] = 1.5
matrix[1,1] = 2.4
/*   Assertion is triggered because of trying to access a subscription which is out of matrix's range
 *   let someValue = matrix[2,3]
 */

/* Type subscripts */
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    static subscript(n: Int) -> Planet {
        return Planet(rawValue: n)!
    }
}
let mars = Planet[4]
print(mars)

/*:
 # Initialization
 */
/* Syntax */
struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}
var f = Fahrenheit()
print("The default temperature is \(f.temperature)")

/* Default property values */
struct Fahrenheit2 {
    var temperature: Double = 32.0
}

/* Initialization Parameters */
struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}
let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
let freezingPointOfWater = Celsius(fromKelvin: 273.15)
print("The boiling point of water is \(boilingPointOfWater.temperatureInCelsius) and the freezing point is \(freezingPointOfWater.temperatureInCelsius)")

/* Parameter names and argument labels */
struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red    = red
        self.green  = green
        self.blue   = blue
    }
    init(white: Double) {
        red     = white
        green   = white
        blue    = white
    }
}
let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)

/* Initializer parameters without argument labels */
struct Celsius2 {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}
let bodyTemperature = Celsius2(37.0)
print("Average body temperature for an adult is \(bodyTemperature.temperatureInCelsius)")

/* Optional property types */
class SurveyQuestion {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
cheeseQuestion.response = "Yes, I do like cheese."

/* Assigning constant properties during initialization */
class AnotherSurveyQuestion {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let beetsQuestion = SurveyQuestion(text: "How about beets?")
beetsQuestion.ask()
beetsQuestion.response = "I also like beets. (But not with cheese.)"

/* Default initializers */
class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem()

/* Memberwise initializers for structure types */
//  Structures types automatically receive a memberwise initializer if they don't define any of their own custom initializer.
struct Perimeter {
    var width = 0.0, height = 0.0
}
let twoByTwo = Perimeter(width: 2.0, height: 2.0)
print(twoByTwo.width, twoByTwo.height)
let zeroByTwo = Perimeter(height: 2.0)
print(zeroByTwo.width, zeroByTwo.height)
let zeroByZero = Perimeter()
print(zeroByZero.width, zeroByZero.height)

/* Initializer delegation for value types */
struct AnotherPerimeter {
    var width = 0.0, height = 0.0
}

struct AnotherPoint {
    var x = 0.0, y = 0.0
}

struct AnotherRect {
    var origin = AnotherPoint()
    var size = AnotherPerimeter()
    init() {}
    init(origin: AnotherPoint, size: AnotherPerimeter) {
        self.origin = origin
        self.size = size
    }
    init(center: AnotherPoint, size: AnotherPerimeter) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: AnotherPoint(x: originX, y: originY), size: size)
    }
}
//First AnotherRect initializer
let basicRect = AnotherRect()
//Second AnotherRect initializer
let originRect = AnotherRect(origin: AnotherPoint(x: 2.0, y: 2.0), size: AnotherPerimeter(width: 5.0, height: 5.0))
//Third AnotherRect initializer
let centerRect = AnotherRect(center: AnotherPoint(x: 4.0, y: 4.0), size: AnotherPerimeter(width: 3.0, height: 3.0))

/*:
 ## Designated initializers and convenience initializers
 
 **Designated initializers** are the primary initializers for a class. They fully initializes all properties introduced by that class and calls an appropriate superclass initializer to continue the initialization process up the superclass chain.
 Every class must have at least **one** designated initializer. In some cases, this requirement is satisfied by inheriting one or more designated initializers from a superclass.
 
 **Convenience initializers** are secondary, supporting initializers for a class. You can define a convenience initializer to call a designated initializer from the same class as the convenience initializer with some of the designated initializer's parameters set to default values. Convenience initializers are not required.
 ### Syntax for designated initializers:
 ```
 init(<#parameters#>) {
    <#statements#>
 }
 ```
 ### Syntax for convenience initializers:
 ```
 convenience init(<#parameters#>) {
    <#statements#>
 }
 ```
 ## Initializer delegation for class types
 
 To simplify the relationship between designated and convenience initializers, Swift applies the following three rules for delegation calls between initializers:
 - Rule 1: A designated initializer must call a designated initializer from its **immediate** superclass.
 - Rule 2: A convenience initializer must call another initializer from the **same** class.
 - Rule 3: A convenience initializer must **ultimately** call a designated initializer.
 
 In simpler terms:
 - Designated initializers must always delegate **up**.
 - Convenience initializers must always delegate **across**.
 
 ## Two-Phase initialization
 
 Class initialization in Swift is a two-phase process. In the **first** phase, each stored property is assigned an initial value by the class that introduced it. Once the initial state of every stored property has been determined, the **second** phase begins, and each class is given the opportunity to customize its stored properties further before the new instance is considered ready for use.
 
 Swift's compiler performs four helpful safety-checks to make sure that two-phase initialization is completed without error:
 - Safety check 1: A designated initializer must ensure that all of the properties introduced by its class are initialized before it delegates up to a superclass initializer.
 - Safety check 2: A designated initializer must delegate up to a superclass initializer before assigning a value to an **inherited** property.
 - Safety check 3: A convenience initializer must delegate to another initializer before assigning a value to **any** property (including properties defined by the same class). If it doesn't, the new value the convenience initializer assigns will be overwritten by its own class's designated initializer.
 - Safety check 4: An initializer can't call any instance methods, read the values of any instance properties, or refer to self as a value until after the first phase of initialization is complete.
 
 Based on the four safety checks from above, here's how two-phase initialization plays out:
 
 ### Phase 1
 
 - A designated of convenience initializer is called on a class.
 - Memory for a new instance of that class is allocated (but not yet initialized).
 - A designated initializer for that class confirms that all stored properties introduced by that class have a value. Now the memory for these stored properties is initialized.
 - The designated initializer hands off to a superclass initializer to perform the same task for its own stored properties.
 - This continues up the class inheritance chain until the top of the chain is reached.
 - Once the top of the chain is reached, and the final class in the chain has ensured that all of its stored properties have a value, the instance's memory is considered to be fully initialized, and phase 1 is complete.
 
 ### Phase 2
 
 - Working back down from the top of the chain, each designated initializer in the chain has the option to customize the instance further. Initializers are now able to access **self** and can modify its properties, call its instance methods, and so on.
 - Finally, any convenience initializers in the chain have the option to customize the instance and to work with **self**.
 */

/*:
 # Initializer inheritance and overriding
 */
class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}
let vehicle = Vehicle()
print("Vehicle: \(vehicle.description)")

class Bicycle: Vehicle {
    override init() {
        super.init()
        numberOfWheels = 2
    }
}
let bicycle = Bicycle()
print("Bicycle: \(bicycle.description)")

class Hoverboard: Vehicle {
    var color: String
    init(color: String) {
        self.color = color
        //super.init() implicitly called here
    }
    override var description: String {
        return "\(super.description) in a beautiful \(color)"
    }
}
let hoverboard = Hoverboard(color: "red")
print("Hoverboard: \(hoverboard.description)")

/*:
 # Automatic initializer inheritance
 
 Subclasses don't inherit their superclass initializers by default. However, superclass initializers are automatically inherited if certain conditions are met. In practice, this means that you don't need to write initializer overrides in many common scenarios, and can inherit your superclass initializers with minimal effort whenever it's safe to do so.
 
 Assuming that you provide default values for any new properties you introduce in a subclass, the following two rules apply:
 ### Rule 1
 - If your subclass doesn't define any designated initializers, it automatically inherits all of its superclass designated initializers.
 ### Rule 2
 - If your subclass provides an implementation of all of its superclass designated initializers (either by inheriting them as per rule 1, or by providing a custom implementation as part of its definition) then it automatically inherits all of the superclass convenience initializers.
 
 These rules apply even if your subclass adds further convenience initializers.
 */

/*:
 # Designated and convenience initializers in action
 */
class Food {
    var name: String
    //this is a designated init
    init(name: String) {
        //this class doesn't have any superclass so super.init() call is not necessarry
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}
let namedMeat = Food(name: "Bacon")

class RecipeIngredient: Food {
    var quantity: Int
    //designated init
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}
//three ways to create a RecipeIngredient instance
let oneMysteryItem = RecipeIngredient()
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)

class ShoppingListItems: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✅" : " ⛔️"
        return output
    }
    //this class doesn't define any initializer itself, therefore it automatically inherits all of the designated and convenience initializers from its superclass
}

var breakfastList: [ShoppingListItems] = [
    ShoppingListItems(),
    ShoppingListItems(name: "Bacon"),
    ShoppingListItems(name: "Eggs", quantity: 6),
]
breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
    print(item.description)
}

/*:
 # Failable initializers
 */
let wholeNumber: Double = 12345.0
let pi = 3.14159

if let valueMaintained = Int(exactly: wholeNumber) {
    print("\(wholeNumber) conversion to Int maintains value of \(valueMaintained)")
}

let valueChanged = Int(exactly: pi)

if valueChanged == nil {
    print("\(pi) conversion to Int doesn't maintain value")
}

struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty { return nil }
        self.species = species
    }
}
let someCreature = Animal(species: "Giraffe")

if let giraffe = someCreature {
    print("An animal was initialized with a species of \(giraffe.species)")
}

//initialization failure triggered by empty string
let anonymousCreature = Animal(species: "")

if anonymousCreature == nil {
    print("The anonymous creature couldn't be initialized")
}

/*:
 # Failable initializers for enumerations
 */
enum TemperatureUnit {
    case kelvin, celsius, fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .kelvin
        case "C":
            self = .celsius
        case "F":
            self = .fahrenheit
        default:
            return nil
        }
    }
}
let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}

let unknownUnit = TemperatureUnit(symbol: "X")
if unknownUnit == nil {
    print("The isn't a defined temperature unit, so the initialization failed.")
}

/*:
 # Failable initializers for enumerations with raw values
 
 Enumerations with raw values automatically receive a failable initializer, init?(rawValue:)
 We can re-write the enum above to use raw values of type Character:
 */
enum TemperatureUnits: Character {
    case kelvin = "K", celsius = "C", fahrenheit = "F"
}
let fahrenheitUnits = TemperatureUnits(rawValue: "F")
if fahrenheitUnits != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}

/*:
 # Propagation of initialization failure
 
 A failable initializer of a class, structure, or enumeration can delegate across to another failable initializer from the same class, structure, or enumeration. Similarly, a subclass failable initializer can delegate up to a superclass failable initializer.
 */
class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

class CartItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 { return nil }
        self.quantity = quantity
        super.init(name: name)
    }
}

if let twoSocks = CartItem(name: "sock", quantity: 2) {
    print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
}

//if you try to create a CartItem instance with a quantity value of 0 or wuth an empty name value, the CartItem initializer causes initialization to fail.

/*:
 # Overriding a failable initializer
 
 You can override a superclass failable initializer in a subclass, just like any other initializer. Alternatively, you can override a superclass failable initializer with a subclass nonfailable initializer.
 */
class Document {
    var name: String?
    //this init creates a document with a nil name value
    init() {}
    //this init creates a document with a nonempty name value
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}

class UntitledDocument: Document {
    override init() {
        //use force unwrapping in an initializer to call a failable initializer from the superclass as part of the implementation of the subclass's nonfailable initializer
        super.init(name: "[Untitled]")!
    }
}

/*:
 # The init! failable initializer
 
 You typically define a failable initializer that creates an optional instance of the appropiate type by placing a question mark after the init keyword (init?). Alternatively, you can define a failable initializer that creates an implicitly unwrapped optional instance of the appropiate type. Do this by replacing an exclamation point after the init keyword (init!) instead of a question mark.
 
 You can delegate from init? to init! and vise versa, and you can override init? with init! and vice versa. You can also delegate from init to init!, although doing so will trigger an assertion if the init! initializer causes initialization to fail.
 */

/*:
 # Required initializer
 
 Write the **required** modifier before the definition of a class initializer to indicate that every subclass of the class must implement that initializer.
 */
class SomeClass3 {
    required init() {
        //initializer implementation goes here
    }
}

/*:
 # Setting a default property value with a closure or function
 */
/* Chessboard */
struct ChessBoard {
    let boardColors: [Bool] = {
        var temporaryBoard: [Bool] = []
        var isBlack = false
        for i in 1...8 {
            for j in 1...8 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    func squareIsBlackAt(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column]
    }
}
let chessBoard = ChessBoard()
print(chessBoard.squareIsBlackAt(row: 0, column: 1))
print(chessBoard.squareIsBlackAt(row: 7, column: 7))
