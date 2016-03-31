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

public typealias MarshaledObject = [String: AnyObject]


// MARK: - Dictionary Extensions

extension Dictionary: Marshal {
    public subscript(key: KeyType) -> Any? {
        guard let aKey = key as? Key else { return nil }
        
        return self[aKey]
    }
}

extension NSDictionary: Marshal {
    public subscript(key: KeyType) -> Any? {
        guard let aKey = key as? Key else { return nil }
        
        return self[aKey]
    }
}