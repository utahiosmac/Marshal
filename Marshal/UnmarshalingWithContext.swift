//
//  UnmarshalingWithContext.swift
//  Marshal
//
//  Created by Bart Whiteley on 5/27/16.
//  Copyright © 2016 Utah iOS & Mac. All rights reserved.
//

import Foundation


public protocol UnmarshalingWithContext {
    associatedtype ContextType
    associatedtype ConvertibleType = Self
    
    static func valueFromObject(object: MarshaledObject, context: ContextType) throws -> ConvertibleType
}

public protocol UnmarshalUpdatingWithContext {
    associatedtype ContextType
    
    mutating func update(object object: MarshaledObject, context: ContextType) throws
}

extension MarshaledObject {
    public func valueForKey<A: UnmarshalingWithContext>(key: KeyType, context: A.ContextType) throws -> A {
        let any = try self.anyForKey(key)
        guard let object = any as? MarshaledObject else {
            throw Error.TypeMismatch(expected: MarshaledObject.self, actual: any.dynamicType)
        }
        guard let value = try A.valueFromObject(object, context: context) as? A else {
            throw Error.TypeMismatch(expected: A.self, actual: object.dynamicType)
        }
        return value
    }
    
    public func valueForKey<A: UnmarshalingWithContext>(key: KeyType, context: A.ContextType) throws -> A? {
        do {
            return try self.valueForKey(key, context: context) as A
        }
        catch Error.KeyNotFound {
            return nil
        }
        catch Error.NullValue {
            return nil
        }
    }
    
    public func valueForKey<A: UnmarshalingWithContext>(key: KeyType, context: A.ContextType) throws -> [A] {
        let any = try self.anyForKey(key)
        guard let objectArray = any as? [AnyObject] else {
            throw Error.TypeMismatch(expected: Array<MarshaledObject>.self, actual: any.dynamicType)
        }
        return try objectArray.map {
            guard let object = $0 as? MarshaledObject else {
                throw Error.TypeMismatch(expected: MarshaledObject.self, actual: $0.dynamicType)
            }
            guard let value = try A.valueFromObject(object, context: context) as? A else {
                throw Error.TypeMismatch(expected: A.self, actual: $0.dynamicType)
            }
            return value
        }
    }
    
    public func valueForKey<A: UnmarshalingWithContext>(key: KeyType, context: A.ContextType) throws -> [A]? {
        do {
            return try self.valueForKey(key, context: context) as [A]
        }
        catch Error.KeyNotFound {
            return nil
        }
        catch Error.NullValue {
            return nil
        }
    }
}
