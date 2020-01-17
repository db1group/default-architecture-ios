//
//  String.swift
//
//  Created by Monique Trevisan on 02/09/19.
//  Copyright © 2019 Monique Trevisan. All rights reserved.
//

import Foundation

extension String {

    func onlyNumbers() -> String {
        guard !isEmpty else { return "" }
        return replacingOccurrences(of: "\\D",
                                    with: "",
                                    options: .regularExpression,
                                    range: startIndex..<endIndex)
    }

    // MARK: - Validação de CPF
    var isCPF: Bool {
        let cpf = self.onlyNumbers()
        guard cpf.count == 11 else { return false }

        let i1 = cpf.index(cpf.startIndex, offsetBy: 9)
        let i2 = cpf.index(cpf.startIndex, offsetBy: 10)
        let i3 = cpf.index(cpf.startIndex, offsetBy: 11)
        let d1 = Int(cpf[i1..<i2])
        let d2 = Int(cpf[i2..<i3])

        var temp1 = 0, temp2 = 0

        for i in 0...8 {
            let start = cpf.index(cpf.startIndex, offsetBy: i)
            let end = cpf.index(cpf.startIndex, offsetBy: i+1)
            let char = Int(cpf[start..<end])

            temp1 += char! * (10 - i)
            temp2 += char! * (11 - i)
        }

        temp1 %= 11
        temp1 = temp1 < 2 ? 0 : 11-temp1

        temp2 += temp1 * 2
        temp2 %= 11
        temp2 = temp2 < 2 ? 0 : 11-temp2

        return temp1 == d1 && temp2 == d2
    }

    // MARK: - Validação de CNPJ
    var isCNPJ: Bool {
        if self.count != 14 {
            return false
        }

        if self == "00000000000000" {
            return false
        }

        if self == "11111111111111" {
            return false
        }

        if self == "22222222222222" {
            return false
        }

        if self == "33333333333333" {
            return false
        }

        if self == "44444444444444" {
            return false
        }

        if self == "55555555555555" {
            return false
        }

        if self == "66666666666666" {
            return false
        }

        if self == "77777777777777" {
            return false
        }

        if self == "88888888888888" {
            return false
        }

        if self == "99999999999999" {
            return false
        }

        var input: String = ""
        input = self

        let cnpj = input.filter{"0123456789".contains($0)}


        var isValidCNPJ: Bool {
            let numbers = cnpj.compactMap({Int(String($0))})
            guard numbers.count == 14 && Set(numbers).count != 1 else { return false }
            let soma1 = 11 - ( numbers[11] * 2 +
                numbers[10] * 3 +
                numbers[9] * 4 +
                numbers[8] * 5 +
                numbers[7] * 6 +
                numbers[6] * 7 +
                numbers[5] * 8 +
                numbers[4] * 9 +
                numbers[3] * 2 +
                numbers[2] * 3 +
                numbers[1] * 4 +
                numbers[0] * 5 ) % 11
            let dv1 = soma1 > 9 ? 0 : soma1
            let soma2 = 11 - ( numbers[12] * 2 +
                numbers[11] * 3 +
                numbers[10] * 4 +
                numbers[9] * 5 +
                numbers[8] * 6 +
                numbers[7] * 7 +
                numbers[6] * 8 +
                numbers[5] * 9 +
                numbers[4] * 2 +
                numbers[3] * 3 +
                numbers[2] * 4 +
                numbers[1] * 5 +
                numbers[0] * 6 ) % 11
            let dv2 = soma2 > 9 ? 0 : soma2
            return dv1 == numbers[12] && dv2 == numbers[13]
        }

        return isValidCNPJ

    }

    var isEmail: Bool {
         if self.isEmpty {
             return false
         }
         let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
         let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
         return emailTest.evaluate(with: self)
     }

     func formatCurrency(value: Double) -> String {
         let formatter = NumberFormatter()
         formatter.numberStyle = .currency
         formatter.locale = Locale(identifier: "pt_BR")
         return formatter.string(from: NSNumber(value: value)) ?? "R$0,00"
     }

    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    func toDate(formato: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formato
        return dateFormatter.date(from: self)!
    }

    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }

    var isPassword: Bool {
        guard self.count == 6 else { return false }
        return true
    }
}
