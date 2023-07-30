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
        
    }
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var menuView: UIStackView!
    @IBOutlet weak var popUpView: UIStackView!
    @IBOutlet weak var popUpTitle: UILabel!
    @IBOutlet weak var popUpBuyBtn: UIButton!
    @IBOutlet weak var popUpSellBtn: UIButton!
    @IBOutlet weak var popUpTradeBtn: UIButton!
    
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
        mainView.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        popUpView.isHidden = true
    }
    @IBAction func popUpSellClick(_ sender: Any) {
        mainView.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        popUpView.isHidden = true
    }
    @IBAction func popUpTradeClick(_ sender: Any) {
        mainView.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        popUpView.isHidden = true
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
