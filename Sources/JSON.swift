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

public typealias JSONObject = MarshalDictionary


// MARK: - Parser

public struct JSONParser {
    
    private init() { }
    
    public static func JSONObjectWithData(_ data: Data) throws -> JSONObject {
        let obj: Any = try JSONSerialization.jsonObject(with: data, options: [])
        return try JSONObject.value(obj)
    }
    
    public static func JSONArrayWithData(_ data: Data) throws -> [JSONObject] {
        let object: AnyObject = try JSONSerialization.jsonObject(with: data, options: [])
        guard let array = object as? [JSONObject] else {
            throw MarshalError.typeMismatch(expected: [JSONObject].self, actual: object.dynamicType)
        }
        return array
    }
}


// MARK: - Collections

public protocol JSONCollectionType {
    func jsonData() throws -> Data
}

extension JSONCollectionType {
    public func jsonData() throws -> Data {
        guard let jsonCollection = self as? AnyObject else {
            throw MarshalError.typeMismatchWithKey(key:"", expected: AnyObject.self, actual: self.dynamicType) // shouldn't happen
        }
        return try JSONSerialization.data(withJSONObject: jsonCollection, options: [])
    }
}

extension Dictionary : JSONCollectionType {}

extension Array : JSONCollectionType {}

extension Set : JSONCollectionType {}


// MARK: - Marshaling

public protocol JSONMarshaling {
    func jsonObject() -> JSONObject
}
