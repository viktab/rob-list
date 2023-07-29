//
//  SearchAddViewController.swift
//  rob list
//
//  Created by Viktoriya Tabunshchyk on 7/27/23.
//

import UIKit

class SearchAddViewController: UIViewController {

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
        
        verticalView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 64.0).isActive = true
        verticalView.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 32.0).isActive = true
        verticalView.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -32.0).isActive = true
        
        textBox.layer.borderWidth = 2
        textBox.layer.borderColor = CGColor(gray: 0.25, alpha: 0.25)
        textBox.layer.cornerRadius = 5
        
        infoLabel.topAnchor.constraint(equalTo: textBox.bottomAnchor, constant: 32.0).isActive = true
        infoLabel.leftAnchor.constraint(equalTo: verticalView.leftAnchor, constant: 16.0).isActive = true
        infoLabel.rightAnchor.constraint(equalTo: verticalView.rightAnchor, constant: -16.0).isActive = true
        infoLabel.textAlignment = .center
        infoLabel.numberOfLines = 0
        
        submitButton.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 32.0).isActive = true
        submitButton.isHidden = true
        
        titleLabel.text = addType == "Group" ? "Add a new group!" : "Add a new era for " + group
    }
    
    var addType: String = ""
    var group: String = ""
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var menuView: UIStackView!
    @IBOutlet weak var verticalView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
    @IBAction func searchClick(_ sender: Any) {
        let searchPage = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        self.present(searchPage, animated: false, completion: nil)
    }
    @IBAction func homeClick(_ sender: Any) {
        let feedPage = self.storyboard?.instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
        self.present(feedPage, animated: false, completion: nil)
    }
    @IBAction func profileClick(_ sender: Any) {
        let profilePage = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        self.present(profilePage, animated: false, completion: nil)
    }
    
    
    @IBAction func textFinished(_ sender: Any) {
        let input = textBox.text
        if (input! != "") {
            submitButton.isHidden = false
            if (addType == "Group") {
                infoLabel.text = "Requesting to add \"" + input! + "\" as an artist. This may take a few days while we verify and add the artist to our database. Please double check your spelling and tap Yes to proceed."
            } else {
                infoLabel.text = "Rquesting to add \"" + input! + "\" as a new era for " + group + ". This may take a few days while we verify and add the artist to our database. Please double check your spelling and tap Submit to proceed."
            }
        }
        view.endEditing(true)
    }
    
    @IBAction func submitClick(_ sender: Any) {
        let searchPage = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        self.present(searchPage, animated: false, completion: nil)
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
