//
//  ChatUserTVC.swift
//  ChatApp
//
//  Created by Tushar Patil on 10/09/23.
//

import UIKit

class ChatUserTVC: UITableViewCell {
    @IBOutlet weak var usernameLbl:UILabel!
    @IBOutlet weak var lastMsgLbl:UILabel!
    @IBOutlet weak var profilePicImg:UIImageView!
    @IBOutlet weak var timeLbl:UILabel!
    @IBOutlet weak var newMsgLbl:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        profilePicImg.layer.cornerRadius = profilePicImg.frame.height/2
    }
}
