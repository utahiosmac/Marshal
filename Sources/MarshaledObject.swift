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


public protocol MarshaledObject {
    subscript(key: KeyType) -> Any? { get }
    func anyForKey(_ key: KeyType) throws -> Any
}

public extension MarshaledObject {
    public func anyForKey(_ key: KeyType) throws -> Any {
        let pathComponents = key.split()
        var accumulator: Any = self
        
        for component in pathComponents {
            if let componentData = accumulator as? Self, let value = componentData[component] {
                accumulator = value
                continue
            }
            throw MarshalError.keyNotFound(key: key.stringValue)
        }
        
        if let _ = accumulator as? NSNull {
            throw MarshalError.nullValue(key: key.stringValue)
        }
        
        return accumulator
    }
    
    public func valueForKey<A: ValueType>(_ key: KeyType) throws -> A {
        let any = try self.anyForKey(key)
        do {
            guard let result = try A.value(any) as? A else {
                throw MarshalError.typeMismatchWithKey(key: key.stringValue, expected: A.self, actual: any.dynamicType)
            }
            return result
        }
        catch let MarshalError.typeMismatch(expected: expected, actual: actual) {
            throw MarshalError.typeMismatchWithKey(key: key.stringValue, expected: expected, actual: actual)
        }
    }
    
    public func valueForKey<A: ValueType>(_ key: KeyType) throws -> A? {
        do {
            return try self.valueForKey(key) as A
        }
        catch MarshalError.keyNotFound {
            return nil
        }
        catch MarshalError.nullValue {
            return nil
        }
    }
    
    public func valueForKey<A: ValueType>(_ key: KeyType) throws -> [A] {
        let any = try self.anyForKey(key)
        do {
            return try Array<A>.value(any)
        }
        catch let MarshalError.typeMismatch(expected: expected, actual: actual) {
            throw MarshalError.typeMismatchWithKey(key: key.stringValue, expected: expected, actual: actual)
        }
    }
    
    public func valueForKey<A: ValueType>(_ key: KeyType) throws -> [A]? {
        do {
            return try self.valueForKey(key) as [A]
        }
        catch MarshalError.keyNotFound {
            return nil
        }
        catch MarshalError.nullValue {
            return nil
        }
    }
    
    public func valueForKey<A: ValueType>(_ key: KeyType) throws -> Set<A> {
        let any = try self.anyForKey(key)
        do {
            return try Set<A>.value(any)
        }
        catch let MarshalError.typeMismatch(expected: expected, actual: actual) {
            throw MarshalError.typeMismatchWithKey(key: key.stringValue, expected: expected, actual: actual)
        }
    }
    
    public func valueForKey<A: ValueType>(_ key: KeyType) throws -> Set<A>? {
        do {
            return try self.valueForKey(key) as Set<A>
        }
        catch MarshalError.keyNotFound {
            return nil
        }
        catch MarshalError.nullValue {
            return nil
        }
    }
    
    public func valueForKey<A: RawRepresentable where A.RawValue: ValueType>(_ key: KeyType) throws -> A {
        let raw = try self.valueForKey(key) as A.RawValue
        guard let value = A(rawValue: raw) else {
            throw MarshalError.typeMismatchWithKey(key: key.stringValue, expected: A.self, actual: raw)
        }
        return value
    }
    
    public func valueForKey<A: RawRepresentable where A.RawValue: ValueType>(_ key: KeyType) throws -> A? {
        do {
            return try self.valueForKey(key) as A
        }
        catch MarshalError.keyNotFound {
            return nil
        }
        catch MarshalError.nullValue {
            return nil
        }
    }
    
    public func valueForKey<A: RawRepresentable where A.RawValue: ValueType>(_ key: KeyType) throws -> [A] {
        let rawArray = try self.valueForKey(key) as [A.RawValue]
        return try rawArray.map({ raw in
            guard let value = A(rawValue: raw) else {
                throw MarshalError.typeMismatchWithKey(key: key.stringValue, expected: A.self, actual: raw)
            }
            return value
        })
    }
    
    public func valueForKey<A: RawRepresentable where A.RawValue: ValueType>(_ key: KeyType) throws -> [A]? {
        do {
            return try self.valueForKey(key) as [A]
        }
        catch MarshalError.keyNotFound {
            return nil
        }
        catch MarshalError.nullValue {
            return nil
        }
    }
    
    public func valueForKey<A: RawRepresentable where A.RawValue: ValueType>(_ key: KeyType) throws -> Set<A> {
        let rawArray = try self.valueForKey(key) as [A.RawValue]
        let enumArray: [A] = try rawArray.map({ raw in
            guard let value = A(rawValue: raw) else {
                throw MarshalError.typeMismatchWithKey(key: key.stringValue, expected: A.self, actual: raw)
            }
            return value
        })
        return Set<A>(enumArray)
    }
    
    public func valueForKey<A: RawRepresentable where A.RawValue: ValueType>(_ key: KeyType) throws -> Set<A>? {
        do {
            return try self.valueForKey(key) as Set<A>
        }
        catch MarshalError.keyNotFound {
            return nil
        }
        catch MarshalError.nullValue {
            return nil
        }
    }
}
