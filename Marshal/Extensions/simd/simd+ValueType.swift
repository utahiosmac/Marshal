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
import simd


extension vector_float3: ValueType {
    public static func value(object: Any) throws -> vector_float3 {
        guard let values = object as? MarshaledObject else {
            throw Error.TypeMismatch(expected: self, actual: object.dynamicType)
        }
        
        let x: Float = try values.valueForKey("x")
        let y: Float = try values.valueForKey("y")
        let z: Float = try values.valueForKey("z")
        
        return vector_float3(x: x, y: y, z: z)
    }
}
