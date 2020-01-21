
import Foundation

public struct URLParameterEncoding: ParameterEncoding {
    
    public init() { }

    public func encode(_ urlRequest: URLRequest, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = urlRequest
        guard let parameters = parameters, !parameters.isEmpty else { return urlRequest }
        
        guard let url = urlRequest.url else { throw NetworkError.missingURL }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }
        
        let contextTyperHeaderName = "Content-Type"
        if urlRequest.value(forHTTPHeaderField: contextTyperHeaderName) == nil {
            let urlEncodedType = "application/x-www-form-urlencoded; charset=utf-8"
            urlRequest.setValue(urlEncodedType, forHTTPHeaderField: contextTyperHeaderName)
        }
        return urlRequest
    }
}
