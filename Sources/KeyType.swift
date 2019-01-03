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


public protocol KeyType {
    var stringValue: String { get }
    var intValue: Int? { get }
}

extension String: KeyType {
    public var stringValue: String {
        return self
    }
    public var intValue: Int? {
        return Int(self)
    }
}
