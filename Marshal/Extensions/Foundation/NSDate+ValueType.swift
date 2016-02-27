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


public extension NSDate {
    private static let ISO8601MillisecondFormatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        let timeZone = NSTimeZone(abbreviation: "GMT")
        formatter.timeZone = timeZone
        
        return formatter
    }( )
    
    private static let ISO8601SecondFormatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        let timeZone = NSTimeZone(abbreviation: "GMT")
        formatter.timeZone = timeZone
        
        return formatter
    }( )
    
    private static let ISO8601Formatters = [NSDate.ISO8601MillisecondFormatter, NSDate.ISO8601SecondFormatter]
    
    public static func fromISO8601String(dateString: String) -> NSDate? {
        for formatter in NSDate.ISO8601Formatters {
            if let date = formatter.dateFromString(dateString) {
                return date
            }
        }
        return .None
    }
}

extension NSDate: ValueType {
    public static func value(object: Any) throws -> NSDate {
        guard let dateString = object as? String else {
            throw Error.TypeMismatch(expected: self, actual: object.dynamicType)
        }
        
        var dateValue: NSDate?
        for formatter in NSDate.ISO8601Formatters {
            if let date = formatter.dateFromString(dateString) {
                dateValue = date
                break
            }
        }
        
        guard let value = dateValue else {
            throw Error.TypeMismatch(expected: self, actual: object.dynamicType)
        }
        
        return value
    }
}
