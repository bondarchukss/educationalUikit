//
//  ViewController.swift
//  ui-kit-examples
//
//  Created by Sergey Bondarchuk on 20.02.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var buttonDone: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var labelOfSwitch: UILabel!
    @IBOutlet weak var switchElement: UISwitch!
    
    var selectedElement: String?
    
    var uiElements = ["UISegmentedControl", "UISlider",
                      "UILabel", "UITextField",
                      "UIButton", "UIDatePicker"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    @IBAction func chosenSegment(_ sender: UISegmentedControl) {
        label.isHidden = false
        if segmentedControl.numberOfSegments < 3 {
            segmentedControl.insertSegment(withTitle: "First", at: 0, animated: false)
        }
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            label.text = "first"
        case 1:
            label.text = "second"
        case 2:
            label.text = "third"
        default:
            label.text = "default"
        }
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        label.isHidden = false
        label.text = String(sender.value)
    }
    
    @IBAction func doneTapted(_ sender: UIButton) {
        if let valueOfText = textField.text {
            if !valueOfText.compactMap({element in element.isLetter}).contains(false.self) {
                label.isHidden = false
                label.text = valueOfText
            } else {
                showAlert()
            }
        }
    }
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        let dateFormater = DateFormatter()
        dateFormater.dateStyle = .full
        let value = dateFormater.string(from: sender.date)
        label.isHidden = false
        label.text = value
    }
    @IBAction func actionForSwitch(_ sender: UISwitch) {
        if sender.isOn {
            labelOfSwitch.text = "all element are hidden"
            changeShownOfAllElements()
        } else {
            label.text = "all element are shown"
            changeShownOfAllElements()
        }
    }
    
    func chooseUIElement() {
        configureElementPicker()
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        uiElements.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        uiElements[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedElement = uiElements[row]
        textField.text = selectedElement
        switch row {
        case 0:
            changeShownOfAllElements()
            segmentedControl.isHidden = !segmentedControl.isHidden
        default:
            changeShownOfAllElements()
        }
    }
    
    func configure() {
        switchElement.isOn = false
        label.isHidden = false
        label.text = "some label"
        labelOfSwitch.isHidden = true
        label.textAlignment = .center
        label.numberOfLines = 10
        segmentedControl.removeSegment(at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Third", at: 2, animated: false)
        slider.minimumValue = 0
        slider.maximumValue = 100
        textField.placeholder = "Enter your name"
        buttonDone.setTitle("Done!", for: .normal)
        textField.clearButtonMode = .whileEditing
        chooseUIElement()
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "letters only", message: "Change value in textfield", preferredStyle: .alert)
        alertController.addAction(.init(title: "Ok", style: .default))
        present(alertController, animated: true)
    }
    
    func changeShownOfAllElements() {
        labelOfSwitch.isHidden = !labelOfSwitch.isHidden
        segmentedControl.isHidden = !segmentedControl.isHidden
        label.isHidden = !label.isHidden
        textField.isHidden = !textField.isHidden
        buttonDone.isHidden = !buttonDone.isHidden
        datePicker.isHidden = !datePicker.isHidden
        slider.isHidden = !slider.isHidden
    }
    
    func configureElementPicker() {
        let picker = UIPickerView()
        picker.sizeToFit()
        picker.delegate = self
        textField.inputView = picker
        configToolBar()
    }
    
    func configToolBar() {
        let bar = UIToolbar()
        bar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
        bar.setItems([doneButton], animated: true)
        bar.isUserInteractionEnabled = true
        textField.inputAccessoryView = bar
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

