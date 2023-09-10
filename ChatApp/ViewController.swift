//
//  ViewController.swift
//  ChatApp
//
//  Created by Tushar Patil on 08/09/23.
//

import UIKit

class ViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let vc = storyboard?.instantiateViewController(withIdentifier: "GetStartedVC") as! GetStartedVC
        navigationController?.pushViewController(vc, animated: true)
        
    }


}

