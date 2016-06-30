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
    public func optionally(key: KeyType) -> Any? {
        guard let aKey = key as? Key else { return nil }
        
        return self[aKey]
    }
}

extension NSDictionary: ValueType { }

extension NSDictionary: MarshaledObject {
    public func anyForKey(_ key: KeyType) throws -> Any {
        let value:Any
        if key.dynamicType.keyTypeSeparator == "." {
            // `valueForKeyPath` is more efficient. Use it if possible.
            guard let v = self.value(forKeyPath: key.stringValue) else {
                throw Error.keyNotFound(key: key)
            }
            value = v
        }
        else {
            let pathComponents = key.split()
            var accumulator: Any = self

            for component in pathComponents {
                if let componentData = accumulator as? MarshaledObject, v = componentData.optionally(key: component) {
                    accumulator = v
                    continue
                }
                throw Error.keyNotFound(key: key.stringValue)
            }
            value = accumulator
        }

        if let _ = value as? NSNull {
            throw Error.nullValue(key: key)
        }

        return value
    }

    public func optionally(key: KeyType) -> Any? {
        guard let aKey = key as? Key else { return nil }
        
        return self[aKey]
    }
}
