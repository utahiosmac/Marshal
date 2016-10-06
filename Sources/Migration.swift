//
//  Migration.swift
//  Marshal
//
//  Created by Bart Whiteley on 10/6/16.
//  Copyright © 2016 Utah iOS & Mac. All rights reserved.
//


extension MarshaledObject {
    
    @available(*, unavailable, renamed: "value(for:)")
    public func valueForKey<A: ValueType>(_ key:KeyType) throws -> A {
        return try value(for: key)
    }

    @available(*, unavailable, renamed: "value(for:)")
    public func valueForKey<A: ValueType>(_ key:KeyType) throws -> A? {
        return try value(for: key)
    }

    @available(*, unavailable, renamed: "value(for:)")
    public func valueForKey<A: ValueType>(_ key:KeyType) throws -> [A] {
        return try value(for: key)
    }

    @available(*, unavailable, renamed: "value(for:)")
    public func valueForKey<A: ValueType>(_ key:KeyType) throws -> [A]? {
        return try value(for: key)
    }

    @available(*, unavailable, renamed: "value(for:)")
    public func valueForKey<A: ValueType>(_ key: KeyType) throws -> Set<A> {
        return try value(for: key)
    }

    @available(*, unavailable, renamed: "value(for:)")
    public func valueForKey<A: ValueType>(_ key: KeyType) throws -> Set<A>? {
        return try value(for: key)
    }

    @available(*, unavailable, renamed: "value(for:)")
    public func valueForKey<A: RawRepresentable>(_ key: KeyType) throws -> A where A.RawValue: ValueType {
        return try value(for: key)
    }

    @available(*, unavailable, renamed: "value(for:)")
    public func valueForKey<A: RawRepresentable>(for key: KeyType) throws -> A? where A.RawValue: ValueType {
        return try value(for: key)
    }

    @available(*, unavailable, renamed: "value(for:)")
    public func valueForKey<A: RawRepresentable>(_ key: KeyType) throws -> [A] where A.RawValue: ValueType {
        return try value(for: key)
    }

    @available(*, unavailable, renamed: "value(for:)")
    public func valueForKey<A: RawRepresentable>(_ key: KeyType) throws -> [A]? where A.RawValue: ValueType {
        return try value(for: key)
    }

    @available(*, unavailable, renamed: "value(for:)")
    public func valueForKey<A: RawRepresentable>(_ key: KeyType) throws -> Set<A> where A.RawValue: ValueType {
        return try value(for: key)
    }

    @available(*, unavailable, renamed: "value(for:)")
    public func valueForKey<A: RawRepresentable>(_ key: KeyType) throws -> Set<A>? where A.RawValue: ValueType {
        return try value(for: key)
    }
}
