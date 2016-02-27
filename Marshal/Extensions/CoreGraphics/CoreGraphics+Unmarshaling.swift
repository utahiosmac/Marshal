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


extension CGPoint: Unmarshaling {
    public init(object: MarshaledObject) throws {
        self.x = try object.valueForKey("x")
        self.y = try object.valueForKey("y")
    }
}

extension CGSize: Unmarshaling {
    public init(object: MarshaledObject) throws {
        let width: CGFloat = try object.valueForKey("width")
        let height: CGFloat = try object.valueForKey("height")
        
        self.width = width
        self.height = height
    }
}

extension CGRect: Unmarshaling {
    public init(object: MarshaledObject) throws {
        let x: CGFloat = try object.valueForKey("x")
        let y: CGFloat = try object.valueForKey("y")
        let width: CGFloat = try object.valueForKey("width")
        let height: CGFloat = try object.valueForKey("height")
        
        self.origin = CGPoint(x: x, y: y)
        self.size = CGSize(width: width, height: height)
    }
}

extension CGVector: Unmarshaling {
    public init(object: MarshaledObject) throws {
        let dx: CGFloat = try object.valueForKey("dx")
        let dy: CGFloat = try object.valueForKey("dy")
        
        self.dx = dx
        self.dy = dy
    }
}
