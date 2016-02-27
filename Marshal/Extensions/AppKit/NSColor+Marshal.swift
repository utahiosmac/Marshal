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


#if os(OSX)
import Foundation
import AppKit


extension NSColor: ValueType {
    public static func value(object: Any) throws -> NSColor {
        guard let colorValues = object as? MarshaledObject else {
            throw Error.TypeMismatch(expected: self, actual: object.dynamicType)
        }
        
        let red: CGFloat? = try colorValues.valueForKey("red")
        let green: CGFloat? = try colorValues.valueForKey("green")
        let blue: CGFloat? = try colorValues.valueForKey("blue")
        let alpha: CGFloat? = try colorValues.valueForKey("alpha")
        
        return NSColor(red: red ?? 0.0, green: green ?? 0.0, blue: blue ?? 0.0, alpha: alpha ?? 1.0)
    }
}

extension NSColor: Marshaling {
    public func marshal() -> MarshaledObject {
        var result = MarshaledObject()
        result["red"] = self.redComponent
        result["green"] = self.greenComponent
        result["blue"] = self.blueComponent
        result["alpha"] = self.alphaComponent
        
        return result
    }
}
#endif
