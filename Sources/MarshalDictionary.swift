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


// MARK: - Types

public typealias MarshalDictionary = [String: AnyObject]


// MARK: - Dictionary Extensions

extension Dictionary: MarshaledObject {
    public subscript(key: KeyType) -> Any? {
        guard let aKey = key as? Key else { return nil }
        
        return self[aKey]
    }
}

extension NSDictionary: MarshaledObject {
    public subscript(key: KeyType) -> Any? {
        guard let aKey = key as? Key else { return nil }
        
        return self[aKey]
    }
}