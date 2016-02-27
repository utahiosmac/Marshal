![](Logo/Logo.png)

![License](https://img.shields.io/dub/l/vibe-d.svg)
![Carthage](https://img.shields.io/badge/Carthage-compatible-brightgreen.svg)
![Platforms](https://img.shields.io/badge/Platform-iOS%20%7C%20watchOS%20%7C%20tvOS%20%7C%20OS%20X-lightgrey.svg)
# Marshal

In Swift, we all deal with JSON, plists, and various forms of `[String: AnyObject]`. `Marshal` believes you don't need a Ph.D. in Monads or large, complex frameworks to deal with these in an expressive and type safe way. `Marshal` is a simple, lightweight framework for safely extracting values from `[String: AnyObject]`.

## Usage

Extracting values from `[String: AnyObject]` (a.k.a. `MarshaledObject`) is as easy as:

```swift
let name: String = try json.valueForKey("name")
```

Or, if you're into fancy high-brow operators:

```swift
let name: String = try json <| "name"
```

`Marshal` even handles pulling values out of nested objects.

```swift
let url: NSURL = try json.valueForKey("user.website")
```

## Error Handling

Don't care about errors? Use `try?` to give yourself an optional value. Otherwise, wrap it up into a `do-catch` and get all the juicy details.

## Converting to Models

Often we want to take some `MarshaledObject` and turn it into one of our models (like intializing a model from a JSON object). For this, `Marshal` offers the `Unmarshaling` protocol.

```swift
struct User: Unmarshaling {
    var id: String
    var name: String
    var email: String

    init(object: MarshaledObject) throws {
        id = try object.valueForKey("id")
        name = try object.valueForKey("name")
        email = try object.valueForKey("email")
    }
}
```

Et voila! By supplying a simple initializer you can now *pull your models directly out of `[String: AnyObject]`*.

```swift
let users: [User] = json.valueForKey("users")
```

## Add Your Own Values

Out of the box, `Marshal` supports extracting native Swift types like `String`, `Int`, etc., as well as `NSURL`, anything conforming to `Unmarshaling`, and arrays of the aforementioned types.

However, addding your own extractable type is as easy as extending your type with `Marshal.ValueType`.

```swift
extension NSDate : ValueType {
    public static func value(object: Any) throws -> NSDate {
        guard let dateString = object as? String else {
            throw Marshal.Error.TypeMismatch(expected: String.self, actual: object.dynamicType)
        }
        // assuming you have a NSDate.fromISO8601String implemented...
        guard let date = NSDate.fromISO8601String(dateString) else {
            throw Marshal.Error.TypeMismatch(expected: "ISO8601 date string", actual: dateString)
        }
        return date
    }
}
```

Now you can do this!

```swift
let birthDate: NSDate = json.valueForKey("user.dob")
```

## JSON

One of the most common occurences of `[String: AnyObject]` are JSON objects. To this end, `Marshal` supplies a `JSONObject` typelias for `MarshaledObject`, and several helper functions.

## Contributors

`Marshal` began as a [blog series on JSON parsing by Jason Larsen](http://jasonlarsen.me/2015/10/16/no-magic-json-pt3.html), but quickly evolved into a community project. Many people have contribued at one point or another to varying degrees with ideas and code:

* Bart Whiteley
* Brian Mullen
* Derrick Hathaway
* Dave DeLong
* Jason Larsen
* Mark Schultz
* Tim Shadel
