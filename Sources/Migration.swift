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


extension MarshaledObject {
    
    @available(*, unavailable, renamed: "value(for:)")
    public func valueForKey<A: ValueType>(_ key:AnyHashable) throws -> A {
        return try value(for: key)
    }

    @available(*, unavailable, renamed: "value(for:)")
    public func valueForKey<A: ValueType>(_ key:AnyHashable) throws -> A? {
        return try value(for: key)
    }

    @available(*, unavailable, renamed: "value(for:)")
    public func valueForKey<A: ValueType>(_ key:AnyHashable) throws -> [A] {
        return try value(for: key)
    }

    @available(*, unavailable, renamed: "value(for:)")
    public func valueForKey<A: ValueType>(_ key:AnyHashable) throws -> [A]? {
        return try value(for: key)
    }

    @available(*, unavailable, renamed: "value(for:)")
    public func valueForKey<A: ValueType>(_ key: AnyHashable) throws -> Set<A> {
        return try value(for: key)
    }

    @available(*, unavailable, renamed: "value(for:)")
    public func valueForKey<A: ValueType>(_ key: AnyHashable) throws -> Set<A>? {
        return try value(for: key)
    }

    @available(*, unavailable, renamed: "value(for:)")
    public func valueForKey<A: RawRepresentable>(_ key: AnyHashable) throws -> A where A.RawValue: ValueType {
        return try value(for: key)
    }

    @available(*, unavailable, renamed: "value(for:)")
    public func valueForKey<A: RawRepresentable>(for key: AnyHashable) throws -> A? where A.RawValue: ValueType {
        return try value(for: key)
    }

    @available(*, unavailable, renamed: "value(for:)")
    public func valueForKey<A: RawRepresentable>(_ key: AnyHashable) throws -> [A] where A.RawValue: ValueType {
        return try value(for: key)
    }

    @available(*, unavailable, renamed: "value(for:)")
    public func valueForKey<A: RawRepresentable>(_ key: AnyHashable) throws -> [A]? where A.RawValue: ValueType {
        return try value(for: key)
    }

    @available(*, unavailable, renamed: "value(for:)")
    public func valueForKey<A: RawRepresentable>(_ key: AnyHashable) throws -> Set<A> where A.RawValue: ValueType {
        return try value(for: key)
    }

    @available(*, unavailable, renamed: "value(for:)")
    public func valueForKey<A: RawRepresentable>(_ key: AnyHashable) throws -> Set<A>? where A.RawValue: ValueType {
        return try value(for: key)
    }
}
