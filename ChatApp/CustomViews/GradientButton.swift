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
        self.titleLabel?.textColor = .black
    }

    private lazy var gradientLayer: CAGradientLayer = {
        let l = CAGradientLayer()
        l.frame = self.bounds
        l.colors = [UIColor(red: 0.267, green: 0.537, blue: 0.463, alpha: 1).cgColor,
                    UIColor(red: 0.584, green: 0.929, blue: 0.773, alpha: 1).cgColor]
        l.startPoint = CGPoint(x: 0.25, y: 0.5)
        l.endPoint = CGPoint(x: 0.75, y: 0.5)
        l.cornerRadius = 25
        layer.insertSublayer(l, at: 0)
        return l
        }()
}
