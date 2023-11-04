//
//  MessageDateView.swift
//  ChatApp
//
//  Created by Tushar Patil on 10/10/23.
//

import UIKit

class MessageDateView: UIView {
    private let dateLbl = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addChildViews()
    }
    private func addChildViews(){
        let dateView = UIView()
        addSubview(dateView)
        dateView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateView.topAnchor.constraint(equalTo: topAnchor),
            dateView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        dateView.addSubview(dateLbl)
        dateLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLbl.topAnchor.constraint(equalTo: dateView.topAnchor,constant: 5),
            dateLbl.bottomAnchor.constraint(equalTo: dateView.bottomAnchor,constant: -5),
            dateLbl.trailingAnchor.constraint(equalTo: dateView.trailingAnchor,constant: -8),
            dateLbl.leadingAnchor.constraint(equalTo: dateView.leadingAnchor,constant: 8)
        ])
        dateLbl.textAlignment = .center
        dateView.backgroundColor = .systemGray5.withAlphaComponent(0.5)
        dateView.layer.cornerRadius = 8
        dateLbl.textColor = .black
    }
    func setDate(date:Date){
        dateLbl.text = CTAppearance.getFormattedDates(date: date)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addChildViews()
    }
}
