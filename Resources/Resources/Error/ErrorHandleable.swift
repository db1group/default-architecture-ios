import Foundation

protocol ErrorHandleable: Error {

    func status() -> String

    func title() -> String

    func message() -> String

    func actionTitle() -> String

}
