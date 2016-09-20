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


// MARK: - ValueType

public protocol ValueType {
    associatedtype Value = Self
    
    static func value(from object: Any) throws -> Value
}

extension ValueType {
    public static func value(from object: Any) throws -> Value {
        guard let objectValue = object as? Value else {
            throw MarshalError.typeMismatch(expected: Value.self, actual: type(of: object))
        }
        return objectValue
    }
}


// MARK: - ValueType Implementations

extension String: ValueType {}
extension Int: ValueType {}
extension UInt: ValueType {}
extension Float: ValueType {}
extension Double: ValueType {}
extension Bool: ValueType {}

extension Int64: ValueType {
    public static func value(from object: Any) throws -> Int64 {
        guard let value = object as? NSNumber else { throw MarshalError.typeMismatch(expected: NSNumber.self, actual: type(of: object)) }
        return value.int64Value
    }
}

extension Array where Element: ValueType {
    public static func value(from object: Any) throws -> [Element] {
        guard let anyArray = object as? [AnyObject] else {
            throw MarshalError.typeMismatch(expected: self, actual: type(of: object))
        }
        return try anyArray.map {
            let value = try Element.value(from: $0)
            guard let element = value as? Element else {
                throw MarshalError.typeMismatch(expected: Element.self, actual: type(of: value))
            }
            return element
        }
    }
}

extension Dictionary: ValueType {
    public static func value(from object: Any) throws -> [Key: Value] {
        guard let objectValue = object as? [Key: Value] else {
            throw MarshalError.typeMismatch(expected: self, actual: type(of: object))
        }
        return objectValue
    }
}

extension Set where Element: ValueType {
    public static func value(from object: Any) throws -> Set<Element> {
        let elementArray = try [Element].value(from: object)
        return Set<Element>(elementArray)
    }
}

extension URL: ValueType {
    public static func value(from object: Any) throws -> URL {
        guard let urlString = object as? String, let objectValue = URL(string: urlString) else {
            throw MarshalError.typeMismatch(expected: self, actual: type(of: object))
        }
        return objectValue
    }
}

extension Int8: ValueType {
    public static func value(from object: Any) throws -> Int8 {
        guard let value = object as? Int else {
            throw MarshalError.typeMismatch(expected: Value.self, actual: type(of: object))
        }
        return Int8(value)
    }
}
extension Int16: ValueType {
    public static func value(from object: Any) throws -> Int16 {
        guard let value = object as? Int else {
            throw MarshalError.typeMismatch(expected: Value.self, actual: type(of: object))
        }
        return Int16(value)
    }
}
extension Int32: ValueType {
    public static func value(from object: Any) throws -> Int32 {
        guard let value = object as? Int else {
            throw MarshalError.typeMismatch(expected: Value.self, actual: type(of: object))
        }
        return Int32(value)
    }
}

extension UInt8: ValueType {
    public static func value(from object: Any) throws -> UInt8 {
        guard let value = object as? UInt else {
            throw MarshalError.typeMismatch(expected: Value.self, actual: type(of: object))
        }
        return UInt8(value)
    }
}
extension UInt16: ValueType {
    public static func value(from object: Any) throws -> UInt16 {
        guard let value = object as? UInt else {
            throw MarshalError.typeMismatch(expected: Value.self, actual: type(of: object))
        }
        return UInt16(value)
    }
}
extension UInt32: ValueType {
    public static func value(from object: Any) throws -> UInt32 {
        guard let value = object as? UInt else {
            throw MarshalError.typeMismatch(expected: Value.self, actual: type(of: object))
        }
        return UInt32(value)
    }
}
extension UInt64: ValueType {
    public static func value(from object: Any) throws -> UInt64 {
        guard let value = object as? NSNumber else {
            throw MarshalError.typeMismatch(expected: NSNumber.self, actual: type(of: object))
        }
        return value.uint64Value
    }
}

extension Character: ValueType {
    public static func value(from object: Any) throws -> Character {
        guard let value = object as? String else {
            throw MarshalError.typeMismatch(expected: Value.self, actual: type(of: object))
        }
        return Character(value)
    }
}
