//
//  GradientButton.swift
//  ChatApp
//
//  Created by Tushar Patil on 08/09/23.
//

import UIKit

class GradientButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        self.titleLabel?.textColor = .white
    }

    private lazy var gradientLayer: CAGradientLayer = {
        let l = CAGradientLayer()
        l.frame = self.bounds
        //let firstColor = #662D8C → #ED1E79
        let firstColor = #colorLiteral(red: 0.4, green: 0.1764705882, blue: 0.5490196078, alpha: 1)
        let mColor = #colorLiteral(red: 0.9294117647, green: 0.1176470588, blue: 0.4745098039, alpha: 1)
        l.colors = [firstColor.cgColor,mColor.cgColor]
        l.startPoint = CGPoint(x: 0.25, y: 0.5)
        l.endPoint = CGPoint(x: 0.75, y: 0.5)
        l.cornerRadius = 25
        layer.insertSublayer(l, at: 0)
        return l
        }()
}
