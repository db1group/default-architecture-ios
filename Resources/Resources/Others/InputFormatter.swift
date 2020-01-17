import UIKit

enum InputType {
    case cpf
    case cep
    case celular
    case password
}

struct InputTypeSize {
    static let cpf = 14
    static let cep = 9
    static let celular = 17
    static let password = 6

    static func forType(_ inputType: InputType) -> Int {
        switch inputType {
        case .cpf:
            return cpf
        case .cep:
            return cep
        case .celular:
            return celular
        case .password:
            return password
        }
    }
}

class InputFormatter {

    static func formatInput(ofType type: InputType, for textField: UITextField, using string: String) -> Bool {
        guard let char = string.cString(using: String.Encoding.utf8) else { return true }
        let isBackSpace = strcmp(char, "\\b")

        if isBackSpace == -92 {
            textField.text?.removeLast()
            return false
        }

        guard let count = textField.text?.count else { return true }

        switch type {
        case .cpf:
            return formatCpf(ofInputSize: count, for: textField)
        case .cep:
            return formatCep(ofInputSize: count, for: textField)
        case .celular:
            return formatCelular(ofInputSize: count, for: textField)
        case .password:
            return formatPassword(ofInputSize: count, for: textField)
        }
    }

    // 000000 - 6 digits
    private static func formatPassword(ofInputSize count: Int, for textField: UITextField) -> Bool {
        return count < 6
    }

    // [000].[000].[000]-[00]
    private static func formatCpf(ofInputSize count: Int, for textField: UITextField) -> Bool {
        if count == 3 {
            textField.text = "\(textField.text!)."
        } else if count == 7 {
            textField.text = "\(textField.text!)."
        } else if count == 11 {
            textField.text = "\(textField.text!)-"
        } else if count > 13 {
            return false
        }
        return true
    }

    // [00000] - [000]
    private static func formatCep(ofInputSize count: Int, for textField: UITextField) -> Bool {
        if count == 5 {
            textField.text = "\(textField.text!) - "
        } else if count == 6 {
            textField.text = "\(textField.text!)- "
        } else if count == 7 {
            textField.text = "\(textField.text!) "
        } else if count > 10 {
            return false
        }
        return true
    }

    // ([00]) [00000] - [0000]
    private static func formatCelular(ofInputSize count: Int, for textField: UITextField) -> Bool {
        if count == 2 && textField.text?.first != "(" {
            textField.text = "(\(textField.text!)) "
        } else if count == 3 {
            textField.text = "\(textField.text!)) "
        } else if count == 4 {
            textField.text = "\(textField.text!) "
        } else if count == 10 {
            textField.text = "\(textField.text!) - "
        } else if count == 11 {
            textField.text = "\(textField.text!)- "
        } else if count == 12 {
            textField.text = "\(textField.text!) "
        } else if count > 16 {
            return false
        }
        return true
    }

    static func format(text: String?, ofType type: InputType) -> String? {
        guard let text = text?.onlyNumbers() else { return nil }
        switch type {
        case .cpf:
            guard text.count == Length.cpf else { return nil }
            let p1 = text[..<String.Index(utf16Offset: 3, in: text)]
            let p2 = text[String.Index(utf16Offset: 3, in: text)..<String.Index(utf16Offset: 6, in: text)]
            let p3 = text[String.Index(utf16Offset: 6, in: text)..<String.Index(utf16Offset: 9, in: text)]
            let p4 = text[String.Index(utf16Offset: 9, in: text)..<text.endIndex]
            return "\(p1).\(p2).\(p3)-\(p4)"
        case .cep:
            guard text.count == Length.cep else { return nil }
            let p1 = text[..<String.Index(utf16Offset: 5, in: text)]
            let p2 = text[String.Index(utf16Offset: 5, in: text)..<text.endIndex]
            return "\(p1) - \(p2)"
        case .celular:
            guard text.count >= Length.minimunCelular else { return nil }
            let p1 = text[..<String.Index(utf16Offset: 2, in: text)]
            let p2 = text[String.Index(utf16Offset: 2, in: text)..<String.Index(utf16Offset: 7, in: text)]
            let p3 = text[String.Index(utf16Offset: 7, in: text)..<text.endIndex]
            return "(\(p1)) \(p2) - \(p3)"
        case .password:
            return text
        }
    }
}
