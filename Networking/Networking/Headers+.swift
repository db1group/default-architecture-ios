
import Foundation

public extension Headers {
    
    var `default`: Headers {
        
        /// Add projetct headers
        return [
            "Content-Type" : "application/json",
            "Authorization": "Bearer " + "ACCESS_TOKEN"
        ]
    }
    
}

