//
//  ViewController.swift
//  rob list
//
//  Created by Viktoriya Tabunshchyk on 7/17/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func signIn(_ sender: Any) {
        titleLabel.text = "clicked"
    }
    
}

