//
//  ViewController.swift
//  Ebill Calculator V2.0
//
//  Created by Himanshu Nag on 04/03/19.
//  Copyright © 2019 Saim Ahmad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var unitConsumed: UITextField!
    @IBOutlet weak var totalBill: UITextField!
    @IBOutlet weak var TMR1: UITextField!
    @IBOutlet weak var TMR2: UITextField!
    @IBOutlet weak var TMR3: UITextField!
    @IBOutlet weak var PMR1: UITextField!
    @IBOutlet weak var PMR2: UITextField!
    @IBOutlet weak var PMR3: UITextField!
    @IBOutlet weak var member1: UITextField!
    @IBOutlet weak var member2: UITextField!
    @IBOutlet weak var member3: UITextField!
    @IBOutlet weak var textView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalBill.delegate = self
        unitConsumed.delegate = self
        PMR1.delegate = self
        PMR2.delegate = self
        PMR3.delegate = self
        TMR1.delegate = self
        TMR2.delegate = self
        TMR3.delegate = self
        name.delegate = self
        member3.delegate = self
        member2.delegate = self
        member1.delegate = self
    }

    @IBAction func resetPressed(_ sender: Any) {
        
        totalBill.text = ""
        unitConsumed.text = ""
        TMR3.text = ""
        TMR1.text = ""
        TMR2.text = ""
        PMR1.text = ""
        PMR2.text = ""
        PMR3.text = ""
        member1.text = ""
        member2.text = ""
        member3.text = ""
        textView.text = ""
        name.text = ""
        
    }
    
    
    
    //to remove keyboard when touched outside text field
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        unitConsumed.resignFirstResponder()
        totalBill.resignFirstResponder()
        PMR3.resignFirstResponder()
        PMR2.resignFirstResponder()
        PMR1.resignFirstResponder()
        TMR3.resignFirstResponder()
        TMR2.resignFirstResponder()
        TMR1.resignFirstResponder()
        name.resignFirstResponder()
        member3.resignFirstResponder()
        member2.resignFirstResponder()
        member1.resignFirstResponder()
        
    }

    
    
    @IBAction func calcPressed(_ sender: Any) {
        
        //taking care of casting
        let totalbill = (Double)(totalBill.text!)
        let unitconsumed = (Double)(unitConsumed.text!)
        let pmr1 = (Double)(PMR1.text!)
        let pmr2 = (Double)(PMR2.text!)
        let pmr3 = (Double)(PMR3.text!)
        let tmr1 = (Double)(TMR1.text!)
        let tmr2 = (Double)(TMR2.text!)
        let tmr3 = (Double)(TMR3.text!)
        let Name = (Double)(name.text!)
        let Member1 = (Double)(member1.text!)
        let Member2 = (Double)(member2.text!)
        let Member3 = (Double)(member3.text!)
        
      
        
        //textfield validation -> if its empty
        if(name.text!.isEmpty || unitConsumed.text!.isEmpty || totalBill.text!.isEmpty || TMR1.text!.isEmpty || TMR2.text!.isEmpty || TMR3.text!.isEmpty || PMR1.text!.isEmpty || PMR2.text!.isEmpty || PMR3.text!.isEmpty || member1.text!.isEmpty || member2.text!.isEmpty || member3.text!.isEmpty){
            
            var myAlert = UIAlertController(title:"ALERT", message:"All fields are mandatory", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
                //self.present(myAlert, animated: true, completion: nil)
 
         }
            
        
        //Reading validation -> PMR > TMR
        else if(PMR1.text! < TMR1.text! || PMR2.text! < TMR2.text! || PMR3.text! < TMR3.text!){
            
            var myAlert = UIAlertController(title:"ALERT", message:"PMR cannot be greater than TMR", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
            
        }
        
        else{
        
        //calculating per unit cost
        let costPerUnit = (totalbill! / unitconsumed!)
        print(costPerUnit)
        
        //calc total no of members in flat
        let totalMembers = Double(Member1! + Member2! + Member3!)
        print("Total members : \(totalMembers)")

        //calc unit consumed by each room
        let unitR1 = (Double)(tmr1! - pmr1!)
        let unitR2 = (Double)(tmr2! - pmr2!)
        let unitR3 = (Double)(tmr3! - pmr3!)
        print(unitR1)
        print(unitR2)
        print(unitR3)
    
        //calc bill for each room
        let costR1 = unitR1 * costPerUnit
        let costR2 = unitR2 * costPerUnit
        let costR3 = unitR3 * costPerUnit
        print(costR1)
        print(costR2)
        print(costR3)
        
        //calc common bill for each person
        let  commonUnit = (Double)(unitconsumed! - (unitR1 + unitR2 + unitR3))
        print(commonUnit)
        let totalCommonCost = commonUnit * costPerUnit
        print(totalCommonCost)
        let commonCostPerPerson = totalCommonCost / totalMembers
        print(commonCostPerPerson)
        
        //calc final bill for each room
        
        let finalBillR1 = (Double)(costR1 + (commonCostPerPerson * Member1!))
        let finalBillR2 = (Double)(costR2 + (commonCostPerPerson * Member2!))
        let finalBillR3 = (Double)(costR3 + (commonCostPerPerson * Member3!))
        print(finalBillR1)
        print(finalBillR2)
        print(finalBillR3)
        
        textView.text = "Hi \(name.text!)!\n\nYour total Bill: \(totalBill.text!)\nYour total Common Bill: \(totalCommonCost)\n\nBill for Room1: \(finalBillR1)\nBill for Room2: \(finalBillR2)\nBill for Room3: \(finalBillR3)\n"
        
        
        
        
        
    } // calc button pressed
        
    }//end of else
    
} // end of viewController Clas



//handle the return from keyboard
extension ViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
