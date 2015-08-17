import UIKit
/*:
## Closure Enums Structs and Classes

Closures are self-contained blocks of functionality that can be passed around and used in your code. Closures in Swift are similar to blocks in C and Objective-C and to lambdas in other programming languages.

Closures can capture and store references to any constants and variables from the context in which they are defined. This is known as closing over those constants and variables, hence the name “closures”. Swift handles all of the memory management of capturing for you.

*/



/*:

## Closures

Before we talk about closures, lets revisit functions. Functions, by their definition, are pieces of functionality that can be called over and over. The main purpose of functions is reuse. Meaning, that we can reuse the functionality or logic contained in the function.

So, first a function recap.

Defining a function:

You define a function with the **func** keyword. Functions can take and return none, one or multiple parameters (tuples).
Return values follow the -> sign.

* func jediGreet(name: String, ability: String) -> (farewell: String, mayTheForceBeWithYou: String) {
* return ("Good bye, \(name).", " May the \(ability) be with you.")
* }

## Calling a function:

* let retValue = jediGreet("old friend", "Force")
* println(retValue)
* println(retValue.farewell)
* println(retValue.mayTheForceBeWithYou)
* Function types

Every function has its own function type, made up of the parameter types and the return type of the function itself.
For example the following function:

* func sum(x: Int, y: Int) -> (result: Int) { return x + y }
* has a function type of:
* (Int, Int) -> (Int)
* Function types can thus be used as parameters types or as return types for nesting functions.

## Passing and returning functions

The following function is returning another function as its result which can be later assigned to a variable and called.
* func jediTrainer () -> ((String, Int) -> String) {
* func train(name: String, times: Int) -> (String) {
* return "\(name) has been trained in the Force \(times) times"
* }
* return train
* }
* let train = jediTrainer()
* train("Obi Wan", 3)

## Variadic functions

Variadic functions are functions that have a variable number of arguments (indicated by ... after the argument's type) that can be accessed into their body as an array.

* func jediBladeColor (colors: String...) -> () {
* for color in colors {
* println("\(color)")
* }
* }
* jediBladeColor("red","green")

### Before continuing on, try these examples in playground. This will give you a feel for how functions are create and serve as a refresher.

*/
// -------Example 1
func jediGreet(name: String, ability: String) -> (farewell: String, mayTheForceBeWithYou: String) {
    return ("Good bye, \(name).", " May the \(ability) be with you.")
}
let retValue = jediGreet("kool friend", "Force")
println(retValue)
println(retValue.farewell)
println(retValue.mayTheForceBeWithYou)

//--------Example 2
func jediTrainer () -> ((String, Int) -> String) {
    func train(name: String, times: Int) -> (String) {
        return "\(name) has been trained in the Force \(times) times"
    }
    return train
}
let train = jediTrainer()
train("Tho Dang", 100)

//-------- Example 3

func jediBladeColor (colors: String...) -> () {
    for color in colors {
        println("\(color)")
    }
}
jediBladeColor("pink","purple")
/*:

## Defining a closure:

[Must read before continuing.](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Closures.html)

Closures are typically enclosed in curly braces { } and are defined by a function type () -> (), where -> separates the arguments and the return type, followed by the in keyword which separates the closure header from its body.
* { (params) -> returnType in
* statements
* }
An example could be the map function applied to an Array:

* let padawans = ["Knox", "Avitla", "Mennaus"]
* padawans.map({
* (padawan: String) -> String in
* "\(padawan) has been trained!"
* })

## Closures with known types:

When the type of the closure's arguments are known, you can do as follows:
* func applyMutliplication(value: Int, multFunction: Int -> Int) -> Int {
* return multFunction(value)
* }

* applyMutliplication(2, {value in
* value * 3
* })

## Closures shorthand argument names:

Closure arguments can be references by position ($0, $1, ...) rather than by name

* applyMutliplication(2, {$0 * 3})

Furthermore, when a closure is the last argument of a function, parenthesis can be omitted as such:

* applyMutliplication(2) {$0 * 3}


### Before continuing on, try these examples in playground. 

*/
// Closures with known types:
func applyMutliplication(value: Int, multFunction: Int -> Int) -> Int {
    return multFunction(value)
}
applyMutliplication(1000, {value in
    value * 7
})

