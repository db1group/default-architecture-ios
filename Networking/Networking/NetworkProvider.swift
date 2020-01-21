
import Foundation

public typealias Completion = (Result<Response, NetworkError>) -> Void

public protocol NetworkProviderType {
    func request(_ endpoint: Endpoint, completion: @escaping Completion)
}

public class NetworkProvider: NetworkProviderType {

    let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }

    public func request(_ endpoint: Endpoint, completion: @escaping Completion) {
        do {
            let request = try endpoint.urlRequest()
            performRequest(request, endpoint: endpoint, completion: completion)
        } catch NetworkError.parameterEncoding(let error) {
            completion(.failure(.parameterEncoding(error)))
        } catch {
            completion(.failure(.underlying(error, nil)))
        }
    }

    private func performRequest(_ request: URLRequest, endpoint: Endpoint, completion: @escaping Completion) {
        switch endpoint.task {
        case .requestPlain, .requestJSONEncodable, .requestParameters:
            sendRequest(request, completion: completion)
        case .uploadFile(_):
            sendUploadFile(request)
        case .downloadDestination:
            sendDownloadRequest(request)
        }
    }

    private func sendRequest(_ request: URLRequest, completion: @escaping Completion) {
        print("Request = \(request)")
        let dataTask = session.dataTask(with: request) { data, response, error in
            let response = response as? HTTPURLResponse
            let result = convertResponseToResult(response, request: request, data: data, error: error)
            completion(result)
        }
        dataTask.resume()
    }

    private func sendUploadFile(_ request: URLRequest) { }

    private func sendDownloadRequest(_ request: URLRequest) { }

}
