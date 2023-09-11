//
//  ExtensionManager.swift
//  ChatApp
//
//  Created by Tushar Patil on 10/09/23.
//

import UIKit

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
