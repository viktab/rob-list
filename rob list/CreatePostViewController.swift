//
//  CreatePostViewController.swift
//  rob list
//
//  Created by Viktoriya Tabunshchyk on 7/29/23.
//

import UIKit

class CreatePostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        menuView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 8.0).isActive = true
        menuView.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 1.0).isActive = true
        mainView.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
                
        // handle popup view
        popUpView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 200.0).isActive = true
        popUpView.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 50.0).isActive = true
        popUpView.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -50.0).isActive = true
        popUpView.layer.cornerRadius = 10
        popUpView.layer.borderColor = CGColor(gray: 0.75, alpha: 1.0)
        popUpView.layer.borderWidth = 2
        
        popUpTitle.topAnchor.constraint(equalTo: popUpView.topAnchor, constant: 24.0).isActive = true
        popUpTitle.leftAnchor.constraint(equalTo: popUpView.leftAnchor).isActive = true
        popUpTitle.rightAnchor.constraint(equalTo: popUpView.rightAnchor).isActive = true
        popUpTitle.textAlignment = .center
        
        popUpBuyBtn.topAnchor.constraint(equalTo: popUpTitle.bottomAnchor, constant: 24.0).isActive = true
        popUpSellBtn.topAnchor.constraint(equalTo: popUpBuyBtn.bottomAnchor, constant: 16.0).isActive = true
        popUpTradeBtn.topAnchor.constraint(equalTo: popUpSellBtn.bottomAnchor, constant: 16.0).isActive = true
        popUpTradeBtn.bottomAnchor.constraint(equalTo: popUpView.bottomAnchor, constant: -32.0).isActive = true
        
        let buttons = [popUpBuyBtn, popUpSellBtn, popUpTradeBtn]
        
        for button in buttons {
            button?.leftAnchor.constraint(equalTo: popUpView.leftAnchor, constant: 50.0).isActive = true
            button?.rightAnchor.constraint(equalTo: popUpView.rightAnchor, constant: -50.0).isActive = true
            button?.heightAnchor.constraint(equalTo: popUpTitle.heightAnchor, multiplier: 1.75).isActive = true
        }
        
        // handle main view
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 60).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 32.0).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -32.0).isActive = true
        titleLabel.textAlignment = .center
        
        verticalView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16.0).isActive = true
        verticalView.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 8.0).isActive = true
        verticalView.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -8.0).isActive = true
        verticalView.isHidden = true
        
        imageView.widthAnchor.constraint(equalTo: verticalView.widthAnchor, multiplier: 0.4).isActive = true
        imageView.heightAnchor.constraint(equalTo: verticalView.widthAnchor, multiplier: 0.4).isActive = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = CGColor(gray: 0.75, alpha: 1.0)
        imageView.layer.cornerRadius = 5
        
        uploadButton.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 20.0).isActive = true
        uploadButton.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: -20.0).isActive = true
        
        captionTextBox.widthAnchor.constraint(equalTo: verticalView.widthAnchor, multiplier: 0.6).isActive = true
        captionTextBox.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.66).isActive = true
        captionTextBox.backgroundColor = UIColor(named: "white")
        captionTextBox.layer.borderWidth = 1
        captionTextBox.layer.borderColor = CGColor(gray: 0.75, alpha: 1.0)
        captionTextBox.layer.cornerRadius = 5
        
        priceLabel.topAnchor.constraint(equalTo: uploadButton.bottomAnchor, constant: 16.0).isActive = true
        priceLabel.leftAnchor.constraint(equalTo: verticalView.leftAnchor, constant: 16.0).isActive = true
        priceTextBox.leftAnchor.constraint(equalTo: priceLabel.rightAnchor, constant: 16.0).isActive = true
        priceTextBox.rightAnchor.constraint(equalTo: verticalView.rightAnchor, constant: -16.0).isActive = true
        priceTextBox.layer.borderWidth = 1
        priceTextBox.layer.borderColor = CGColor(gray: 0.75, alpha: 1.0)
        priceTextBox.layer.cornerRadius = 5
    }
    
    var postType: String = ""
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var menuView: UIStackView!
    @IBOutlet weak var popUpView: UIStackView!
    @IBOutlet weak var popUpTitle: UILabel!
    @IBOutlet weak var popUpBuyBtn: UIButton!
    @IBOutlet weak var popUpSellBtn: UIButton!
    @IBOutlet weak var popUpTradeBtn: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var verticalView: UIStackView!
    @IBOutlet weak var horizontalImageCaptionView: UIStackView!
    @IBOutlet weak var verticalImageView: UIStackView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var captionTextBox: UITextView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceTextBox: UITextField!
    
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
    
    @IBAction func popUpBuyClick(_ sender: Any) {
        postType = "buy"
        hidePopUp()
    }
    @IBAction func popUpSellClick(_ sender: Any) {
        postType = "sell"
        hidePopUp()
    }
    @IBAction func popUpTradeClick(_ sender: Any) {
        postType = "trade"
        hidePopUp()
    }
    
    func hidePopUp() {
        mainView.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        popUpView.isHidden = true
        titleLabel.text = "Post to " + postType
        verticalView.isHidden = false
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