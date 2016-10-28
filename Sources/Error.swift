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


public enum MarshalError: Error, CustomStringConvertible {
    
    case keyNotFound(key: AnyHashable)
    case nullValue(key: AnyHashable)
    case typeMismatch(expected: Any, actual: Any)
    case typeMismatchWithKey(key: AnyHashable, expected: Any, actual: Any)
    
    public var description: String {
        switch self {
        case let .keyNotFound(key):
            return "Key not found: \(key.description)"
        case let .nullValue(key):
            return "Null Value found at: \(key.description)"
        case let .typeMismatch(expected, actual):
            return "Type mismatch. Expected type \(expected). Got '\(actual)'"
        case let .typeMismatchWithKey(key, expected, actual):
            return "Type mismatch. Expected type \(expected) for key: \(key.description). Got '\(actual)'"
        }
    }
}
