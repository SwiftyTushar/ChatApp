//
//  ExtensionManager.swift
//  ChatApp
//
//  Created by Tushar Patil on 10/09/23.
//

import UIKit
//MARK: UITextField
extension UITextField{
   @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}
//MARK: UIView
extension UIView{
    func applyGradient(colours: [UIColor], cornerRadius: CGFloat?, startPoint: CGPoint, endPoint: CGPoint)  {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        if let cornerRadius = cornerRadius {
            gradient.cornerRadius = cornerRadius
        }
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.colors = colours.map { $0.cgColor }
        self.layer.insertSublayer(gradient, at: 0)
    }
}
//MARK: UISearchBar
extension UISearchBar
{
    func setPlaceholderTextColorTo(color: UIColor)
    {
        let img = searchTextField.leftView as? UIImageView
        img?.tintColor = color
        searchTextField.placeHolderColor = color

    }
    func setTextColor(color:UIColor){
        searchTextField.textColor = color
    }
}
//MARK: String
extension String {
    func isValidEmail() -> Bool {
        let emailRegex = #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#
        
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
    func isValidPassword() -> Bool {
        let minLength = 8
        let containsUppercase = self.rangeOfCharacter(from: .uppercaseLetters) != nil
        let containsLowercase = self.rangeOfCharacter(from: .lowercaseLetters) != nil
        let containsDigit = self.rangeOfCharacter(from: .decimalDigits) != nil
        let containsSpecialCharacter = self.rangeOfCharacter(from: .punctuationCharacters) != nil
        return self.count >= minLength && containsUppercase && containsLowercase && containsDigit && containsSpecialCharacter
    }
}
//MARK: Date
extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
}
