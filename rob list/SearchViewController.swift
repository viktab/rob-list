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
        // todo cleanup with mapping pickerview -> pickerdata
        switch pickerView {
        case artistPickerView:
            return artistpickerData.count
        case memberPickerView:
            return memberPickerData.count
        case eraPickerView:
            return eraPickerData.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // todo cleanup with mapping pickerview -> pickerdata
        switch pickerView {
        case artistPickerView:
            return artistpickerData[row]
        case memberPickerView:
            return memberPickerData[row]
        case eraPickerView:
            return eraPickerData[row]
        default:
            return ""
        }
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
            textBox!.autocapitalizationType = .none
            textBox!.autocorrectionType = .no
            textBox!.spellCheckingType = .no
            prevTextBox = textBox!
        }
        
        let pickerViews = [artistPickerView, memberPickerView, eraPickerView] as [UIPickerView]
        
        for pickerView in pickerViews {
            pickerView.delegate = self as UIPickerViewDelegate
            pickerView.dataSource = self as UIPickerViewDataSource
            self.view.addSubview(pickerView)
            pickerView.setValue(UIColor.black, forKeyPath: "textColor")
            pickerView.isHidden = true
        }
        
        artistpickerData = [""]
        memberPickerData = [""]
        eraPickerData = [""]
        
        let groupText = UserDefaults.standard.string(forKey: "SearchView_artist")
        if groupText != nil {
            artistTextBox.text = groupText
        }
        
        let memberText = UserDefaults.standard.string(forKey: "SearchView_member")
        if memberText != nil {
            memberTextBox.text = memberText
        }
        
        let eraText = UserDefaults.standard.string(forKey: "SearchView_era")
        if eraText != nil {
            eraTextBox.text = eraText
        }
                        
        if let app_id = Bundle.main.infoDictionary?["APP_ID"] as? String {
            app = App(id: app_id)
            Task {
                realm = try await openFlexibleSyncRealm(user: app!.currentUser!)
                groups = Array(realm!.objects(Group.self))
                idolsCollection = realm!.objects(Idol.self)
                idols = Array(idolsCollection!)
            }
        }
    }
    
    @MainActor
    func openFlexibleSyncRealm(user: User) async throws -> Realm {
        print("in openSyncedRealm")
        var config = user.flexibleSyncConfiguration()
        // Pass object types to the Flexible Sync configuration
        // as a temporary workaround for not being able to add a
        // complete schema for a Flexible Sync app.
        config.objectTypes = [Group.self, Idol.self, RequestedGroup.self]
        let openRealm = try await Realm(configuration: config, downloadBeforeOpen: .always)
        print("Successfully opened realm: \(openRealm)")
        let subscriptions = openRealm.subscriptions
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
        try await subscriptions.update {
            subscriptions.append(
                QuerySubscription<RequestedGroup> {
                    $0.name != "fake name"
                })
        }
        return openRealm
    }
    
    var app : App?
    var realm : Realm?
    
    var artistpickerData: [String] = [String]()
    var memberPickerData: [String] = [String]()
    var eraPickerData: [String] = [String]()
    
    var groups: [Group] = []
    var idols: [Idol] = []
    var idolsCollection: Results<Idol>?
    
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
    var artistPickerView: UIPickerView = UIPickerView()
    var memberPickerView: UIPickerView = UIPickerView()
    var eraPickerView: UIPickerView = UIPickerView()
    
    @IBAction func homeClick(_ sender: Any) {
        let feedPage = self.storyboard?.instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
        feedPage.realm = realm!
        self.present(feedPage, animated: false, completion: nil)
    }
    @IBAction func createPostClick(_ sender: Any) {
        let createPostPage = self.storyboard?.instantiateViewController(withIdentifier: "CreatePostViewController") as! CreatePostViewController
        createPostPage.realm = realm!
        self.present(createPostPage, animated: false, completion: nil)
    }
    
    @IBAction func profileClick(_ sender: Any) {
        let profilePage = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        profilePage.realm = realm!
        self.present(profilePage, animated: false, completion: nil)
    }
    @IBAction func groupTextBoxReturn(_ sender: Any) {
        let oldGroup = artistTextBox.text
        let newGroup = artistpickerData[artistPickerView.selectedRow(inComponent: 0)]
        if oldGroup != newGroup {
            memberTextBox.text = ""
        }
        artistTextBox.text = newGroup
        artistPickerView.removeFromSuperview()
        memberLabel.topAnchor.constraint(equalTo: artistTextBox.bottomAnchor, constant: 16.0).isActive = true
        view.endEditing(true)
        UserDefaults.standard.set(newGroup, forKey: "SearchView_artist")
        UserDefaults.standard.synchronize()
    }
    @IBAction func memberTextBoxReturn(_ sender: Any) {
        memberTextBox.text = memberPickerData[memberPickerView.selectedRow(inComponent: 0)]
        memberPickerView.removeFromSuperview()
        eraLabel.topAnchor.constraint(equalTo: memberTextBox.bottomAnchor, constant: 16.0).isActive = true
        view.endEditing(true)
        UserDefaults.standard.set(memberTextBox.text, forKey: "SearchView_member")
        UserDefaults.standard.synchronize()
    }
    @IBAction func eraTextBoxReturn(_ sender: Any) {
        eraPickerView.removeFromSuperview()
        view.endEditing(true)
        UserDefaults.standard.set(eraTextBox.text, forKey: "SearchView_era")
        UserDefaults.standard.synchronize()
    }
    @IBAction func addGroup(_ sender: Any) {
        let addPage = self.storyboard?.instantiateViewController(withIdentifier: "SearchAddViewController") as! SearchAddViewController
        addPage.addType = "Group"
        addPage.realm = realm!
        self.present(addPage, animated: true, completion: nil)
    }
    @IBAction func addEra(_ sender: Any) {
        let group = artistTextBox.text
        if group == "" {
            // TODO: tell user that valid group must be selected
            return
        }
        let addPage = self.storyboard?.instantiateViewController(withIdentifier: "SearchAddViewController") as! SearchAddViewController
        addPage.addType = "Era"
        addPage.group = group!
        addPage.realm = realm!
        self.present(addPage, animated: true, completion: nil)
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
        let oldText = textField.text!
        let newText = oldText.prefix(range.lowerBound) + string.dropFirst(0) + oldText.dropFirst(range.upperBound)
        if oldText + "\n" == newText {
            return true
        }
        switch textField {
        case artistTextBox:
            verticalView.insertArrangedSubview(artistPickerView, at: 2)
            artistPickerView.isHidden = false
            artistPickerView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.2).isActive = true
            artistPickerView.topAnchor.constraint(equalTo: artistTextBox.bottomAnchor, constant: 8.0).isActive = true
            memberLabel.topAnchor.constraint(equalTo: artistPickerView.bottomAnchor, constant: 16.0).isActive = true
            
            var groupNames: [String] = []
            for group in groups {
                groupNames.append(group.name)
            }
            artistpickerData = getSuggestions(String(newText), groupNames)
            artistPickerView.reloadAllComponents()
            artistPickerView.selectRow(1, inComponent: 0, animated: false)
        case memberTextBox:
            verticalView.insertArrangedSubview(memberPickerView, at: 4)
            memberPickerView.isHidden = false
            memberPickerView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.2).isActive = true
            memberPickerView.topAnchor.constraint(equalTo: memberTextBox.bottomAnchor, constant: 8.0).isActive = true
            eraLabel.topAnchor.constraint(equalTo: memberPickerView.bottomAnchor, constant: 16.0).isActive = true
            
            let memberNames = getMembers()
            memberPickerData = getSuggestions(String(newText),  memberNames)
            memberPickerView.reloadAllComponents()
            memberPickerView.selectRow(1, inComponent: 0, animated: false)
        case eraTextBox:
            verticalView.insertArrangedSubview(eraPickerView, at: 6)
            eraPickerView.isHidden = false
            eraPickerView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.2).isActive = true
            eraPickerView.topAnchor.constraint(equalTo: eraTextBox.bottomAnchor, constant: 8.0).isActive = true
        default:
            print("wrong text field")
            break
        }
        return true
    }
    
    func getMembers() -> [String] {
        let groupName = artistTextBox.text
        let groupObj = groups.first(where: {$0.name == groupName})
        let memberIds = groupObj!.idols
        let memberNames = idolsCollection!.where{
            $0._id.in(memberIds)
        }.map({$0.name})
        return Array(memberNames)
    }
}
