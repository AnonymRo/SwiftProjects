/*: [Previous](@previous)             [Next](@next)

 
 - Experiment: Add a third case to ServerResponse and to the switch.
 
 */
enum ServerResponse {
    case result(String, String)
    case outOfSync(String)
    case failure(String)
}


let success = ServerResponse.result("6:00 am", "8:09 pm")
let outOfSync = ServerResponse.outOfSync("Out of sync")
let failure = ServerResponse.failure("Out of cheese.")


switch success {
case let .result(sunrise, sunset):
    print("Sunrise is at \(sunrise) and sunset is at \(sunset).")
case let .outOfSync(message):
    print("The server is \(message)")
case let .failure(message):
    print("Failure...  \(message)")
}
