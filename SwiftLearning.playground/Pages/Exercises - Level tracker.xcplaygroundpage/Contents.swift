/*:
 # Level tracker
 
 ### The example below defines a structure called LevelTracker, which tracks a player’s progress through the different levels or stages of a game. It’s a single-player game, but can store information for multiple players on a single device.
 ### All of the game’s levels (apart from level one) are locked when the game is first played. Every time a player finishes a level, that level is unlocked for all players on the device. The LevelTracker structure uses type properties and methods to keep track of which levels of the game have been unlocked. It also tracks the current level for an individual player.
 */
struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1
    
    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel { highestUnlockedLevel = level }
    }
    
    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    
    /* Attribute which suppress the compiler warning when the function or method that returns a value is called without using its result */
    @discardableResult
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}
/*:
 ### The LevelTracker structure keeps track of the highest level that any player has unlocked. This value is stored in a type property called highestUnlockedLevel.
 ### LevelTracker also defines two type functions to work with the highestUnlockedLevel property. The first is a type function called unlock(_:), which updates the value of highestUnlockedLevel whenever a new level is unlocked. The second is a convenience type function called isUnlocked(_:), which returns true if a particular level number is already unlocked. (Note that these type methods can access the highestUnlockedLevel type property without your needing to write it as LevelTracker.highestUnlockedLevel.)
 ### In addition to its type property and type methods, LevelTracker tracks an individual player’s progress through the game. It uses an instance property called currentLevel to track the level that a player is currently playing.
 ### To help manage the currentLevel property, LevelTracker defines an instance method called advance(to:). Before updating currentLevel, this method checks whether the requested new level is already unlocked. The advance(to:) method returns a Boolean value to indicate whether or not it was actually able to set currentLevel. Because it’s not necessarily a mistake for code that calls the advance(to:) method to ignore the return value, this function is marked with the @discardableResult attribute.
 ### The LevelTracker structure is used with the Player class, shown below, to track and update the progress of an individual player:
 */
class Player {
    var tracker = LevelTracker()
    let playerName: String
    
    func complete(level: Int) {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
    init(name: String) {
        playerName = name
    }
}
/*:
 ### The Player class creates a new instance of LevelTracker to track that player’s progress. It also provides a method called complete(level:), which is called whenever a player completes a particular level. This method unlocks the next level for all players and updates the player’s progress to move them to the next level. (The Boolean return value of advance(to:) is ignored, because the level is known to have been unlocked by the call to LevelTracker.unlock(_:) on the previous line.)
 ### You can create an instance of the Player class for a new player, and see what happens when the player completes level one:
 */
var player1 = Player(name: "Seba")
player1.complete(level: 1)
print("The highest unlocked level for player 1 is now \(LevelTracker.highestUnlockedLevel)")

/*:
 ### Here, player 2 wants to reach level 3 which is still locked:
 */
var player2 = Player(name: "Mario")
if player2.tracker.advance(to: 3) {
    print("Player 2 is now at level 3")
} else {
    print("This level is locked!")
}
