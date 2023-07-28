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
    }
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var menuView: UIStackView!
    
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
