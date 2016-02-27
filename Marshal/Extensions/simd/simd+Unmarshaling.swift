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


extension vector_float3: Unmarshaling {
    public init(object: MarshaledObject) throws {
        let x: Float = try object.valueForKey("x")
        let y: Float = try object.valueForKey("y")
        let z: Float = try object.valueForKey("z")
        
        self.init(x: x, y: y, z: z)
    }
}
