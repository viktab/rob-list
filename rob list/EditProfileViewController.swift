//
//  EditProfileViewController.swift
//  rob list
//
//  Created by Viktoriya Tabunshchyk on 8/2/23.
//

import UIKit
import RealmSwift

class EditProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let titleTop = titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 24.0)
        titleTop.priority = .defaultHigh
        titleTop.isActive = true
        let titleLeft = titleLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor)
        titleLeft.priority = .defaultHigh
        titleLeft.isActive = true
        let titleRight = titleLabel.rightAnchor.constraint(equalTo: mainView.rightAnchor)
        titleRight.priority = .defaultHigh
        titleRight.isActive = true
        titleLabel.textAlignment = .center
        
        let pfpTop = profilePicView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24.0)
        pfpTop.priority = .defaultHigh
        pfpTop.isActive = true
        let pfpWidth = profilePicView.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.25)
        pfpTop.priority = .defaultHigh
        pfpTop.isActive = true
        let pfpHeight = profilePicView.heightAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.25)
        pfpHeight.priority = .defaultHigh
        pfpHeight.isActive = true
        let pfpCenter = profilePicView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor)
        pfpCenter.priority = .defaultHigh
        pfpCenter.isActive = true
        
        let pfpButtonTop = editPfpButton.topAnchor.constraint(equalTo: profilePicView.bottomAnchor, constant: 8.0)
        pfpButtonTop.priority = .defaultHigh
        pfpButtonTop.isActive = true
        
        let stackViewLeft = usernameView.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 24.0)
        stackViewLeft.priority = .defaultHigh
        stackViewLeft.isActive = true
        let stackViewRight = usernameView.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -24.0)
        stackViewRight.priority = .defaultHigh
        stackViewRight.isActive = true
        
        let nameTextBoxLeft = nameTextBox.leftAnchor.constraint(equalTo: usernameTextBox.leftAnchor)
        nameTextBoxLeft.priority = .defaultHigh
        nameTextBoxLeft.isActive = true
        
        let bioTextBoxLeft = bioTextBox.leftAnchor.constraint(equalTo: usernameTextBox.leftAnchor)
        bioTextBoxLeft.priority = .defaultHigh
        bioTextBoxLeft.isActive = true
        bioTextBox.backgroundColor = UIColor(named: "white")
        
        let vSpaceLabels = [vLabel1, vLabel2, vLabel3]
        for label in vSpaceLabels {
            let labelHeight = label!.heightAnchor.constraint(equalToConstant: 16.0)
            labelHeight.priority = .defaultHigh
            labelHeight.isActive = true
        }
        
        let hSpaceLabels = [hLabel1, hLabel2, hLabel3]
        for label in hSpaceLabels {
            let labelWidth = label!.widthAnchor.constraint(equalToConstant: 8.0)
            labelWidth.priority = .defaultHigh
            labelWidth.isActive = true
        }
        
        let textBoxes = [usernameTextBox, nameTextBox, bioTextBox]
        for textBox in textBoxes {
            textBox!.layer.borderWidth = 1
            textBox!.layer.borderColor = CGColor(gray: 0.75, alpha: 1.0)
            textBox!.layer.cornerRadius = 5
        }
    }
    var realm : Realm?

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainVerticalView: UIStackView!
    @IBOutlet weak var profilePicView: UIImageView!
    @IBOutlet weak var editPfpButton: UIButton!
    @IBOutlet weak var usernameView: UIStackView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usernameTextBox: UITextField!
    @IBOutlet weak var usernameDoneButton: UIButton!
    @IBOutlet weak var nameView: UIStackView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextBox: UITextField!
    @IBOutlet weak var nameDoneButton: UIButton!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var bioTextBox: UITextView!
    @IBOutlet weak var bioDoneButton: UIButton!
    @IBOutlet weak var vLabel1: UILabel!
    @IBOutlet weak var vLabel2: UILabel!
    @IBOutlet weak var vLabel3: UILabel!
    @IBOutlet weak var hLabel1: UILabel!
    @IBOutlet weak var hLabel2: UILabel!
    @IBOutlet weak var hLabel3: UILabel!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
