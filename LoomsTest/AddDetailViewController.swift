//
//  AddDetailViewController.swift
//  LoomsTest
//
//  Created by Manu on 12/08/23.
//

import UIKit

class AddDetailViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField === relatedIdeaTextfield{
            if let pickerView{
                textField.text = ideas[pickerView.selectedRow(inComponent: 0)].name
                selectedRow = pickerView.selectedRow(inComponent: 0)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        relatedIdeaTextfield.text = ideas[row].name
        selectedRow = row
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        ideas[row].name
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        ideas.count
    }
    
    var ideas: [Idea]!
    var selectedRow: Int?
    var dismissed: ((_ arr:[Idea]) -> Void)?
    @IBOutlet weak var ideaNameTextfield: UITextField!
    @IBOutlet weak var relatedIdeaTextfield: UITextField!
    @IBOutlet weak var addButton: UIButton!
    var pickerView: UIPickerView? = {
        let view = UIPickerView()
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerViewSetup()
        relatedIdeaTextfield.delegate = self
        ideaNameTextfield.delegate = self
        addButton.isEnabled = false
        pickerView?.dataSource = self
        pickerView?.delegate = self
        ideaNameTextfield.addTarget(self, action: #selector(ideaValueHasChanged), for: .editingChanged)
    }
    
    func pickerViewSetup(){
        relatedIdeaTextfield.inputView = pickerView
        let numberToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        numberToolbar.barStyle = .default
        numberToolbar.items = [
        UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonPressed)),
        UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
        UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonPressed))]
        numberToolbar.sizeToFit()
        relatedIdeaTextfield.inputAccessoryView = numberToolbar
    }
    
    @objc func cancelButtonPressed() {
        relatedIdeaTextfield.text = ""
        selectedRow = nil
        view.endEditing(true)
    }
    @objc func doneButtonPressed() {
        view.endEditing(true)
    }
    
    @IBAction func addButtonPressed(){
        if let selectedRow{
            let newIdea = (Idea(name: ideaNameTextfield.text ?? "" ,linkIdea: ideas[selectedRow]))
            ideas[selectedRow].linkIdea = newIdea
            ideas.reverse()
            ideas.append(newIdea)
            ideas.reverse()
        }else{
            ideas.reverse()
            ideas.append(Idea(name: ideaNameTextfield.text ?? ""))
            ideas.reverse()
        }
        dismissed?(ideas)
        self.dismiss(animated: true)
    }
    @objc func ideaValueHasChanged(){
        if let text = ideaNameTextfield.text, text.count > 0{
            addButton.isEnabled = true
        }else{
            addButton.isEnabled = false
        }
    }
    
    func addRelatedNameToTheSelectedName(){
        guard let selectedRow = selectedRow else{
            return
        }
        
    }
    
}
