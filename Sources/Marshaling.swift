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

public protocol Marshaling {
    associatedtype MarshalType: MarshaledObject
    
    func marshaled() -> Self.MarshalType
}

extension Array where Element: Marshaling {
    public func marshaled() -> [Any] {
        return self.map { $0.marshaled() }
    }
}
