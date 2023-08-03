//
//  ProfileViewController.swift
//  rob list
//
//  Created by Viktoriya Tabunshchyk on 7/18/23.
//

import UIKit
import RealmSwift

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        menuView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 8.0).isActive = true
        menuView.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 1.0).isActive = true
        
        let settingsBtnRight = settingsButton.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -16.0)
        settingsBtnRight.priority = .defaultHigh
        settingsBtnRight.isActive = true
        let settingsBtnWidth = settingsButton.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.1)
        settingsBtnWidth.priority = .defaultHigh
        settingsBtnWidth.isActive = true
        settingsButton.imageView?.layer.transform = CATransform3DMakeScale(1.25, 1.25, 1.25)
        
        let settingsButtonWidth = settingsButton.frame.size.width
        let usernameLeft = usernameLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 16.0 + settingsButtonWidth)
        usernameLeft.priority = .defaultHigh
        usernameLeft.isActive = true
        let usernameRight = usernameLabel.rightAnchor.constraint(equalTo: settingsButton.leftAnchor)
        usernameRight.priority = .defaultHigh
        usernameRight.isActive = true
        let usernameTop = usernameLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 50.0)
        usernameTop.priority = .defaultHigh
        usernameTop.isActive = true
        usernameLabel.textAlignment = .center
        
        let pfpTop = profilePicView.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 16.0)
        pfpTop.priority = .defaultHigh
        pfpTop.isActive = true
        
        let pfpLeft = profilePicView.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 16.0)
        pfpLeft.priority = .defaultHigh
        pfpLeft.isActive = true
        
        let pfpWidth = profilePicView.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.2)
        pfpWidth.priority = .defaultHigh
        pfpWidth.isActive = true
        
        let pfpHeight = profilePicView.heightAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.2)
        pfpHeight.priority = .defaultHigh
        pfpHeight.isActive = true
        
        let numPostsBottom = numPostsLabel.bottomAnchor.constraint(equalTo: postsLabel.topAnchor, constant: -4.0)
        numPostsBottom.priority = .defaultHigh
        numPostsBottom.isActive = true
        
        let followingRight = followingLabel.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -32.0)
        followingRight.priority = .defaultHigh
        followingRight.isActive = true
        
        let allLabels = [postsLabel, followersLabel, followingLabel, numPostsLabel, numFollowersLabel, numFollowingLabel] as! [UILabel]
        for label in allLabels {
            label.textAlignment = .center
        }
        
        let pfpActualHeight = profilePicView.frame.size.height
        
        let nameTop = nameLabel.topAnchor.constraint(equalTo: profilePicView.bottomAnchor, constant: pfpActualHeight + 16.0)
        nameTop.priority = .defaultHigh
        nameTop.isActive = true
        
        let nameLeft = nameLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 16.0)
        nameLeft.priority = .defaultHigh
        nameLeft.isActive = true
        
        let bioLeft = bioLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 16.0)
        bioLeft.priority = .defaultHigh
        bioLeft.isActive = true
        
        if let app_id = Bundle.main.infoDictionary?["APP_ID"] as? String {
            let app = App(id: app_id)
            fullName = app.currentUser?.profile.name
            usernameLabel.text = fullName
        }
    }
    var realm : Realm?
    
    var fullName : String? = ""
    var profilePicUrl : String? = " "
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var menuView: UIStackView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var profilePicView: UIImageView!
    @IBOutlet weak var numPostsLabel: UILabel!
    @IBOutlet weak var postsLabel: UILabel!
    @IBOutlet weak var numFollowersLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var numFollowingLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    @IBAction func searchClick(_ sender: Any) {
        let searchPage = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        searchPage.realm = realm!
        self.present(searchPage, animated: false, completion: nil)
    }
    @IBAction func homeClick(_ sender: Any) {
        let feedPage = self.storyboard?.instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
        feedPage.realm = realm!
        self.present(feedPage, animated: false, completion: nil)
    }
    @IBAction func createPostClick(_ sender: Any) {
        let createPosePage = self.storyboard?.instantiateViewController(withIdentifier: "CreatePostViewController") as! CreatePostViewController
        createPosePage.realm = realm!
        self.present(createPosePage, animated: false, completion: nil)
    }
    @IBAction func settingsButtonClick(_ sender: Any) {
        let editProfilePage = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
        editProfilePage.realm = realm!
        self.present(editProfilePage, animated: true, completion: nil)
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
