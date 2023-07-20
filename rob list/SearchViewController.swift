//
//  SearchViewController.swift
//  rob list
//
//  Created by Viktoriya Tabunshchyk on 7/18/23.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        menuView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 8.0).isActive = true
        menuView.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 1.0).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 60).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 32.0).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -32.0).isActive = true
        titleLabel.textAlignment = .center
        
        verticalView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 50.0).isActive = true
        verticalView.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 32.0).isActive = true
        verticalView.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -32.0).isActive = true
                
        let textBoxes = [artistTextBox, memberTextBox, eraTextBox]
        let labels = [artistLabel, memberLabel, eraLabel]
        var prevTextBox: UITextField?
        
        for (textBox, label) in zip(textBoxes, labels) {
            if let prev = prevTextBox {
                label!.topAnchor.constraint(equalTo: prev.bottomAnchor, constant: 16.0).isActive = true
            }
            textBox!.topAnchor.constraint(equalTo: label!.bottomAnchor, constant: 8.0).isActive = true
            textBox!.layer.borderWidth = 2
            textBox!.layer.borderColor = CGColor(gray: 0.25, alpha: 0.25)
            textBox!.layer.cornerRadius = 5
            prevTextBox = textBox!
        }
    }
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var menuView: UIStackView!
    @IBOutlet weak var verticalView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var memberLabel: UILabel!
    @IBOutlet weak var eraLabel: UILabel!
    @IBOutlet weak var artistTextBox: UITextField!
    @IBOutlet weak var memberTextBox: UITextField!
    @IBOutlet weak var eraTextBox: UITextField!
    
    @IBAction func homeClick(_ sender: Any) {
        let feedPage = self.storyboard?.instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
        self.present(feedPage, animated: false, completion: nil)
    }
    
    @IBAction func profileClick(_ sender: Any) {
        let profilePage = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        self.present(profilePage, animated: false, completion: nil)
    }
    @IBAction func groupTextBoxReturn(_ sender: Any) {
        view.endEditing(true)
    }
    @IBAction func memberTextBoxReturn(_ sender: Any) {
        view.endEditing(true)
    }
    @IBAction func eraTextBoxReturn(_ sender: Any) {
        view.endEditing(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
