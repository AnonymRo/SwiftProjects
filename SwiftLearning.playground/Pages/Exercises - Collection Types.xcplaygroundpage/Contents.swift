/*:
 # Collection Types
 */
/* Empty array */
var emptyArray: [Int] = []
print("emptyArray of type [Int] have \(emptyArray.count) items.")
emptyArray.append(3)
print(emptyArray)

/* Array with default value */
var threeDoubles = Array(repeating: 0.0, count: 3)
print(threeDoubles)
var anotherThreeDoubles = Array(repeating: 2.5, count: 3)
var sixDoubles = threeDoubles + anotherThreeDoubles
print(sixDoubles)

/* Array with literals */
var literalArray: [String] = ["one", "two", "three"]
print(literalArray)

/* isEmpty boolean */
if literalArray.isEmpty {
    print("literalArray is empty.")
} else {
    literalArray.append("four")
    literalArray += ["five", "six"]
    literalArray.insert("zero", at: 0)
    var firstItem = literalArray[0]
    print("literalArray is not empty, it contains \(literalArray.count) items and the first item is \(firstItem).")
    let zero = literalArray.remove(at: 0)
    print("\(literalArray) has removed \(zero)")
}

/* Iterating over an array */
for item in literalArray {
    print(item)
}

for (index, value) in literalArray.enumerated() {
    print("Item \(index + 1): \(value)")
}

/* Creating and initializing an empty set */
var letters = Set<Character>()
print("letters is of type Characters with \(letters.count) items.")

/* A set with array literals */
var books: Set<String> = ["Book1", "Book2", "Book3"]
/* or */
var booksSet: Set = ["Book1", "Book2", "Book3"]

/* Accesing and modifing a set */
books.insert("Book4")
for book in books.sorted() {
    print(book)
}

/* Performing Set Operations */
let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

oddDigits.union(evenDigits).sorted()
// [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
oddDigits.intersection(evenDigits).sorted()
// []
oddDigits.subtracting(singleDigitPrimeNumbers).sorted()
// [1, 9]
oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()
// [1, 2, 9]

/* Set Membership and Equality */
let houseAnimals: Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]

houseAnimals.isSubset(of: farmAnimals)
// true
farmAnimals.isSuperset(of: houseAnimals)
// true
farmAnimals.isDisjoint(with: cityAnimals)
// true

/* Empty dictionary */
var emptyDictionary: [Int: String] = [:]

/* Dictionary with literals */
var literalDictionary: [Int: String] = [1: "ROU", 2: "USA", 3: "UK"]

literalDictionary[3] = "ES"

if let oldValue = literalDictionary.updateValue("UK", forKey: 2) {
    print("The old value for 2 was \(oldValue)")
}

let sortedDictionary = literalDictionary.sorted(by: { $0.key < $1.key })
for (key, value) in sortedDictionary {
    print("\(key): \(value)")
}
