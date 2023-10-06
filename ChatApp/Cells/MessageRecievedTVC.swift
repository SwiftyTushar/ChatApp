//
//  MessageRecievedTVC.swift
//  ChatApp
//
//  Created by Tushar Patil on 11/09/23.
//

import UIKit

class MessageRecievedTVC: UITableViewCell {
    @IBOutlet weak var messageTV:UITextView!
    @IBOutlet weak var timeLbl:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}
