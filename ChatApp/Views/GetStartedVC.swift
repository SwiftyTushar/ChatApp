//
//  GetStartedVC.swift
//  ChatApp
//
//  Created by Tushar Patil on 08/09/23.
//

import UIKit

class GetStartedVC: BaseViewController {
    
    @IBOutlet weak var getStartedBtn:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    @IBAction func getStartedBtnAction(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignupUserNameVC")
        navigationController?.pushViewController(vc!, animated: true)
    }

}
