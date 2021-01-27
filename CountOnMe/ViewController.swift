//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet weak var negativeButton: UIButton!
    
    private var count = Count()
    
    var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
    }
    

    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tappedNegativeButton(_ sender: UIButton) {
        if negativeButton.isSelected == false {
            //textView.text.append("-")
            negativeButton.isSelected = true
        }else {
            negativeButton.isSelected = false
        }
    }
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        if count.expressionHaveResult(elements: elements) {
            textView.text = ""
        }
        if negativeButton.isSelected == false {
            textView.text.append(numberText) } else {
                textView.text.append("-\(numberText)")
                negativeButton.isSelected = false
            }
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        if count.canAddOperator(elements: elements){
            textView.text.append(" + ")
        } else {
            return displayAlert(message: "Un operateur est déja mis !")
        }
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        if count.canAddOperator(elements: elements) {
            textView.text.append(" - ")
        } else {
            return displayAlert(message: "Un operateur est déja mis !")
        }
    }

    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        if count.canAddOperator(elements: elements) {
            textView.text.append(" ÷ ")
        } else {
            return displayAlert(message: "Un operateur est déja mis !")
        }
    }

    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        if count.canAddOperator(elements: elements) {
            textView.text.append(" x ")
        } else {
            return displayAlert(message: "Un operateur est déja mis !")
        }
    }
    
    @IBAction func tappedACButton(_ sender: UIButton) {
        textView.text.removeAll()
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard count.expressionIsCorrect(elements: elements) else {
           return displayAlert(message: "Entrez une expression correcte !")
        }
        
        guard count.expressionHaveEnoughElement(elements: elements) else {
            return displayAlert(message: "Démarrez un nouveau calcul !")
        }
        
        if let result:String = count.equal(elements: elements) {
            
            textView.text.append(" = \(result)")
        }else {
            textView.text.removeAll()
            return displayAlert(message: "Désolé votre calcul est incorrect !")
            
        }
        
        
    }
    
    func displayAlert (message:String) {
        let alertVC = UIAlertController(title: "Zéro!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }

}

