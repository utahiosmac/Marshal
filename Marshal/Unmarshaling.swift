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

public protocol Unmarshalable : ValueType {
    typealias ConvertibleType = Self
    init(object: Object) throws
}

extension Unmarshalable {
    
    public static func unmarshal(object: Any) throws -> ConvertibleType {
        guard let convertedObject = object as? Object else {
            throw Error.TypeMismatch(expected: Object.self, actual: object.dynamicType)
        }
        guard let value = try self.init(object: convertedObject) as? ConvertibleType else {
            throw Error.TypeMismatch(expected: ConvertibleType.self, actual: object.dynamicType)
        }
        return value
    }
    
}
