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
    typealias Value = Self
    
    static func value(object: Any) throws -> Value
}

extension ValueType {
    public static func value(object: Any) throws -> Value {
        guard let objectValue = object as? Value else {
            throw Error.TypeMismatch(expected: Value.self, actual: object.dynamicType)
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
    public static func value(object: Any) throws -> Int64 {
        guard let value = object as? NSNumber else { throw Error.TypeMismatch(expected: NSNumber.self, actual: object.dynamicType) }
        return value.longLongValue
    }
}

extension Array where Element: ValueType {
    public static func value(object: Any) throws -> [Element] {
        guard let anyArray = object as? [AnyObject] else {
            throw Error.TypeMismatch(expected: self, actual: object.dynamicType)
        }
        return try anyArray.map {
            let value = try Element.value($0)
            guard let element = value as? Element else {
                throw Error.TypeMismatch(expected: Element.self, actual: value.dynamicType)
            }
            return element
        }
    }
}

extension Dictionary: ValueType {
    public static func value(object: Any) throws -> [Key: Value] {
        guard let objectValue = object as? [Key: Value] else {
            throw Error.TypeMismatch(expected: self, actual: object.dynamicType)
        }
        return objectValue
    }
}

extension Set where Element: ValueType {
    public static func value(object: Any) throws -> Set<Element> {
        let elementArray = try [Element].value(object)
        return Set<Element>(elementArray)
    }
}

extension NSURL: ValueType {
    public static func value(object: Any) throws -> NSURL {
        guard let urlString = object as? String, objectValue = NSURL(string: urlString) else {
            throw Error.TypeMismatch(expected: self, actual: object.dynamicType)
        }
        return objectValue
    }
}

extension Int8: ValueType {
    public static func value(object: Any) throws -> Int8 {
        guard let value = object as? Int else {
            throw Error.TypeMismatch(expected: Value.self, actual: object.dynamicType)
        }
        return Int8(value)
    }
}
extension Int16: ValueType {
    public static func value(object: Any) throws -> Int16 {
        guard let value = object as? Int else {
            throw Error.TypeMismatch(expected: Value.self, actual: object.dynamicType)
        }
        return Int16(value)
    }
}
extension Int32: ValueType {
    public static func value(object: Any) throws -> Int32 {
        guard let value = object as? Int else {
            throw Error.TypeMismatch(expected: Value.self, actual: object.dynamicType)
        }
        return Int32(value)
    }
}

extension UInt8: ValueType {
    public static func value(object: Any) throws -> UInt8 {
        guard let value = object as? UInt else {
            throw Error.TypeMismatch(expected: Value.self, actual: object.dynamicType)
        }
        return UInt8(value)
    }
}
extension UInt16: ValueType {
    public static func value(object: Any) throws -> UInt16 {
        guard let value = object as? UInt else {
            throw Error.TypeMismatch(expected: Value.self, actual: object.dynamicType)
        }
        return UInt16(value)
    }
}
extension UInt32: ValueType {
    public static func value(object: Any) throws -> UInt32 {
        guard let value = object as? UInt else {
            throw Error.TypeMismatch(expected: Value.self, actual: object.dynamicType)
        }
        return UInt32(value)
    }
}
extension UInt64: ValueType {
    public static func value(object: Any) throws -> UInt64 {
        let is64Bit = sizeof(UInt) == sizeof(UInt64)
        
        if is64Bit {
            guard let value = object as? UInt else {
                throw Error.TypeMismatch(expected: Value.self, actual: object.dynamicType)
            }
            return UInt64(value)
        }
        else {
            guard let value = object as? NSNumber else {
                throw Error.TypeMismatch(expected: NSNumber.self, actual: object.dynamicType)
            }
            return value.unsignedLongLongValue
        }
    }
}

extension Character: ValueType {
    public static func value(object: Any) throws -> Character {
        guard let value = object as? String else {
            throw Error.TypeMismatch(expected: Value.self, actual: object.dynamicType)
        }
        return Character(value)
    }
}
