
import Foundation

extension NetworkProvider {
    
    public func requestDecodable<D: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<D, NetworkError>) -> Void) {
        return request(endpoint, completion: { result in
            switch result {
            case .success(let response):
                do {
                    let result = try response.map(D.self)
                    completion(.success(result))
                } catch {
                    completion(.failure(.underlying(error, response)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
}

/// A public function responsible for converting the result of a `URLRequest` to a Result<Networking.Response, NetworkError>.
public func convertResponseToResult(_ response: HTTPURLResponse?, request: URLRequest?, data: Data?, error: Swift.Error?) ->
    Result<Networking.Response, NetworkError> {
        switch (response, data, error) {
        case let (.some(response), data, .none):
            let response = Networking.Response(statusCode: response.statusCode, data: data ?? Data(), request: request, response: response)
            return .success(response)
        case let (.some(response), _, .some(error)):
            let response = Networking.Response(statusCode: response.statusCode, data: data ?? Data(), request: request, response: response)
            let error = NetworkError.underlying(error, response)
            return .failure(error)
        case let (_, _, .some(error)):
            let error = NetworkError.underlying(error, nil)
            return .failure(error)
        default:
            let error = NetworkError.underlying(NSError(domain: NSURLErrorDomain, code: NSURLErrorUnknown, userInfo: nil), nil)
            return .failure(error)
        }
}
