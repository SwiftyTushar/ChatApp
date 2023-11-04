//
//  PlaceholderView.swift
//  ChatApp
//
//  Created by Tushar Patil on 10/10/23.
//

import UIKit

class PlaceholderView: UIView {
    private let titleLbl = UILabel()
    private let messageLbl = UILabel()
    private let actionBtn = UIButton()
    var buttonClicked:(() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        placeSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        placeSubviews()
       // fatalError("init(coder:) has not been implemented")
    }
    
    private func placeSubviews(){
        backgroundColor = .clear
        addSubview(titleLbl)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLbl.topAnchor.constraint(equalTo: topAnchor,constant: 12),
            titleLbl.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLbl.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLbl.heightAnchor.constraint(equalToConstant: 35)
        ])
        titleLbl.textColor = .black
        titleLbl.textAlignment = .center
        titleLbl.text = "Title"
        titleLbl.font = UIFont.boldSystemFont(ofSize: 22)
        
        addSubview(messageLbl)
        messageLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLbl.leadingAnchor.constraint(equalTo: leadingAnchor),
            messageLbl.trailingAnchor.constraint(equalTo: trailingAnchor),
            messageLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor,constant: 8),
           // messageLbl.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        messageLbl.font = UIFont.systemFont(ofSize: 16)
        messageLbl.text = "Message"
        messageLbl.textAlignment = .center
        messageLbl.textColor = .lightGray
        messageLbl.numberOfLines = 0
    }
    func setTitleAndMessage(title:String,message:String){
        titleLbl.text = title
        messageLbl.text = message
    }
    func addCTAButton(with title:String){
        addSubview(actionBtn)
        actionBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            actionBtn.heightAnchor.constraint(equalToConstant: 40),
            actionBtn.topAnchor.constraint(equalTo: messageLbl.bottomAnchor,constant: 16),
            actionBtn.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        actionBtn.layer.cornerRadius = 20
        actionBtn.backgroundColor = .systemGray6
        actionBtn.setTitle("   \(title)   ", for: .normal)
        actionBtn.setTitleColor(.systemBlue, for: .normal)
        actionBtn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    @objc private func buttonAction(){
        buttonClicked?()
    }
}
