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

extension NSDictionary: ValueType { }

extension NSDictionary: MarshaledObject {
    public func anyForKey(key: KeyType) throws -> Any {
        let value:Any
        guard let v = self.valueForKeyPath(key.stringValue) else {
            throw Error.KeyNotFound(key: key)
        }
        value = v
        if let _ = value as? NSNull {
            throw Error.NullValue(key: key)
        }

        return value
    }

    public subscript(key: KeyType) -> Any? {
        guard let aKey = key as? Key else { return nil }
        
        return self[aKey]
    }
}
