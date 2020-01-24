
import Foundation

extension URL {
    
    public init(endpoint: Endpoint) {
        if endpoint.path.isEmpty {
            self = endpoint.baseURL
        } else {
            self = endpoint.baseURL.appendingPathComponent(endpoint.path)
        }
    }
    
}