//Closures shorthand argument names:

applyMutliplication(4, {$0 * 9})
/*:

## Enums

Enums can actually be categorized into three distinct subcategories, informally referred to here as **basic enums** , **raw value enums**, and **associated value enums**.

#### Basic Enum

The basic enum just enumerates a number of fixed cases:

* enum Direction {
* case North
* case South
* case East
* case West

// For conciseness, could also declare as:

// case North, South, East, West

}

// To create:
* let myDirection = Direction.North

// To test:
* if myDirection == Direction.North {
* println("you're facing north")
* }


In this form, enums serve the same purpose they do in a language like C or Objective-C: providing a type-safe way to specify exactly one of a finite number of possible values.

This is preferable to, for example, using numbers to implicitly represent cases, in which you have two main problems:

What each valid number means is either stored in your head or in a comment somewhere, rather than being baked into the code itself.
If someone tries to use an invalid numerical value, the compiler won’t warn you and your code will fail at runtime.

*/
// Basic Enum
enum Direction {
    case North
    case South
    case East
    case West
}
let thoDirection = Direction.East
if thoDirection == Direction.East {
print("Tho is running to East Direction")
}


/*:

## Raw Value Enum

[Must read before continuing.](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Enumerations.html)

The second form of enum is the raw value enum. Each case of a raw value enum corresponds to a fixed ‘raw’ value:

* enum Title : String {
* case CEO = "Chief Executive Officer"
* case CTO = "Chief Technical Officer"
* case CFO = "Chief Financial Officer"
* }

Notice the two main differences between the Title enum and the basic Direction enum described previously:

The type of the raw value, String, is specified after the name of the enum.
Each case must specify an associated raw value.
Raw value enum cases are not aliases of their raw values, and the two cannot be used interchangeably:

// BAD! Will not compile!

* let myCEOString : String = Title.CEO

// BAD! Will not compile!

* let myCEOValue : Title = "Chief Executive Officer"



However, raw value enums do support conversion between each enum value and its corresponding raw value, via the rawValue property and a special initializer that takes a rawValue argument:

* let myString : String = Title.CEO.rawValue

// myString is now "Chief Executive Officer"

* let myTitle : Title = Title(rawValue: "Chief Executive Officer")!

// myTitle is now Title.CEO

* let badTitle : Title? = Title(rawValue: "not a valid title")

// badTitle is now nil

Note that the initializer that turns a raw value (in this case, a string) into an enum instance returns an optional. This is because it’s possible to invoke the initializer with an invalid raw value, in which case it would return nil instead of an enum value.

Raw value enums whose raw values are of the Int type are treated slightly differently:

* enum Planet : Int {
*     case Mercury = 1
*     case Venus, Earth, Mars // 2, 3, 4
*     case Jupiter = 100
*     case Saturn, Uranus, Neptune // 101, 102, 13
* }

*/
enum Title : String {
    case CEO = "Chief Executive Officer"
    case CTO = "Chief Technical Officer"
    case CFO = "Chief Financial Officer"
}
let myCEOString : String = Title.CEO.rawValue
let myTitle:Title = Title(rawValue: "Chief Executive Officer")!
let badTitle: Title? = Title(rawValue:"not a valid title")

