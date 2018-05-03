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


public typealias KeyType = CodingKey

extension String: CodingKey {
    public var stringValue: String { return self }
    public var intValue: Int? { return nil }
    
    public init?(stringValue: String) {
        self = String(stringValue)
    }
    
    public init?(intValue: Int) {
        return nil
    }
}
