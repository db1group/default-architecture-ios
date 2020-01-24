import UIKit

extension UIAlertController {

    static func present(_ error: ErrorHandleable, on viewController: UIViewController) {
        presentOn(viewController,
                  withTitle: error.title(),
                  withMessage: error.message(),
                  withActionTitle: error.actionTitle())
    }

    static func presentOn(_ viewController: UIViewController,
                          withTitle title: String,
                          withMessage message: String,
                          withActionTitle actionTitle: String,
                          withActionHandler actionHandler: ((UIAlertAction) -> Void)? = nil,
                          onCompletion completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: actionHandler))
        viewController.present(alert, animated: true, completion: completion)
    }

    static func presentOn(_ viewController: UIViewController,
                          withTitle title: String,
                          withMessage message: String,
                          withTextField textFieldPlaceholder: String? = nil,
                          withActionTitle actionTitle: String,
                          withActionHandler actionHandler: ((UIAlertAction) -> Void)? = nil,
                          onCompletion completion: (() -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: actionHandler))
        if let textFieldPlaceholder = textFieldPlaceholder {
            alert.addTextField { textField in
                textField.placeholder = textFieldPlaceholder
            }
        }
        viewController.present(alert, animated: true, completion: completion)
        return alert
    }

    static func presentOn(_ viewController: UIViewController,
                          withTitle title: String,
                          withMessage message: String,
                          withAction1Title action1Title: String,
                          withAction1Handler action1Handler: ((UIAlertAction) -> Void)? = nil,
                          withAction2Title action2Title: String,
                          withAction2Handler action2Handler: ((UIAlertAction) -> Void)? = nil,
                          onCompletion completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: action1Title, style: .default, handler: action1Handler))
        alert.addAction(UIAlertAction(title: action2Title, style: .default, handler: action2Handler))
        DispatchQueue.main.async {
            viewController.present(alert, animated: true, completion: completion)
        }
    }

    static func presentActionSheetOn(_ viewController: UIViewController,
                                     withTitle title: String?,
                                     withMessage message: String? = nil,
                                     cancelable: Bool = false,
                                     withActions actions: [UIAlertAction],
                                     barButtonItem: UIBarButtonItem? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        actions.forEach { alert.addAction($0) }
        if cancelable {
            alert.addAction(UIAlertAction.init(title: Strings.cancel, style: .cancel, handler: nil))
        }

        // No iPad tem que apresentar a ActionSheet de forma diferente
        if let popoverPresentationController = alert.popoverPresentationController {
            if barButtonItem != nil {
                popoverPresentationController.barButtonItem = barButtonItem
            } else {
                alert.centralizeActionSheetOniPad(view: viewController.view)
            }
        }

        DispatchQueue.main.async {
            viewController.present(alert, animated: true, completion: nil)
        }
    }

    private func centralizeActionSheetOniPad(view: UIView) {
        if let popoverPresentationController = popoverPresentationController {
            popoverPresentationController.sourceView = view
            popoverPresentationController.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
            popoverPresentationController.permittedArrowDirections = []
        }
    }

}
