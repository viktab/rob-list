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
        
        artistpickerData = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6"]
        memberPickerData = ["Item A", "Item B", "Item C", "Item D", "Item E", "Item F"]
        eraPickerData = ["100", "200", "300", "400"]
                        
        if let app_id = Bundle.main.infoDictionary?["APP_ID"] as? String {
            app = App(id: app_id)
            Task {
                let realm = try await openFlexibleSyncRealm(user: app!.currentUser!)
                let groupObjects = realm.objects(Group.self)
                let idolObjects = realm.objects(Idol.self)
                for group in groupObjects {
                    print(group.name)
                    for idol in group.idols {
                        print(idol)
                        let idolObject = idolObjects.where {
                            $0._id == idol
                        }
                        print(idolObject[0].name)
                    }
                }
//                let idolObjects = realm.objects(Idol.self)
//                for idol in idolObjects {
//                    print(idol.name)
//                    print(idol.group)
//                }
//                let groupObjects = realm.objects(Group.self)
//                let artistsDict = groupObjects.map {
//                    [$0.name, $0._id] as [Any]
//                }
//
//                for group in groupObjects {
//                    var memberIds: List<ObjectId> = List()
//                    let groupId = group._id
//                    for idol in idolObjects {
//                        if idol.group == groupId {
//                            memberIds.append(idol._id)
//                        }
//                    }
//                    try! realm.write {
//                        group.idols = memberIds
//                    }
//                }

//                var ateezId: ObjectId = ObjectId()
//                for array in artistsDict {
//                    if array[0] as! String == "Yena" {
//                        print("updating tempestId")
//                        ateezId = array[1] as! ObjectId
//                    }
//                }
//
//                let ateezMembers = ["Yena"]
//                for name in ateezMembers {
//                    let member = Idol(name: name, group: ateezId)
//                    try! realm.write {
//                        realm.add(member)
//                    }
//                    print("added")
//                    print(name)
//                }
                
//                groupObjects.forEach { groupObj in
//                    let memberIds = groupObj.idols.map { id in
//                        ObjectId.init(string: id)
//                    }
//                    let memberObjects = realm.objects(Idol.self)
//                    let groupMemberObjects = memberObjects.where {
//                        $0._id.in(memberIds)
//                    }
//                }
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
    
    var app : App?
    
    var artistpickerData: [String] = [String]()
    var memberPickerData: [String] = [String]()
    var eraPickerData: [String] = [String]()
    
    var artists: [String] = ["ATEEZ", "TEMPEST", "ITZY", "Yena", "Xdinary Heroes", "TWICE"]
    var members: [String: [String]] = ["ATEEZ": ["Hongjoong", "Seonghwa", "Yunho", "San", "Yeosang", "Mingi", "Wooyoung", "Jongho"], "TEMPEST": ["LEW", "Hanbin", "Hyeongseop", "Hyuk", "Eunchan", "Hwarang", "Taerae"], "ITZY": ["Yeji", "Ryujin", "Chaeryeong", "Lia", "Yuna"], "Yena": ["Yena"]]
    
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
        self.present(feedPage, animated: false, completion: nil)
    }
    
    @IBAction func profileClick(_ sender: Any) {
        let profilePage = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        self.present(profilePage, animated: false, completion: nil)
    }
    @IBAction func groupTextBoxReturn(_ sender: Any) {
        artistPickerView.removeFromSuperview()
        memberLabel.topAnchor.constraint(equalTo: artistTextBox.bottomAnchor, constant: 16.0).isActive = true
        view.endEditing(true)
    }
    @IBAction func memberTextBoxReturn(_ sender: Any) {
        memberPickerView.removeFromSuperview()
        eraLabel.topAnchor.constraint(equalTo: memberTextBox.bottomAnchor, constant: 16.0).isActive = true
        view.endEditing(true)
    }
    @IBAction func eraTextBoxReturn(_ sender: Any) {
        eraPickerView.removeFromSuperview()
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
        let oldText = textField.text!
        let newText = oldText.prefix(range.lowerBound) + string.dropFirst(0) + oldText.dropFirst(range.upperBound)
        
        switch textField {
        case artistTextBox:
            verticalView.insertArrangedSubview(artistPickerView, at: 2)
            artistPickerView.isHidden = false
            artistPickerView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.2).isActive = true
            artistPickerView.topAnchor.constraint(equalTo: artistTextBox.bottomAnchor, constant: 8.0).isActive = true
            memberLabel.topAnchor.constraint(equalTo: artistPickerView.bottomAnchor, constant: 16.0).isActive = true
            artistpickerData = getSuggestions(String(newText), artists)
            artistPickerView.reloadAllComponents()
        case memberTextBox:
            verticalView.insertArrangedSubview(memberPickerView, at: 4)
            memberPickerView.isHidden = false
            memberPickerView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.2).isActive = true
            memberPickerView.topAnchor.constraint(equalTo: memberTextBox.bottomAnchor, constant: 8.0).isActive = true
            eraLabel.topAnchor.constraint(equalTo: memberPickerView.bottomAnchor, constant: 16.0).isActive = true
            memberPickerData = getSuggestions(String(newText), members["ATEEZ"]!)
            memberPickerView.reloadAllComponents()
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
    
    func getSuggestions(_ input: String, _ options: [String]) -> [String] {
        var suggestions: [String] = [String]()
        for option in options {
            if option.lowercased().hasPrefix(input.lowercased()) {
                suggestions.append(option)
            }
        }
        return suggestions
    }
}
