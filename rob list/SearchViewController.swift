//
//  SearchViewController.swift
//  rob list
//
//  Created by Viktoriya Tabunshchyk on 7/18/23.
//

import UIKit
import RealmSwift

class SearchViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    

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
        
        artistPickerView.delegate = self
        artistPickerView.dataSource = self
        pickerData = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6"]
        artistPickerView.isHidden = true
                
        let realm = try! Realm()
    }
    
    @MainActor
    func openFlexibleSyncRealm(user: User) async throws -> Realm {
        print("in openSyncedRealm")
        var config = user.flexibleSyncConfiguration()
        // Pass object types to the Flexible Sync configuration
        // as a temporary workaround for not being able to add a
        // complete schema for a Flexible Sync app.
        config.objectTypes = [Group.self, Idol.self]
        let realm = try await Realm(configuration: config, downloadBeforeOpen: .always)
        print("Successfully opened realm: \(realm)")
        let subscriptions = realm.subscriptions
        // You must add at least one subscription to read and write from a Flexible Sync realm
        // (TODO) I have no idea if I'm doing this right but it works for now lol
        try await subscriptions.update {
            subscriptions.append(
                QuerySubscription<Group> {
                    $0.name != "fake name"
                })
        }
        try await subscriptions.update {
            subscriptions.append(
                QuerySubscription<Idol> {
                    $0.name != "fake name"
                })
        }
        return realm
    }
    
    var pickerData: [String] = [String]()
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var menuView: UIStackView!
    @IBOutlet weak var verticalView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var memberLabel: UILabel!
    @IBOutlet weak var eraLabel: UILabel!
    @IBOutlet weak var artistTextBox: UITextField! {
        didSet {
            artistTextBox.delegate = self
        }
    }
    @IBOutlet weak var memberTextBox: UITextField! {
        didSet {
            memberTextBox.delegate = self
        }
    }
    @IBOutlet weak var eraTextBox: UITextField! {
        didSet {
            eraTextBox.delegate = self
        }
    }
    @IBOutlet weak var artistPickerView: UIPickerView!
    
    @IBAction func homeClick(_ sender: Any) {
        let feedPage = self.storyboard?.instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
        self.present(feedPage, animated: false, completion: nil)
    }
    
    @IBAction func profileClick(_ sender: Any) {
        let profilePage = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        self.present(profilePage, animated: false, completion: nil)
    }
    @IBAction func groupTextBoxReturn(_ sender: Any) {
        artistPickerView.isHidden = true
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

extension SearchViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
        replacementString string: String) -> Bool {
        switch textField {
            case artistTextBox:
            let oldText = textField.text!
            let newText = oldText.prefix(range.lowerBound) + string.dropFirst(0) + oldText.dropFirst(range.upperBound)
            print("changed text")
            print(oldText)
            print(newText)
            artistPickerView.isHidden = false
            default:
                print("wrong text field")
                break
            }
        return true
    }
}
