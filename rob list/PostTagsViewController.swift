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
                
        pickerView.delegate = self as UIPickerViewDelegate
        pickerView.dataSource = self as UIPickerViewDataSource
        self.view.addSubview(pickerView)
        pickerView.setValue(UIColor.black, forKeyPath: "textColor")
        pickerView.isHidden = true
        
        titleLabel.text = titleText
        
        // get picker data
        if tagType == "group" {
            let groups = Array(realm!.objects(Group.self))
            pickerDataAll = []
            for group in groups {
                pickerDataAll.append(group.name)
            }
            pickerData = pickerDataAll.map{$0}
        } else {
            pickerData = ["1", "2", "3"]
        }
    }
    var realm : Realm?
    
    var titleText: String = ""
    var tagType: String = ""
    var groupIds: [ObjectId] = [ObjectId]()
    var pickerDataAll: [String] = [String]()
    var pickerData: [String] = [String]()
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var mainVerticalView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textBox: UITextField!  {
        didSet {
            textBox.delegate = self
        }
    }
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var verticalListView: UIStackView!
    
    var pickerView: UIPickerView = UIPickerView()
    
    @IBAction func addClick(_ sender: Any) {
        addButton.alpha = 0.0
        addButton.isEnabled = false
        
        let newItemView: UIStackView = UIStackView()
        newItemView.axis = .horizontal
        // newItemView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        
        let itemLabel: UILabel = UILabel()
        itemLabel.text = textBox.text
        itemLabel.textColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.00)
        itemLabel.font = UIFont.systemFont(ofSize: 19.0)
        
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "xmark")
        
        let itemButton: UIButton = UIButton()
        itemButton.configuration = config
        itemButton.addTarget(self, action: #selector(deleteClick), for: .touchUpInside)

        newItemView.addArrangedSubview(itemLabel)
        newItemView.addArrangedSubview(itemButton)
        
        let hasItems = verticalListView.arrangedSubviews.count > 0
        verticalListView.addArrangedSubview(newItemView)
        if !hasItems {
            itemLabel.topAnchor.constraint(equalTo: textBox.bottomAnchor, constant: 16.0).isActive = true
        }
        itemLabel.widthAnchor.constraint(equalTo: newItemView.widthAnchor, multiplier: 0.9).isActive = true
        itemButton.widthAnchor.constraint(equalTo: newItemView.widthAnchor, multiplier: 0.1).isActive = true
        itemButton.heightAnchor.constraint(equalTo: newItemView.widthAnchor, multiplier: 0.1).isActive = true
        itemButton.imageView?.layer.transform = CATransform3DMakeScale(1.33, 1.33, 1.33)
        
        textBox.text = ""
    }
    
    @objc func deleteClick(sender:UIButton) {
        print("clicked x")
    }
    
    @IBAction func textBoxReturn(_ sender: Any) {
        textBox.text = pickerData[pickerView.selectedRow(inComponent: 0)]
        pickerView.removeFromSuperview()
        view.endEditing(true)
        if (textBox.text != nil && textBox.text != "") {
            addButton.alpha = 1.0
            addButton.isEnabled = true
        }
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
        
        pickerData = getSuggestions(String(newText), pickerDataAll)
        pickerView.reloadAllComponents()
        pickerView.selectRow(1, inComponent: 0, animated: false)
        return true
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
