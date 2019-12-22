//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Savyasachi Jagadeeshan on 12/21/19.
//  Copyright © 2019 CodePathiOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    enum CodingKey: String {
        case tipControlKey = "Tip Control"
        case billFieldKey = "Bill Field"
        case totalLabelKey = "Total Field"
        case tipLabelKey = "Tip Label"
    }
        override func viewDidLoad() {
        super.viewDidLoad()
        self.billField.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }

    @IBAction func onTap(_ sender: Any) {  view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        
        let bill = Double(billField.text!) ?? 0
        let tipPercentages = [0.15, 0.18, 0.2]
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total  = bill + tip
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        // localize to your grouping and decimal separator
        currencyFormatter.locale = Locale.current
        
        tipLabel.text = currencyFormatter.string(from: NSNumber(value: tip))!
        totalLabel.text = currencyFormatter.string(from: NSNumber(value: total))!
    }

    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        
        coder.encode(self.tipControl.selectedSegmentIndex, forKey: CodingKey.tipControlKey.rawValue)
        coder.encode(self.totalLabel.text, forKey: CodingKey.totalLabelKey.rawValue)
        coder.encode(self.tipLabel.text, forKey: CodingKey.tipLabelKey.rawValue)
        coder.encode(self.billField.text, forKey: CodingKey.billFieldKey.rawValue)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        
        self.tipControl.selectedSegmentIndex = coder.decodeInteger(forKey: CodingKey.tipControlKey.rawValue)
        self.totalLabel.text = coder.decodeObject(forKey: CodingKey.totalLabelKey.rawValue) as? String
        self.tipLabel.text = coder.decodeObject(forKey: CodingKey.tipLabelKey.rawValue) as? String
        self.billField.text = coder.decodeObject(forKey: CodingKey.billFieldKey.rawValue) as? String
        }
    }

