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


public protocol UnmarshalUpdating {
    mutating func update(object object: MarshaledObject)
}
