//
//  SendMessageVC.swift
//  ChatApp
//
//  Created by Tushar Patil on 11/09/23.
//

import UIKit

class SendMessageVC: UIViewController {
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var tfMessage:UITextField!
    @IBOutlet weak var usernameLbl:UILabel!
    @IBOutlet weak var searchImg:UIImageView!
    @IBOutlet weak var backBtnImg:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtnImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backBtnAction)))
        
        tableView.register(UINib(nibName: "MessageSentTVC", bundle: nil), forCellReuseIdentifier: "MessageSentTVC")
        
        tableView.register(UINib(nibName: "MessageRecievedTVC", bundle: nil), forCellReuseIdentifier: "MessageRecievedTVC")
    }
    @IBAction func sendMessageAction(){
        
    }
    @objc func backBtnAction(){
        navigationController?.popViewController(animated: true)
    }

}
//MARK: UITableViewDelegate,UITableViewDataSource
extension SendMessageVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MessageSentTVC") as? MessageSentTVC{
                if indexPath.row == 0{
                    cell.messageTV.text = "Hi!"
                } else if indexPath.row == 2{
                    cell.messageTV.text = "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
                }
                cell.timeLbl.text = "12:59 PM"
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MessageRecievedTVC") as? MessageRecievedTVC{
                cell.messageTV.text = "Hello World!"
                return cell
            }
        }
        
        return UITableViewCell()
    }
}