enum Planet:Int{
case Mercuty = 1
    case Venus, Earth,Mars
    case Jupiter = 100
    case Saturn, Uranus,Neptune

}
/*:
## Associated Value Enum

This is where things begin to get interesting. Enums that aren’t raw value enums can be declared in such a way that each case can store associated data. What does that mean? Take the following example, ‘borrowed’ from the official Swift book:

* enum Barcode {
* case UPCA(sys: Int, data: Int, check: Int)
* case QRCode(data: String)
* }

* let myNormalBarcode = Barcode.UPCA(sys: 0, data: 2791701919, check: 3)
* let myQRCode = Barcode.QRCode(data: "http://example.com")

The Barcode enum has two cases, UPCA and QRCode. However, each instance of a Barcode, which is one of those two cases, also has additional data associated with it! Exactly what data depends on the case. In the UPCA case, three integers are associated with a UPC-A barcode. In the QRCode case, one string is associated with a QR code.

The associated values need not be labeled. The above example can be more concisely expressed as follows:

* enum Barcode {
* case UPCA(Int, Int, Int)
* case QRCode(String)
* }

* let myNormalBarcode = Barcode.UPCA(0, 2791701919, 3)
* let myQRCode = Barcode.QRCode("http://example.com")

*/
//Associated Value Enum

enum Barcode{
    case UPCA(sys:Int,data:Int,check:Int)
    case QRCode(data:String)

}
let myNormalBarcode = Barcode.UPCA(0,33444,3)
let QRCode = Barcode.QRCode("www.barcode.com")
/*:

## Classes and Structs in Swift

### Value types vs. reference types
The Swift language (as many other programing languages, too) provides two fundamentally different types: Value types and reference types. If you've coded in Objective-C you've worked with reference types almost the entire time, **NSArray**, **NSDictionary**, etc. are all reference types. 

### Reference types

The easiest way to explain the difference between value types and reference types is discussing their behavior when being assigned to variables. Let's first take a look at an example of a reference type in good old Objective-C:


* NSMutableArray *array1 = [@[@(5), @(8), @(2)] mutableCopy];
* NSMutableArray *array2 = array1;
* [array1 addObject:@(10)];
* // array1: [5,8,2,10]
* // array2: [5,8,2,10]

In the first line we create an array. Since NSMutableArray is a reference type, we are storing a reference to the array inside of the variable array1. 
Then we create a second variable array2 and assign array1 one to it. In this step the reference stored in array1 gets copied into array2. 
Now array1 and array2 are referencing the same array object. If we change the array object through either of these two variables, the same array is modified. 
That means that the changes are reflected in both variables, even if the modification only happened through one of the two variables.
A reference type can be referenced by multiple owners. Here's an illustration of what the ownership looks like after the four lines of code above:

![](https://bitmakerlabs.s3.amazonaws.com/lectures/mobile/powerpoints/reference_types.png)

## Value Types

Value types behave different upon assignment. When a value type is assigned to a variable the variable always stores the value itself, not a reference to a value. This means whenever a value is assigned to a new variable, that variable gets its own copy of the value. A value can always only have one owner. In Swift, arrays are implemented as value types (they are structs!). So let's take a look at the same example in Swift:

* var array1 = [5,8,2]
* var array2 = array1
* array1.append(10)
* // array1: [5,8,2,10]
* // array2: [5,8,2]

In the first line we create the array. We assign it to the array1 variable. At this moment the actual array instance is stored inside of that variable, not a reference to the value.

In the second line we declare a new variable called array2 and assign array1 to it. Since Arrays in Swift are value types and value types are copied when assigned to a variable, array2 gets its private copy of the array stored in array1. In the last line we modify the the array stored in array1.

This time the variable array2 is not affected by this change, since it has its own private copy that is not affected by changes to the array stored in the array1 variable. Here's what the ownership diagram looks like for this example:


![](https://bitmakerlabs.s3.amazonaws.com/lectures/mobile/powerpoints/value_types.png)



## Struct Basics

Try adding the following to playground


* struct TodoItem {
* var title: String
* var content: String
* var dueDate: NSDate
* let owner: String
* }


*/

struct ToDoList{
    var title:String
    var content :String
    var dueDate:NSDate
    let owner:String
}

