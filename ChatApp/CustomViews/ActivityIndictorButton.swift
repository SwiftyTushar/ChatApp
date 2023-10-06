//
//  ActivityIndictorButton.swift
//  ChatApp
//
//  Created by Tushar Patil on 03/10/23.
//

import UIKit

class ActivityIndictorButton: UIButton {
    private let indicatorView = UIActivityIndicatorView(style: .medium)
    private var previousImg:UIImage?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addSubview(indicatorView)
        indicatorView.color = .white
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        previousImg = self.image(for: .normal)
        indicatorView.frame = bounds
    }
    func showLoader(){
        self.setImage(nil, for: .normal)
        indicatorView.startAnimating()
        indicatorView.isHidden = false
    }
    func hideLoader(){
        self.setImage(previousImg, for: .normal)
        indicatorView.isHidden = true
    }
}
