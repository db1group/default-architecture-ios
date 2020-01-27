
import Foundation

public enum NetworkError: Error {
    case encodableMapping(Error)
    case parameterEncoding(Error)
    case missingURL
    case underlying(Error, Response?)
    case noResult
    case statusCode(Response)
    case imageMapping(Response)
    case jsonMapping(Response)
    case objectMapping(Error, Response)
}
