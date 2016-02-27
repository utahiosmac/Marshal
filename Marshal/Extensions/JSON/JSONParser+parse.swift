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


public extension JSONParser {
    public static func parse(jsonData: NSData) throws -> MarshaledObject {
        let object: Any = try NSJSONSerialization.JSONObjectWithData(jsonData, options: [])
        return try MarshaledObject.value(object)
    }
    
    public static func parse<A: ValueType>(jsonData: NSData) throws -> Array<A> {
        let object: Any = try NSJSONSerialization.JSONObjectWithData(jsonData, options: [])
        return try Array<A>.value(object)
    }
    
    public static func parse<A: ValueType>(jsonData: NSData) throws -> Set<A> {
        let object: Any = try NSJSONSerialization.JSONObjectWithData(jsonData, options: [])
        return try Set<A>.value(object)
    }
    
    // String Parsing
    public static func parse(jsonString: String, encoding: UInt = NSUTF8StringEncoding) throws -> MarshaledObject {
        guard let jsonData = jsonString.dataUsingEncoding(encoding) else {
            throw Error.TypeMismatch(expected: "\(String.self) (invalid json)", actual: jsonString.dynamicType)
        }
        return try self.parse(jsonData)
    }
    
    public static func parse<A: ValueType>(jsonString: String, encoding: UInt = NSUTF8StringEncoding) throws -> Array<A> {
        guard let jsonData = jsonString.dataUsingEncoding(encoding) else {
            throw Error.TypeMismatch(expected: "\(String.self) (invalid json)", actual: jsonString.dynamicType)
        }
        return try self.parse(jsonData)
    }
    
    public static func parse<A: ValueType>(jsonString: String, encoding: UInt = NSUTF8StringEncoding) throws -> Set<A> {
        guard let jsonData = jsonString.dataUsingEncoding(encoding) else {
            throw Error.TypeMismatch(expected: "\(String.self) (invalid json)", actual: jsonString.dynamicType)
        }
        return try self.parse(jsonData)
    }
}
