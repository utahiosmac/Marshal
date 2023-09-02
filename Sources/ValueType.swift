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


// MARK: - ValueType

public protocol ValueType {
    associatedtype Value = Self
    
    static func value(from object: Any) throws -> Value
}

extension ValueType {
    public static func value(from object: Any) throws -> Value {
        guard let objectValue = object as? Value else {
            throw MarshalError.typeMismatch(expected: Value.self, actual: type(of: object))
        }
        return objectValue
    }
}


// MARK: - ValueType Implementations

extension String: ValueType {}
extension Int: ValueType {}
extension UInt: ValueType {}
extension Bool: ValueType {}

extension Float: ValueType {
    public static func value(from object: Any) throws -> Float {
        guard let value = object as? NSNumber else {
            throw MarshalError.typeMismatch(expected: NSNumber.self, actual: type(of: object))
        }
        return value.floatValue
    }
}

extension Double: ValueType {
    public static func value(from object: Any) throws -> Double {
        guard let value = object as? NSNumber else {
            throw MarshalError.typeMismatch(expected: NSNumber.self, actual: type(of: object))
        }
        return value.doubleValue
    }
}

extension Int64: ValueType {
    public static func value(from object: Any) throws -> Int64 {
        guard let value = object as? NSNumber else {
            throw MarshalError.typeMismatch(expected: NSNumber.self, actual: type(of: object)) }
        return value.int64Value
    }
}

extension Array where Element: ValueType {
    public static func value(from object: Any, discardingErrors: Bool = false) throws -> [Element] {
        guard let anyArray = object as? [Any] else {
            throw MarshalError.typeMismatch(expected: self, actual: type(of: object))
        }
        
        if discardingErrors {
            return anyArray.compactMap {
                let value = try? Element.value(from: $0)
                guard let element = value as? Element else {
                    return nil
                }
                return element
            }
        }
        else {
            return try anyArray.map {
                let value = try Element.value(from: $0)
                guard let element = value as? Element else {
                    throw MarshalError.typeMismatch(expected: Element.self, actual: type(of: value))
                }
                return element
            }
        }
    }

    public static func value(from object: Any) throws -> [Element?] {
        guard let anyArray = object as? [Any] else {
            throw MarshalError.typeMismatch(expected: self, actual: type(of: object))
        }
        return anyArray.map {
            let value = try? Element.value(from: $0)
            guard let element = value as? Element else {
                return nil
            }
            return element
        }
    }
}

extension Dictionary where Value: ValueType {
    public static func value(from object: Any) throws -> Dictionary<Key, Value> {
        guard let objectValue = object as? [Key: Any] else {
            throw MarshalError.typeMismatch(expected: self, actual: type(of: object))
        }
        var result: [Key: Value] = [:]
        for (k, v) in objectValue {
            guard let value = try Value.value(from: v) as? Value else {
                throw MarshalError.typeMismatch(expected: Value.self, actual: type(of: any))
            }
            result[k] = value
        }
        return result
    }
}

extension Set where Element: ValueType {
    public static func value(from object: Any) throws -> Set<Element> {
        let elementArray: [Element] = try [Element].value(from: object)
        return Set<Element>(elementArray)
    }
}

extension URL: ValueType {
    public static func value(from object: Any) throws -> URL {
        guard let urlString = object as? String else {
            throw MarshalError.typeMismatch(expected: String.self, actual: type(of: object))
        }
        guard let objectValue = URL(string: urlString) else {
            throw MarshalError.typeMismatch(expected: "valid URL", actual: urlString)
        }
        return objectValue
    }
}

extension Int8: ValueType {
    public static func value(from object: Any) throws -> Int8 {
        guard let value = object as? Int else {
            throw MarshalError.typeMismatch(expected: Value.self, actual: type(of: object))
        }
        return Int8(value)
    }
}
extension Int16: ValueType {
    public static func value(from object: Any) throws -> Int16 {
        guard let value = object as? Int else {
            throw MarshalError.typeMismatch(expected: Value.self, actual: type(of: object))
        }
        return Int16(value)
    }
}
extension Int32: ValueType {
    public static func value(from object: Any) throws -> Int32 {
        guard let value = object as? Int else {
            throw MarshalError.typeMismatch(expected: Value.self, actual: type(of: object))
        }
        return Int32(value)
    }
}

extension UInt8: ValueType {
    public static func value(from object: Any) throws -> UInt8 {
        guard let value = object as? UInt else {
            throw MarshalError.typeMismatch(expected: Value.self, actual: type(of: object))
        }
        return UInt8(value)
    }
}
extension UInt16: ValueType {
    public static func value(from object: Any) throws -> UInt16 {
        guard let value = object as? UInt else {
            throw MarshalError.typeMismatch(expected: Value.self, actual: type(of: object))
        }
        return UInt16(value)
    }
}
extension UInt32: ValueType {
    public static func value(from object: Any) throws -> UInt32 {
        guard let value = object as? UInt else {
            throw MarshalError.typeMismatch(expected: Value.self, actual: type(of: object))
        }
        return UInt32(value)
    }
}
extension UInt64: ValueType {
    public static func value(from object: Any) throws -> UInt64 {
        guard let value = object as? NSNumber else {
            throw MarshalError.typeMismatch(expected: NSNumber.self, actual: type(of: object))
        }
        return value.uint64Value
    }
}

