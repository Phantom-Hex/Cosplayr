//
//  ConLoginViewController.swift
//  Cosplayr
//
//  Created by Tony T. on 7/13/17.
//  Copyright © 2017 Phantom Hex. All rights reserved.
//

import UIKit

class ConLoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var forgotDetailButton: UIButton!
    @IBAction func signInButton(_ sender: Any) {
        signInAction()
    }
    
    var networkingService = ConServices()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    func signInAction() {
        let email = emailTextField.text!.lowercased()
        let finalEmail = email.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let password = passwordTextField.text!
        
        if finalEmail.isEmpty || password.isEmpty {
            
        } else {
            if isValidEmail(email: finalEmail) {
                self.networkingService.signIn(email: finalEmail, password: password)
            }
        }
        self.view.endEditing(true)
    }
}

extension ConLoginViewController {
    
    @IBAction func unwindToLogin(_ storyboardSegue: UIStoryboardSegue){}
    
    private func hideForgotDetailButton(isHidden: Bool){
        self.forgotDetailButton.isHidden = isHidden
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animateView(up: true, moveValue: 80)
        hideForgotDetailButton(isHidden: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        animateView(up: false, moveValue:
            80)
        hideForgotDetailButton(isHidden: false)
    }
    
    // Move the View Up & Down when the Keyboard appears
    func animateView(up: Bool, moveValue: CGFloat){
        
        let movementDuration: TimeInterval = 0.3
        let movement: CGFloat = (up ? -moveValue : moveValue)
        UIView.beginAnimations("animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
        
        
    }
    
    @objc func hideKeyboardOnTap(){
        self.view.endEditing(true)
        
    }
    
//    func setTapGestureRecognizerOnView(){
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.hideKeyboardOnTap))
//        tapGesture.numberOfTapsRequired = 1
//        self.view.addGestureRecognizer(tapGesture)
//        
//    }
//    func setSwipeGestureRecognizerOnView(){
//        let swipDown = UISwipeGestureRecognizer(target: self, action: #selector(LoginViewController.hideKeyboardOnTap))
//        swipDown.direction = .down
//        self.view.addGestureRecognizer(swipDown)
//    }
}
