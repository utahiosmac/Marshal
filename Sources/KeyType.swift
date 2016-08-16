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
    static var keyTypeSeparator: Character { get set }
    var stringValue: String { get }
}

public extension KeyType {
    public func split() -> [String] {
        return self.stringValue.characters.split(separator: type(of: self).keyTypeSeparator).map(String.init)
    }
}

extension String: KeyType {
    public static var keyTypeSeparator: Character = "."
    public var stringValue: String {
        return self
    }
}
