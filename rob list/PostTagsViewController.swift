//
//  PostTagsViewController.swift
//  rob list
//
//  Created by Viktoriya Tabunshchyk on 7/31/23.
//

import UIKit
import RealmSwift

class PostTagsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

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
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 32.0).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 32.0).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -32.0).isActive = true
        titleLabel.textAlignment = .center
        
        mainVerticalView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16.0).isActive = true
        mainVerticalView.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 24.0).isActive = true
        mainVerticalView.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -24.0).isActive = true
        
        textBox.layer.borderWidth = 1
        textBox.layer.borderColor = CGColor(gray: 0.75, alpha: 1.0)
        textBox.layer.cornerRadius = 5
        textBox.autocapitalizationType = .none
        textBox.autocorrectionType = .no
        textBox.spellCheckingType = .no
        
        addButton.alpha = 0.0
        addButton.isEnabled = false
        
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -32.0).isActive = true
        doneButton.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -24.0).isActive = true
                
        pickerView.delegate = self as UIPickerViewDelegate
        pickerView.dataSource = self as UIPickerViewDataSource
        self.view.addSubview(pickerView)
        pickerView.setValue(UIColor.black, forKeyPath: "textColor")
        pickerView.isHidden = true
        
        titleLabel.text = titleText
        
        // get picker data
        allGroups = Array(realm!.objects(Group.self))
        allIdols = Array(realm!.objects(Idol.self))
        if tagType == "group" {
            pickerDataAll = []
            for group in allGroups {
                pickerDataAll.append(group.name)
            }
            pickerData = pickerDataAll.map{$0}
        } else if tagType == "member" {
            let allowedMemberIds = getMemberIdsForGroups(groupIds)
            pickerDataAll = []
            for allowedMemberId in allowedMemberIds {
                let allowedMember = allIdols.first(where: {
                    $0._id == allowedMemberId
                })
                pickerDataAll.append(allowedMember!.name)
            }
            pickerData = pickerDataAll.map{$0}
        } else {
            pickerData = ["1", "2", "3"]
        }
        
        // get existing selections
        if tagType == "group" {
            let prevSelectedGroupIdsAsStr = UserDefaults.standard.array(forKey: "PostTagesView_selectedGroupIds")
            if prevSelectedGroupIdsAsStr != nil && prevSelectedGroupIdsAsStr!.count > 0 {
                let prevSelectedGroupIdsAsStr2 = UserDefaults.standard.array(forKey: "PostTagesView_selectedGroupIds") as! [String]
                var prevSelectedGroupTagIds = [ObjectId]()
                for prev in prevSelectedGroupIdsAsStr2 {
                    try! prevSelectedGroupTagIds.append(ObjectId(string: prev))
                }
                for prevSelectedGroupId in prevSelectedGroupTagIds {
                    let group = allGroups.first(where: {
                        $0._id == prevSelectedGroupId
                    })
                    addItem(group!.name)
                }
            }
        } else if tagType == "member" {
            let prevSelectedMemberIdsAsStr = UserDefaults.standard.array(forKey: "PostTagesView_selectedMemberIds")
            if prevSelectedMemberIdsAsStr != nil && prevSelectedMemberIdsAsStr!.count > 0 {
                let prevSelectedMemberIdsAsStr2 = UserDefaults.standard.array(forKey: "PostTagesView_selectedMemberIds") as! [String]
                var prevSelectedMemberTagIds = [ObjectId]()
                for prev in prevSelectedMemberIdsAsStr2 {
                    try! prevSelectedMemberTagIds.append(ObjectId(string: prev))
                }
                for prevSelectedMemberId in prevSelectedMemberTagIds {
                    let member = allIdols.first(where: {
                        $0._id == prevSelectedMemberId
                    })
                    addItem(member!.name)
                }
            }
        }
    }
    var realm : Realm?
    
    var titleText: String = ""
    var tagType: String = ""
    
    var allGroups: [Group] = [Group]()
    var allIdols: [Idol] = [Idol]()
    
    var groupIds: [ObjectId] = [ObjectId]()
    var pickerDataAll: [String] = [String]()
    var pickerData: [String] = [String]()
    
    var selectedNames: [String] = [String]()
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var mainVerticalView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textBox: UITextField!  {
        didSet {
            textBox.delegate = self
        }
    }
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var invisibleLabel: UILabel!
    @IBOutlet weak var verticalListView: UIStackView!
    @IBOutlet weak var doneButton: UIButton!
    
    var pickerView: UIPickerView = UIPickerView()
    
    @IBAction func addClick(_ sender: Any) {
        addButton.alpha = 0.0
        addButton.isEnabled = false
        addItem(textBox.text!)
        textBox.text = ""
    }
    
    @objc func deleteClick(sender:UIButton) {
        let view = sender.superview as! UIStackView
        let idx = verticalListView.subviews.firstIndex(of: view)
        selectedNames.remove(at: idx!)
        view.removeFromSuperview()
    }
    
    @IBAction func textBoxReturn(_ sender: Any) {
        textBox.text = pickerData[pickerView.selectedRow(inComponent: 0)]
        pickerView.removeFromSuperview()
        // invisible label kinda jank way to get around constraint issues but it works I guess
        invisibleLabel.topAnchor.constraint(equalTo: textBox.bottomAnchor, constant: 16.0).isActive = true
        view.endEditing(true)
        if (textBox.text != nil && textBox.text != "") {
            addButton.alpha = 1.0
            addButton.isEnabled = true
        }
    }
    @IBAction func doneClick(_ sender: Any) {
        let createPostPage = self.storyboard?.instantiateViewController(withIdentifier: "CreatePostViewController") as! CreatePostViewController
        createPostPage.realm = realm!
        if (tagType == "group") {
            let selectedGroupIds = selectedNames.map {(groupName: String) -> ObjectId in
                return allGroups.first(where: {$0.name == groupName})!._id
            }
            createPostPage.groupTagIds = selectedGroupIds
            let groupIdsAsStr = selectedGroupIds.map({$0.stringValue})
            UserDefaults.standard.set(groupIdsAsStr, forKey: "PostTagesView_selectedGroupIds")
            let newSelectedMemberIds = getUpdatedSelectedIdols(selectedGroupIds)
            let memberIdsAsStr = newSelectedMemberIds.map({$0.stringValue})
            UserDefaults.standard.set(memberIdsAsStr, forKey: "PostTagesView_selectedMemberIds")
        } else if (tagType == "member") {
            let selectedmemberIds = selectedNames.map {(memberName: String) -> ObjectId in
                return allIdols.first(where: {$0.name == memberName})!._id
            }
            createPostPage.memberTagIds = selectedmemberIds
            let memberIdsAsStr = selectedmemberIds.map({$0.stringValue})
            UserDefaults.standard.set(memberIdsAsStr, forKey: "PostTagesView_selectedMemberIds")
        }
        UserDefaults.standard.synchronize()
        self.present(createPostPage, animated: false, completion: nil)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let newText = oldText.prefix(range.lowerBound) + string.dropFirst(0) + oldText.dropFirst(range.upperBound)
        if oldText + "\n" == newText {
            return true
        }
        mainVerticalView.insertArrangedSubview(pickerView, at: 1)
        pickerView.isHidden = false
        pickerView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.2).isActive = true
        pickerView.topAnchor.constraint(equalTo: textBox.bottomAnchor, constant: 8.0).isActive = true
        invisibleLabel.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: 16.0).isActive = true
        
        pickerData = getSuggestions(String(newText), pickerDataAll, selectedNames)
        pickerView.reloadAllComponents()
        pickerView.selectRow(1, inComponent: 0, animated: false)
        return true
    }
    
    func addItem(_ name: String) {
        let newItemView: UIStackView = UIStackView()
        newItemView.axis = .horizontal
        // newItemView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        
        let itemLabel: UILabel = UILabel()
        itemLabel.text = name
        itemLabel.textColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.00)
        itemLabel.font = UIFont.systemFont(ofSize: 19.0)
        
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "xmark")
        
        let itemButton: UIButton = UIButton()
        itemButton.configuration = config
        itemButton.addTarget(self, action: #selector(deleteClick), for: .touchUpInside)

        newItemView.addArrangedSubview(itemLabel)
        newItemView.addArrangedSubview(itemButton)
        
        verticalListView.addArrangedSubview(newItemView)
        itemLabel.widthAnchor.constraint(equalTo: newItemView.widthAnchor, multiplier: 0.9).isActive = true
        itemButton.widthAnchor.constraint(equalTo: newItemView.widthAnchor, multiplier: 0.1).isActive = true
        itemButton.heightAnchor.constraint(equalTo: newItemView.widthAnchor, multiplier: 0.1).isActive = true
        itemButton.imageView?.layer.transform = CATransform3DMakeScale(1.33, 1.33, 1.33)
        
        selectedNames.append(name)
    }
    
    func getMemberIdsForGroups(_ groupIds: [ObjectId]) -> [ObjectId] {
        var allMemberIds = [ObjectId]()
        for groupId in groupIds {
            let group = allGroups.first(where: {
                $0._id == groupId
            })
            let memberIds = group!.idols
            allMemberIds += memberIds
        }
        return allMemberIds
    }
    
    // updates selected members to only contain idols in the newly selected list of groups
    func getUpdatedSelectedIdols(_ newGroupIds: [ObjectId]) -> [ObjectId] {
        let prevSelectedMemberIdsAsStr = UserDefaults.standard.array(forKey: "PostTagesView_selectedMemberIds")
        if prevSelectedMemberIdsAsStr != nil && prevSelectedMemberIdsAsStr!.count > 0 {
            let prevSelectedMemberIdsAsStr2 = UserDefaults.standard.array(forKey: "PostTagesView_selectedMemberIds") as! [String]
            var newSelectedMemberTagIds = [ObjectId]()
            for prev in prevSelectedMemberIdsAsStr2 {
                let prevSelectedMemberId = try! ObjectId(string: prev)
                let prevSelectedMemberGroup = allIdols.first(where: {
                    $0._id == prevSelectedMemberId
                })!.group
                if newGroupIds.contains(prevSelectedMemberGroup) {
                    newSelectedMemberTagIds.append(prevSelectedMemberId)
                }
            }
            return newSelectedMemberTagIds
        }
        return [ObjectId]()
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