extension Character: ValueType {
    public static func value(from object: Any) throws -> Character {
        guard let value = object as? String else {
            throw MarshalError.typeMismatch(expected: Value.self, actual: type(of: object))
        }
        return Character(value)
    }
}

#if swift(>=4.1)
#else
    extension Collection {
        func compactMap<ElementOfResult>(
            _ transform: (Element) throws -> ElementOfResult?
            ) rethrows -> [ElementOfResult] {
            return try flatMap(transform)
        }
    }
#endif



extension
Date : ValueType
{
	/**
		Parses seconds since 1970.
	*/
	
	public
	static
	func
	value(from inObj: Any)
		throws
		-> Date
	{
		if let secondsSince1970 = inObj as? Double
		{
			let date = Date(timeIntervalSince1970: secondsSince1970)
			return date
		}
		else if let str = inObj as? String,
			let secondsSince1970 = Double(str)
		{
			let date = Date(timeIntervalSince1970: secondsSince1970)
			return date
		}
		
		throw MarshalError.typeMismatch(expected: Double.self, actual: type(of: inObj))
	}
}

extension
Decimal : ValueType
{
	public
	static
	func
	value(from inObj: Any)
		throws
		-> Decimal
	{
		if let jsonV = inObj as? Int
		{
			let v = Decimal(jsonV)
			return v
		}
		else if let jsonV = inObj as? Double
		{
			let v = Decimal(jsonV)
			return v
		}
		else if let str = inObj as? String,
			let v = Decimal(string: str)
		{
			return v
		}
		else if let v = inObj as? Decimal
		{
			return v
		}
		
		throw MarshalError.typeMismatch(expected: Decimal.self, actual: type(of: inObj))
	}
}

extension
UUID : ValueType
{
	public
	static
	func
	value(from inObj: Any)
		throws
		-> UUID
	{
		if let v = inObj as? UUID
		{
			return v
		}
		else if let jsonV = inObj as? String,
			let v = UUID(uuidString: jsonV)
		{
			return v
		}
		
		throw MarshalError.typeMismatch(expected: UUID.self, actual: type(of: inObj))
	}
}

extension
MarshaledObject
{
	public
	func
	value(for inKey: KeyType, dateEncoding inEncoding: Date.JSONEncoding)
		throws
		-> Date
	{
		let any = try self.any(for: inKey)
		
		switch (inEncoding)
		{
			case .secondsSince1970, .millisecondsSince1970, .secondsSinceReferenceDate:
				//	Get the time interval as a Double from either a proper number or a string…
				
				let timeInterval: Double
				if let v = any as? Double
				{
					timeInterval = v
				}
				else if let v = any as? Int
				{
					timeInterval = Double(v)
				}
				else if let s = any as? String,
					let v = Double(s)
				{
					timeInterval = v
				}
				else
				{
					throw MarshalError.typeMismatch(expected: Double.self, actual: type(of: any))
				}
				switch (inEncoding)
				{
					case .secondsSince1970:				return Date(timeIntervalSince1970: timeInterval)
					case .millisecondsSince1970:		return Date(timeIntervalSince1970: timeInterval / 1000.0)
					case .secondsSinceReferenceDate:	return Date(timeIntervalSinceReferenceDate: timeInterval)
					
					default:
						fatalError("Impossible encoding")
				}
				
			//	The date is coming in the specified (text) format…
			
			case .formatted(let format):
				let df = DateFormatter()
				df.dateFormat = format
				return try date(fromString: any, formatter: df)
			
			case .formatter(let df):
				return try date(fromString: any, formatter: df)
		}
	}
	
	func
	value(for inKey: KeyType, dateEncoding inEncoding: Date.JSONEncoding)
		throws
		-> Date?
	{
		do
		{
			let d: Date = try self.value(for: inKey, dateEncoding: inEncoding)
			return d
		}
		
		catch
		{
			return nil
		}
	}
	
	fileprivate
	func
	date(fromString inS: Any, formatter inDF: DateFormatter)
		throws
		-> Date
	{
		if let s = inS as? String,
			let date = inDF.date(from: s)
		{
			return date
		}
		else
		{
			throw MarshalError.typeMismatch(expected: String.self, actual: type(of: any))
		}
	}
}

	
extension
Date
{
	public
	enum
	JSONEncoding
	{
		case secondsSince1970
		case millisecondsSince1970
		case secondsSinceReferenceDate
		case formatted(String)
		case formatter(DateFormatter)
	}
}

/*
	I can't make the following work, in that Marshal never calls it.
	I think it's a bug in Marshal, because it takes a slightly inconsistent
	path when using Context.
*/

#if false
protocol
MarshalDateDeserializationContext
{
	var		dateFormat: MarshalDateFormat { get set }
}

enum
MarshalDateFormat
{
	case secondsSince1970
	case millisecondsSince1970
}

public
struct
AuctionDeserializationContext : MarshalDateDeserializationContext
{
	var		dateFormat				=	MarshalDateFormat.millisecondsSince1970
}

extension
Date : UnmarshalingWithContext
{
	public
	static
	func
	value(from inObj: MarshaledObject, inContext: AuctionDeserializationContext)
		throws
		-> Date
	{
		return Date()
	}
}
#endif
