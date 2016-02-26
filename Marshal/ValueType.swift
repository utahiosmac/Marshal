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
    typealias _Value = Self
    
    static func value(object: Any) throws -> _Value
}

extension ValueType {
    public static func value(object: Any) throws -> _Value {
        guard let objectValue = object as? _Value else {
            throw Error.TypeMismatch(expected: _Value.self, actual: object.dynamicType)
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
        let is64Bit = sizeof(Int) == sizeof(Int64)
        
        if is64Bit {
            guard let value = object as? Int else {
                throw Error.TypeMismatch(expected: _Value.self, actual: object.dynamicType)
            }
            return Int64(value)
        }
        else {
            guard let value = object as? NSNumber else {
                throw Error.TypeMismatch(expected: NSNumber.self, actual: object.dynamicType)
            }
            return value.longLongValue
        }
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

extension NSURL: ValueType {
    public static func value(object: Any) throws -> NSURL {
        guard let urlString = object as? String, objectValue = NSURL(string: urlString) else {
            throw Error.TypeMismatch(expected: self, actual: object.dynamicType)
        }
        return objectValue
    }
}
