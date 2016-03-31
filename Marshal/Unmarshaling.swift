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


public protocol Unmarshaling : ValueType {
    associatedtype ConvertibleType = Self
    init(object: Marshal) throws
}

extension Unmarshaling {
    
    public static func value(object: Any) throws -> ConvertibleType {
        guard let convertedObject = object as? Marshal else {
            throw Error.TypeMismatch(expected: Marshal.self, actual: object.dynamicType)
        }
        guard let value = try self.init(object: convertedObject) as? ConvertibleType else {
            throw Error.TypeMismatch(expected: ConvertibleType.self, actual: object.dynamicType)
        }
        return value
    }
    
}
