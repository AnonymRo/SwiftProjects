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
