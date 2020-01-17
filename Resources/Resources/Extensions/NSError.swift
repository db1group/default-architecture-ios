//
//  NSError.swift
//
//  Copyright © 2019 Monique Trevisan. All rights reserved.
//

import Foundation

public extension NSError {

    class func error(_ title: String, _ description: String) -> NSError {
        return NSError.error(code: -1, title: title, description: description)
    }

    class func error(code: NSInteger, title: String, description: String) -> NSError {
        return NSError.init(domain: title, code: code, userInfo: [NSLocalizedDescriptionKey: description])
    }

    class func error(code: NSInteger, title: String, description: String, userInfo: [AnyHashable: Any]?) -> NSError {
        var dictionary: [AnyHashable: Any] = [NSLocalizedDescriptionKey: description]
        userInfo?.forEach { (key, value) in
            dictionary[key] = value
        }
        return NSError.init(domain: title, code: code, userInfo: dictionary as? [String: Any])
    }

    // MARK: - Response Format Error

    class func responseFormatError(code: Int) -> NSError {
        return NSError.error(code: code, title: "Error", description: "Corpo da resposta de erro sem os campos esperados.")
    }

    // MARK: - Not Found

    class func notFoundError() -> NSError {
        return NSError.error(code: 404,
                             title: "Registro não encontrado",
                             description: "Por favor, tente com outros dados.")
    }

    // MARK: - Request time out

    class func timeoutError() -> NSError {
        return NSError.error(code: 504,
                             title: "Tempo de requisição esgotado",
                             description: "Verifique a conexão com a Internet e tente novamente.")
    }

    // MARK: - Unexpected Error

    class func unexpectedResponseError(code: Int = 0) -> NSError {
        return NSError.error(code: code, title: "Ops!", description: "Uma requisição mal formulada levou a uma resposta inesperada de nossos servidores.\n\nDesculpe, corrigiremos este problema o quanto antes.")
    }
}
