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


public protocol KeyType: Hashable {
    var stringValue: String { get }
}

extension String: KeyType {
    public var stringValue: String {
        return self
    }
}