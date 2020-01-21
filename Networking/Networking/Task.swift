
import Foundation

/// Represents an HTTP task.
public enum Task {
    
    /// A request with no additional data.
    case requestPlain
    
    /// A request body set with `Encodable` type
    case requestJSONEncodable(Encodable)
    
    /// A requests body set with encoded parameters.
    case requestParameters(parameters: Parameters, parameterEnconding: ParameterEncoding)
    
    /// A file upload task.
    case uploadFile(URL)
    
    /// A file download task to a destination.
    case downloadDestination
}
