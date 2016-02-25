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

public protocol Unmarshallable : ValueType {
    typealias ConvertibleType = Self
    init(object: Object) throws
}

extension Unmarshallable {
    
    public static func value(object: Any) throws -> ConvertibleType {
        guard let convertedObject = object as? Object else {
            throw Error.TypeMismatch(expected: Object.self, actual: object.dynamicType)
        }
        guard let value = try self.init(object: convertedObject) as? ConvertibleType else {
            throw Error.TypeMismatch(expected: ConvertibleType.self, actual: object.dynamicType)
        }
        return value
    }
    
}
