
import Foundation

public typealias Headers = [String: String]

public protocol Endpoint {

    var baseURL: URL { get }
    var path: String { get }
    var method: Method { get }
    var headers: Headers? { get }
    var task: Task { get }

}

extension Endpoint {
    
    func urlRequest() throws -> URLRequest {
        var request = URLRequest(url: URL(endpoint: self))
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        switch task {

        case .requestPlain, .uploadFile, .downloadDestination:
            return request
        case .requestJSONEncodable(let encodable):
            return try request.encoded(encodable: encodable)
        case .requestParameters(let parameters, let parameterEncoding):
            return try request.encoded(parameters: parameters, parameterEncoding: parameterEncoding)
        }
    }
}
