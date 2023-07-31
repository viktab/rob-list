//
//  CreatePostViewController.swift
//  rob list
//
//  Created by Viktoriya Tabunshchyk on 7/29/23.
//

import UIKit

class CreatePostViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {

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
        
        captionTextBox.textColor = UIColor.lightGray
        captionTextBox.text = "Caption"
        
        captionButton.topAnchor.constraint(equalTo: captionTextBox.bottomAnchor).isActive = true
        captionButton.rightAnchor.constraint(equalTo: verticalView.rightAnchor).isActive = true
        captionButton.widthAnchor.constraint(equalTo: captionTextBox.widthAnchor, multiplier: 0.25).isActive = true
        captionButton.heightAnchor.constraint(equalTo: uploadButton.heightAnchor).isActive = true
        captionButton.alpha = 0.0
        captionButton.isEnabled = false
        
        priceLabel.topAnchor.constraint(equalTo: uploadButton.bottomAnchor, constant: 32.0).isActive = true
        priceLabel.leftAnchor.constraint(equalTo: verticalView.leftAnchor, constant: 16.0).isActive = true
        priceTextBox.leftAnchor.constraint(equalTo: priceLabel.rightAnchor, constant: 16.0).isActive = true
        priceTextBox.rightAnchor.constraint(equalTo: priceButton.leftAnchor, constant: -8.0).isActive = true
        priceTextBox.layer.borderWidth = 1
        priceTextBox.layer.borderColor = CGColor(gray: 0.75, alpha: 1.0)
        priceTextBox.layer.cornerRadius = 5
        priceButton.alpha = 0.0
        priceButton.isEnabled = false
        horizontalPriceView.isHidden = true
        
        tagsLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 16.0).isActive = true
        tagsLabel.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -16.0).isActive = true
        tagsLabel.textAlignment = .center
        
        let tagButtons = [groupButton, memberButton, eraButton]
        for tagButton in tagButtons {
            tagButton!.layer.borderWidth = 2
            tagButton!.layer.borderColor = CGColor(gray: 0.75, alpha: 1.0)
            tagButton!.layer.cornerRadius = 5
            tagButton!.widthAnchor.constraint(equalTo: verticalView.widthAnchor, multiplier: 0.7).isActive = true
        }
        let tagLabels = [groupLabel, memberLabel, eraLabel]
        for label in tagLabels {
            label!.rightAnchor.constraint(equalTo: verticalView.rightAnchor, constant: -8.0).isActive = true
            label!.textAlignment = .right
        }
        groupButton.topAnchor.constraint(equalTo: tagsLabel.bottomAnchor, constant: 16.0).isActive = true
        memberButton.topAnchor.constraint(equalTo: groupButton.bottomAnchor, constant: 8.0).isActive = true
        eraButton.topAnchor.constraint(equalTo: memberButton.bottomAnchor, constant: 8.0).isActive = true
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
    @IBOutlet weak var captionTextBox: UITextView! {
        didSet {
            captionTextBox.delegate = self
        }
    }
    @IBOutlet weak var captionButton: UIButton!
    @IBOutlet weak var fakeCaptionLabel: UILabel!
    @IBOutlet weak var horizontalPriceView: UIStackView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceTextBox: UITextField! {
        didSet {
            priceTextBox.delegate = self
        }
    }
    @IBOutlet weak var priceButton: UIButton!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var groupButton: UIButton!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var memberButton: UIButton!
    @IBOutlet weak var memberLabel: UILabel!
    @IBOutlet weak var eraButton: UIButton!
    @IBOutlet weak var eraLabel: UILabel!
    
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
        horizontalPriceView.isHidden = false
        priceLabel.text = "Max price:"
        tagsLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 20.0).isActive = true
        hidePopUp()
    }
    @IBAction func popUpSellClick(_ sender: Any) {
        postType = "sell"
        horizontalPriceView.isHidden = false
        tagsLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 20.0).isActive = true
        hidePopUp()
    }
    @IBAction func popUpTradeClick(_ sender: Any) {
        postType = "trade"
        tagsLabel.topAnchor.constraint(equalTo: uploadButton.bottomAnchor, constant: 20.0).isActive = true
        hidePopUp()
    }
    
    func hidePopUp() {
        mainView.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        popUpView.isHidden = true
        titleLabel.text = "Post to " + postType
        verticalView.isHidden = false
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == captionTextBox {
            if textView.textColor == UIColor.lightGray {
                captionTextBox.textColor = UIColor.black
                captionTextBox.text = ""
            }
            captionButton.alpha = 1.0
            captionButton.isEnabled = true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == priceTextBox {
            priceButton.alpha = 1.0
            priceButton.isEnabled = true
        }
    }
    
    @IBAction func captionOkClick(_ sender: Any) {
        view.endEditing(true)
        captionButton.alpha = 0.0
        captionButton.isEnabled = false
        if captionTextBox.text == "" {
            captionTextBox.textColor = UIColor.lightGray
            captionTextBox.text = "Caption"
        }
    }
    @IBAction func priceOkClick(_ sender: Any) {
        priceButton.alpha = 0.0
        priceButton.isEnabled = false
        view.endEditing(true)
    }
    @IBAction func groupButtonClick(_ sender: Any) {
        let profilePage = self.storyboard?.instantiateViewController(withIdentifier: "PostTagsViewController") as! PostTagsViewController
        self.present(profilePage, animated: true, completion: nil)
    }
    @IBAction func memberButtonClick(_ sender: Any) {
        let profilePage = self.storyboard?.instantiateViewController(withIdentifier: "PostTagsViewController") as! PostTagsViewController
        self.present(profilePage, animated: true, completion: nil)
    }
    @IBAction func eraButtonClick(_ sender: Any) {
        let profilePage = self.storyboard?.instantiateViewController(withIdentifier: "PostTagsViewController") as! PostTagsViewController
        self.present(profilePage, animated: true, completion: nil)
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
