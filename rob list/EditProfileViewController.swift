//
//  EditProfileViewController.swift
//  rob list
//
//  Created by Viktoriya Tabunshchyk on 8/2/23.
//

import UIKit
import RealmSwift

class EditProfileViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

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
        pfpWidth.priority = .defaultHigh
        pfpWidth.isActive = true
        let pfpHeight = profilePicView.heightAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.25)
        pfpHeight.priority = .defaultHigh
        pfpHeight.isActive = true
        let pfpCenter = profilePicView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor)
        pfpCenter.priority = .defaultHigh
        pfpCenter.isActive = true
        profilePicView.layer.cornerRadius = 10
        profilePicView.clipsToBounds = true
        
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
        let bioTextBoxHeight = bioTextBox.heightAnchor.constraint(equalToConstant: 80.0)
        bioTextBoxHeight.priority = .defaultHigh
        bioTextBoxHeight.isActive = true
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
        
        let doneButtons = [usernameDoneButton, nameDoneButton, bioDoneButton]
        for button in doneButtons {
            button!.alpha = 0.0
            button!.isEnabled = false
        }
        
        let spaceLabelHeight = tagsSpaceLabel.heightAnchor.constraint(equalToConstant: 32.0)
        spaceLabelHeight.priority = .defaultHigh
        spaceLabelHeight.isActive = true
        let spaceLabelHeight2 = tagsSpaceLabel2.heightAnchor.constraint(equalToConstant: 16.0)
        spaceLabelHeight2.priority = .defaultHigh
        spaceLabelHeight2.isActive = true
        let tagsTitleLeft = tagsTitleLabel.leftAnchor.constraint(equalTo: usernameLabel.leftAnchor, constant: 0.0)
        tagsTitleLeft.priority = .defaultHigh
        tagsTitleLeft.isActive = true
        
        let tagButtons = [groupButton, memberButton]
        for button in tagButtons {
            button!.layer.borderWidth = 2
            button!.layer.borderColor = CGColor(gray: 0.75, alpha: 1.0)
            button!.layer.cornerRadius = 5
            button!.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.6).isActive = true
        }
        
        let tagLabels = [groupLabel, memberLabel]
        for label in tagLabels {
            label!.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -24.0).isActive = true
            label!.textAlignment = .right
        }
        
        let tagSpaceLabels = [vTagsLabel1, vTagsLabel2]
        for label in tagSpaceLabels {
            let labelHeight = label!.heightAnchor.constraint(equalToConstant: 8.0)
            labelHeight.priority = .defaultHigh
            labelHeight.isActive = true
        }
        
        menuView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 8.0).isActive = true
        menuView.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 1.0).isActive = true
    }
    var realm : Realm?
    
    var didChangeImage : Bool = false
    var image : UIImage?

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainVerticalView: UIStackView!
    @IBOutlet weak var profilePicView: UIImageView!
    @IBOutlet weak var editPfpButton: UIButton!
    @IBOutlet weak var usernameView: UIStackView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usernameTextBox: UITextField! {
        didSet {
            usernameTextBox.delegate = self
        }
    }
    @IBOutlet weak var usernameDoneButton: UIButton!
    @IBOutlet weak var nameView: UIStackView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextBox: UITextField! {
        didSet {
            nameTextBox.delegate = self
        }
    }
    @IBOutlet weak var nameDoneButton: UIButton!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var bioTextBox: UITextView! {
        didSet {
            bioTextBox.delegate = self
        }
    }
    @IBOutlet weak var bioDoneButton: UIButton!
    @IBOutlet weak var vLabel1: UILabel!
    @IBOutlet weak var vLabel2: UILabel!
    @IBOutlet weak var vLabel3: UILabel!
    @IBOutlet weak var hLabel1: UILabel!
    @IBOutlet weak var hLabel2: UILabel!
    @IBOutlet weak var hLabel3: UILabel!
    
    @IBOutlet weak var tagsSpaceLabel: UILabel!
    @IBOutlet weak var tagsTitleLabel: UILabel!
    @IBOutlet weak var tagsSpaceLabel2: UILabel!
    @IBOutlet weak var groupButton: UIButton!
    @IBOutlet weak var memberButton: UIButton!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var memberLabel: UILabel!
    @IBOutlet weak var vTagsLabel1: UILabel!
    @IBOutlet weak var vTagsLabel2: UILabel!
    
    @IBOutlet weak var menuView: UIStackView!
    @IBOutlet weak var cancelButton: UIButton!
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        bioDoneButton.alpha = 1.0
        bioDoneButton.isEnabled = true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == usernameTextBox {
            usernameDoneButton.alpha = 1.0
            usernameDoneButton.isEnabled = true
        } else if textField == nameTextBox {
            nameDoneButton.alpha = 1.0
            nameDoneButton.isEnabled = true
        }
    }
    
    @IBAction func usernameDoneClick(_ sender: Any) {
        usernameDoneButton.alpha = 0.0
        usernameDoneButton.isEnabled = false
        view.endEditing(true)
    }
    @IBAction func nameDoneClick(_ sender: Any) {
        nameDoneButton.alpha = 0.0
        nameDoneButton.isEnabled = false
        view.endEditing(true)
    }
    @IBAction func bioDoneClick(_ sender: Any) {
        bioDoneButton.alpha = 0.0
        bioDoneButton.isEnabled = false
        view.endEditing(true)
    }
    
    @IBAction func editPictureClick(_ sender: Any) {
        importPicture()
    }
    
    @IBAction func groupButtonClick(_ sender: Any) {
        let followingTagsPage = self.storyboard?.instantiateViewController(withIdentifier: "FollowingTagsViewController") as! FollowingTagsViewController
        followingTagsPage.realm = realm!
        self.present(followingTagsPage, animated: true, completion: nil)
    }
    
    @IBAction func idolButtonClick(_ sender: Any) {
        let followingTagsPage = self.storyboard?.instantiateViewController(withIdentifier: "FollowingTagsViewController") as! FollowingTagsViewController
        followingTagsPage.realm = realm!
        self.present(followingTagsPage, animated: true, completion: nil)
    }
    
    @IBAction func cancelClick(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        let messageAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17.0)]
          let messageString = NSAttributedString(string: "Are you sure you want to cancel edits?", attributes: messageAttributes)
        alert.setValue(messageString, forKey: "attributedMessage")
        alert.addAction(UIAlertAction(title: "Continue editing", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel edits", style: UIAlertAction.Style.default, handler: {(action) -> Void in self.closePage()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func saveClick(_ sender: Any) {
        closePage()
    }
    
    func closePage() {
        let profilePage = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        profilePage.realm = realm!
        weak var pvc = self.presentingViewController
        self.dismiss(animated: true, completion: {
            pvc?.present(profilePage, animated: false, completion: nil)
        })
    }
    
    @objc func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let uploadedImage = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true)
        profilePicView.image = uploadedImage
        profilePicView.contentMode = .scaleAspectFit
        profilePicView.layer.cornerRadius = 10
        profilePicView.clipsToBounds = true
        let pfpWidth = profilePicView.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.25)
        pfpWidth.priority = .defaultHigh
        pfpWidth.isActive = true
        didChangeImage = true
        image = uploadedImage
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
