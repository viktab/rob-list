//
//  PostTagsViewController.swift
//  rob list
//
//  Created by Viktoriya Tabunshchyk on 7/31/23.
//

import UIKit

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
                
        pickerView.delegate = self as UIPickerViewDelegate
        pickerView.dataSource = self as UIPickerViewDataSource
        self.view.addSubview(pickerView)
        pickerView.setValue(UIColor.black, forKeyPath: "textColor")
        pickerView.isHidden = true
        
        pickerData = ["1", "2", "3"]
        titleLabel.text = titleText
    }
    var titleText: String = ""
    var pickerData: [String] = [String]()
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var mainVerticalView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textBox: UITextField!  {
        didSet {
            textBox.delegate = self
        }
    }
    
    var pickerView: UIPickerView = UIPickerView()
    
    @IBAction func textBoxReturn(_ sender: Any) {
        pickerView.removeFromSuperview()
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        mainVerticalView.insertArrangedSubview(pickerView, at: 1)
        pickerView.isHidden = false
        pickerView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.2).isActive = true
        pickerView.topAnchor.constraint(equalTo: textBox.bottomAnchor, constant: 8.0).isActive = true
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
