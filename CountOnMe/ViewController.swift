//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var negativeButton: UIButton!

    // MARK: - Properties
    private var count = Count()

    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        observerNotifications()
    }

    // MARK: - IBAction

    ///Function called when the "+/-" button is clicked.
    ///
    ///It changes the state of the button and calls the addNegative () class method.
    @IBAction func tappedNegativeButton(_ sender: UIButton) {
        if negativeButton.isSelected == false {
            count.addNegative(negative: true)
            negativeButton.isSelected = true
        } else {
            count.addNegative(negative: false)
            negativeButton.isSelected = false
        }
    }

    ///Function called when a number button is clicked.
    ///
    ///It retrieves the content of the button and sends it as a parameter to the addNumber() class method.
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        negativeButton.isSelected = false
        count.addNumber(numbers: numberText)
    }

    ///Function called when an operator button is clicked.
    ///
    ///It retrieves the content of the button and sends it as a parameter to the addOperato () class method.
    @IBAction func tappedOperatorButton(_ sender: UIButton) {
        guard let operatorText = sender.titleLabel?.text else {
            return
        }
        negativeButton.isSelected = false
        count.addOperator(operators: operatorText)
    }

    ///Function called when the AC button is clicked.
    ///
    ///It changes the state of the "+/-" button and calls the reset() class method.
    @IBAction func tappedACButton(_ sender: UIButton) {
        negativeButton.isSelected = false
        count.reset()
    }

    ///Function called when the equal button is clicked.
    ///
    ///It changes the state of the "+/-" button and calls the equal() class method.
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        negativeButton.isSelected = false
        count.equal()
    }

    // MARK: - Functions

    ///Generic function for displaying alerts.
    ///
    ///- Parameter message: The alert text message.
    func displayAlert (message: String) {
        let alertVC = UIAlertController(title: "Zéro!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }

    ///Generic functionfor observing notifications.
    func observerNotifications() {
        let displayName = Notification.Name(rawValue: "Display")
        NotificationCenter.default.addObserver(self, selector: #selector(updateScreen), name: displayName, object: nil)
        let incorrectExpressionName = Notification.Name(rawValue: "incorrectExpression")
        // swiftlint:disable:next line_length
        NotificationCenter.default.addObserver(self, selector: #selector(incorrectExpression), name: incorrectExpressionName, object: nil)
        let enterCorrectExpressionName = Notification.Name(rawValue: "enterCorrectExpression")
        // swiftlint:disable:next line_length
        NotificationCenter.default.addObserver(self, selector: #selector(enterCorrectExpression), name: enterCorrectExpressionName, object: nil)
        let startNewCalculationName = Notification.Name(rawValue: "startNewCalculation")
        // swiftlint:disable:next line_length
        NotificationCenter.default.addObserver(self, selector: #selector(startNewCalculation), name: startNewCalculationName, object: nil)
        let divisionbByZeroName = Notification.Name(rawValue: "divisionbByZero")
        // swiftlint:disable:next line_length
        NotificationCenter.default.addObserver(self, selector: #selector(divisionbByZero), name: divisionbByZeroName, object: nil)
    }

    ///Function called when observing a notification.
    ///
    ///Updating the display in the textView.
    @objc func updateScreen() {
        textView.text = count.elementString
    }

    ///Function called when observing a notification.
    ///
    ///Display of the alert with the message "Un operateur est déja mis !".
    @objc func incorrectExpression() {
        displayAlert(message: "Un operateur est déja mis !")
    }

    ///Function called when observing a notification.
    ///
    ///Display of the alert with the message "Entrez une expression correcte !".
    @objc func enterCorrectExpression() {
        displayAlert(message: "Entrez une expression correcte !")
    }

    ///Function called when observing a notification.
    ///
    ///Display of the alert with the message "Démarrez un nouveau calcul !".
    @objc func startNewCalculation() {
        displayAlert(message: "Démarrez un nouveau calcul !")
    }

    ///Function called when observing a notification.
    ///
    ///Display of the alert with the message "La division par zéro est impossible".
    @objc func divisionbByZero() {
        displayAlert(message: "La division par zéro est impossible")
    }
}
