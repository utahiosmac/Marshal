//
//  M A R S H A L
//
//       ()
//       /\
//  ()--'  '--()
//    `.    .'
//     / .. \
//    ()'  '()
//
//


import Foundation


// MARK: - <| Operator

infix operator <| { associativity left precedence 150 }

public func <| <A: ValueType>(dictionary: Marshal, key: String) throws -> A {
    return try dictionary.valueForKey(key)
}
public func <| <A: ValueType>(dictionary: Marshal, key: String) throws -> A? {
    return try dictionary.valueForKey(key)
}
public func <| <A: ValueType>(dictionary: Marshal, key: String) throws -> [A] {
    return try dictionary.valueForKey(key)
}
public func <| <A: ValueType>(dictionary: Marshal, key: String) throws -> [A]? {
    return try dictionary.valueForKey(key)
}
public func <| <A: RawRepresentable where A.RawValue: ValueType>(dictionary: Marshal, key: String) throws -> A {
    return try dictionary.valueForKey(key)
}
public func <| <A: RawRepresentable where A.RawValue: ValueType>(dictionary: Marshal, key: String) throws -> A? {
    return try dictionary.valueForKey(key)
}
public func <| <A: RawRepresentable where A.RawValue: ValueType>(dictionary: Marshal, key: String) throws -> [A] {
    return try dictionary.valueForKey(key)
}
public func <| <A: RawRepresentable where A.RawValue: ValueType>(dictionary: Marshal, key: String) throws -> [A]? {
    return try dictionary.valueForKey(key)
}
