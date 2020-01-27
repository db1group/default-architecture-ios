
import UIKit

public struct JSONEncoding: ParameterEncoding {
    // MARK: Properties

    /// Returns a `JSONEncoding` instance with default writing options.
    public static var `default`: JSONEncoding { return JSONEncoding() }

    /// Returns a `JSONEncoding` instance with `.prettyPrinted` writing options.
    public static var prettyPrinted: JSONEncoding { return JSONEncoding(options: .prettyPrinted) }

    /// The options for writing the parameters as JSON data.
    public let options: JSONSerialization.WritingOptions

    // MARK: Initialization

    /// Creates a `JSONEncoding` instance using the specified options.
    ///
    /// - parameter options: The options for writing the parameters as JSON data.
    ///
    /// - returns: The new `JSONEncoding` instance.
    public init(options: JSONSerialization.WritingOptions = []) {
        self.options = options
    }

    // MARK: Encoding

    /// Creates a URL request by encoding parameters and applying them onto an existing request.
    ///
    /// - parameter urlRequest: The request to have parameters applied.
    /// - parameter parameters: The parameters to apply.
    ///
    /// - throws: An `Error` if the encoding process encounters an error.
    ///
    /// - returns: The encoded request.
    public func encode(_ urlRequest: URLRequest, with parameters: Parameters?) throws -> URLRequest {
        var mutableURLRequest = urlRequest
        guard let parameters = parameters else { return urlRequest }

        do {
            let data = try JSONSerialization.data(withJSONObject: parameters, options: options)

            if mutableURLRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                mutableURLRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }

            mutableURLRequest.httpBody = data
        } catch {
            throw NetworkError.parameterEncoding(error)
        }

        return mutableURLRequest
    }
}
