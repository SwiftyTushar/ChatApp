//
//  BaseViewController.swift
//  ChatApp
//
//  Created by Tushar Patil on 08/09/23.
//

import UIKit

class BaseViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.topItem!.title = ""
    }
}
