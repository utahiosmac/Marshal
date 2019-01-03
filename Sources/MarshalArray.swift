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

extension Array: MarshaledObject {
    public func optionalAny(for key: KeyType) -> Any? {
        guard let index = key.intValue else { return nil }
        return indices ~= index ? self[index] : nil
    }
}
