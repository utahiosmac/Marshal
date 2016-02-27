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
import CoreGraphics


extension CGPoint: Marshaling {
    public func marshal() -> MarshaledObject {
        var result = MarshaledObject( )
        result["x"] = self.x
        result["y"] = self.y
        
        return result
    }
}

extension CGSize: Marshaling {
    public func marshal() -> MarshaledObject {
        var result = MarshaledObject()
        result["width"] = self.width
        result["height"] = self.height
        
        return result
    }
}

extension CGRect: Marshaling {
    public func marshal() -> MarshaledObject {
        var result = MarshaledObject()
        result["x"] = self.origin.x
        result["y"] = self.origin.y
        result["width"] = self.width
        result["height"] = self.height
        
        return result
    }
}

extension CGVector: Marshaling {
    public func marshal() -> MarshaledObject {
        var result = MarshaledObject()
        result["dx"] = self.dx
        result["dy"] = self.dy
        
        return result
    }
}
