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

public typealias MarshaledArray = [AnyObject]


// MARK: - Array Extensions

extension Array {
    public func anyForIndex(index: Index) throws -> Any {
        if indices.contains(index) {
            let accumulator: Any = self[index]
            if let _ = accumulator as? NSNull {
                throw Error.NullValue(key: String(index))
            }
            return accumulator
        }
        else {
            throw Error.IndexNotFound(index: index)
        }
    }
    
    public func valueForIndex<A: ValueType>(index: Int) throws -> A {
        let any = try anyForIndex(index)
        guard let result = try A.value(any) as? A else {
            throw Error.TypeMismatch(expected: A.self, actual: any.dynamicType)
        }
        return result
    }
    
    public func valueForIndex<A: ValueType>(index: Int) throws -> [A] {
        let any = try anyForIndex(index)
        return try Array<A>.value(any)
    }
    
    public func valueForIndex<A: ValueType>(index: Index) throws -> [A]? {
        do {
            return try self.valueForIndex(index) as [A]
        }
        catch Error.IndexNotFound {
            return nil
        }
        catch Error.NullValue {
            return nil
        }
    }
    
    public func valueForIndex<A: ValueType>(index: Int) throws -> A? {
        do {
            return try self.valueForIndex(index) as A
        }
        catch Error.IndexNotFound {
            return nil
        }
        catch Error.NullValue {
            return nil
        }
    }
    
    public func valueForIndex<A: ValueType>(index: Int) throws -> Set<A> {
        let any = try anyForIndex(index)
        return try Set<A>.value(any)
    }
    
    public func valueForIndex<A: ValueType>(index: Int) throws -> Set<A>? {
        do {
            return try self.valueForIndex(index) as Set<A>
        }
        catch Error.IndexNotFound {
            return nil
        }
        catch Error.NullValue {
            return nil
        }
    }
}

extension Array {
    
    public func valueForIndex<A: RawRepresentable where A.RawValue: ValueType>(index: Int) throws -> A {
        let raw = try self.valueForIndex(index) as A.RawValue
        guard let value = A(rawValue: raw) else {
            throw Error.TypeMismatch(expected: A.self, actual: raw)
        }
        return value
    }
    
    public func valueForIndex<A: RawRepresentable where A.RawValue: ValueType>(index: Int) throws -> A? {
        do {
            return try self.valueForIndex(index) as A
        }
        catch Error.IndexNotFound {
            return nil
        }
        catch Error.NullValue {
            return nil
        }
    }
    
    public func valueForIndex<A: RawRepresentable where A.RawValue: ValueType>(index: Int) throws -> [A] {
        let rawArray = try self.valueForIndex(index) as [A.RawValue]
        return try rawArray.map({ raw in
            guard let value = A(rawValue: raw) else {
                throw Error.TypeMismatch(expected: A.self, actual: raw)
            }
            return value
        })
    }
    
    public func valueForIndex<A: RawRepresentable where A.RawValue: ValueType>(index: Int) throws -> [A]? {
        do {
            return try self.valueForIndex(index) as [A]
        }
        catch Error.IndexNotFound {
            return nil
        }
        catch Error.NullValue {
            return nil
        }
    }
    
    public func valueForIndex<A: RawRepresentable where A.RawValue: ValueType>(index: Int) throws -> Set<A> {
        let rawArray = try self.valueForIndex(index) as [A.RawValue]
        let enumArray: [A] = try rawArray.map({ raw in
            guard let value = A(rawValue: raw) else {
                throw Error.TypeMismatch(expected: A.self, actual: raw)
            }
            return value
        })
        return Set<A>(enumArray)
    }
    
    public func valueForIndex<A: RawRepresentable where A.RawValue: ValueType>(index: Int) throws -> Set<A>? {
        do {
            return try self.valueForIndex(index) as Set<A>
        }
        catch Error.IndexNotFound {
            return nil
        }
        catch Error.NullValue {
            return nil
        }
    }
}
