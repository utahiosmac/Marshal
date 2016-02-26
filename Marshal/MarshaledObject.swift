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

public typealias MarshaledArray = [MarshaledObject]


// MARK: - Dictionary Extensions

extension Dictionary where Key: KeyType {
    
    public func anyForKey(key: Key) throws -> Any {
        let pathComponents = key.stringValue.characters.split(".").map(String.init)
        var accumulator: Any = self
        
        for component in pathComponents {
            if let componentData = accumulator as? [Key: Value], value = componentData[component as! Key] {
                accumulator = value
                continue
            }
            
            throw Error.KeyNotFound(key: key.stringValue)
        }
        
        if let _ = accumulator as? NSNull {
            throw Error.NullValue(key: key.stringValue)
        }
        
        return accumulator
    }
    
    public func valueForKey<A: ValueType>(key: Key) throws -> A {
        let any = try anyForKey(key)
        do {
            guard let result = try A.value(any) as? A else {
                throw Error.TypeMismatchWithKey(key: key.stringValue, expected: A.self, actual: any.dynamicType)
            }
            return result
        }
        catch let Error.TypeMismatch(expected: expected, actual: actual) {
            throw Error.TypeMismatchWithKey(key: key.stringValue, expected: expected, actual: actual)
        }
    }
    
    public func valueForKey<A: ValueType>(key: Key) throws -> [A] {
        let any = try anyForKey(key)
        do {
            return try Array<A>.value(any)
        }
        catch let Error.TypeMismatch(expected: expected, actual: actual) {
            throw Error.TypeMismatchWithKey(key: key.stringValue, expected: expected, actual: actual)
        }
    }
    
    public func valueForKey<A: ValueType>(key: Key) throws -> [A]? {
        do {
            return try self.valueForKey(key) as [A]
        }
        catch Error.KeyNotFound {
            return nil
        }
        catch Error.NullValue {
            return nil
        }
    }
    
    public func valueForKey<A: ValueType>(key: Key) throws -> A? {
        do {
            return try self.valueForKey(key) as A
        }
        catch Error.KeyNotFound {
            return nil
        }
        catch Error.NullValue {
            return nil
        }
    }
}

extension Dictionary where Key: KeyType {
    
    public func valueForKey<A: RawRepresentable where A.RawValue: ValueType>(key: Key) throws -> A {
        let raw = try self.valueForKey(key) as A.RawValue
        guard let value = A(rawValue: raw) else {
            throw Error.TypeMismatchWithKey(key: key.stringValue, expected: A.self, actual: raw)
        }
        return value
    }
    
    public func valueForKey<A: RawRepresentable where A.RawValue: ValueType>(key: Key) throws -> A? {
        do {
            return try self.valueForKey(key) as A
        }
        catch Error.KeyNotFound {
            return nil
        }
        catch Error.NullValue {
            return nil
        }
    }
    
    public func valueForKey<A: RawRepresentable where A.RawValue: ValueType>(key: Key) throws -> [A] {
        let rawArray = try self.valueForKey(key) as [A.RawValue]
        return try rawArray.map({ raw in
            guard let value = A(rawValue: raw) else {
                throw Error.TypeMismatchWithKey(key: key.stringValue, expected: A.self, actual: raw)
            }
            return value
        })
    }
    
    public func valueForKey<A: RawRepresentable where A.RawValue: ValueType>(key: Key) throws -> [A]? {
        do {
            return try self.valueForKey(key) as [A]
        }
        catch Error.KeyNotFound {
            return nil
        }
        catch Error.NullValue {
            return nil
        }
    }
}
