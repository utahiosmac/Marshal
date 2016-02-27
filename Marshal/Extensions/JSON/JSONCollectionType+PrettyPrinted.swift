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


public extension JSONCollectionType {
    public func jsonData(prettyPrinted: Bool) throws -> NSData {
        guard let object = self as? AnyObject else {
            throw Error.TypeMismatch(expected: AnyObject.self, actual: self.dynamicType)
        }
        guard NSJSONSerialization.isValidJSONObject(object) else {
            throw Error.TypeMismatch(expected: "\(AnyObject.self) (invalid json)", actual: self.dynamicType)
        }
        
        let options: NSJSONWritingOptions = prettyPrinted ? .PrettyPrinted : []
        return try NSJSONSerialization.dataWithJSONObject(object, options: options)
    }
    
    public func jsonString(prettyPrinted: Bool = false, encoding: UInt = NSUTF8StringEncoding) throws -> String {
        let data = try self.jsonData(prettyPrinted)
        return String(data: data, encoding: encoding) ?? ""
    }
}
