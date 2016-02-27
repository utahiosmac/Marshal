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


public enum Error: ErrorType, CustomStringConvertible {
    
    case IndexNotFound(index: Int)
    case KeyNotFound(key: String)
    case NullValue(key: String)
    case TypeMismatch(expected: Any, actual: Any)
    case TypeMismatchWithKey(key: String, expected: Any, actual: Any)
    
    public var description: String {
        switch self {
        case let .IndexNotFound(index):
            return "Index not found: \(index)"
        case let .KeyNotFound(key):
            return "Key not found: \(key.stringValue)"
        case let .NullValue(key):
            return "Null Value found at: \(key.stringValue)"
        case let .TypeMismatch(expected, actual):
            return "Type mismatch. Expected type \(expected). Got '\(actual)'"
        case let .TypeMismatchWithKey(key, expected, actual):
            return "Type mismatch. Expected type \(expected) for key: \(key). Got '\(actual)'"
        }
    }
}
