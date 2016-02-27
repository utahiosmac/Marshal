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


public func += (inout left: MarshaledObject, right: MarshaledObject) {
    for (key, value) in right {
        if var leftValue = left[key] as? MarshaledObject, let rightValue = value as? MarshaledObject {
            leftValue += rightValue
            left.updateValue(leftValue, forKey: key)
        }
        else {
            left.updateValue(value, forKey: key)
        }
    }
}
