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

public typealias JSONObject = MarshaledObject


// MARK: - Parser

public struct JSONParser {
    
    private init() { }
    
    public static func JSONObjectWithData(data: NSData) throws -> JSONObject {
        let obj: Any = try NSJSONSerialization.JSONObjectWithData(data, options: [])
        return try JSONObject.value(obj)
    }
    
    public static func JSONArrayWithData(data: NSData) throws -> [JSONObject] {
        let object: AnyObject = try NSJSONSerialization.JSONObjectWithData(data, options: [])
        guard let array = object as? [JSONObject] else {
            throw Error.TypeMismatch(expected: [JSONObject].self, actual: object.dynamicType)
        }
        return array
    }
}


// MARK: - Collections

public protocol JSONCollectionType {
    func jsonData() throws -> NSData
}

extension JSONCollectionType {
    public func jsonData() throws -> NSData {
        guard let jsonCollection = self as? AnyObject else {
            throw Error.TypeMismatchWithKey(key:"", expected: AnyObject.self, actual: self.dynamicType) // shouldn't happen
        }
        return try NSJSONSerialization.dataWithJSONObject(jsonCollection, options: [])
    }
}

extension Dictionary : JSONCollectionType {}

extension Array : JSONCollectionType {}

extension Set : JSONCollectionType {}
