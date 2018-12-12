//
//  LoginViewController.swift
//  TechmasterFinal
//
//  Created by Toàn Nguyễn on 12/12/18.
//  Copyright © 2018 mobile. All rights reserved.
//


import UIKit
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTextField()
        configButton()
        configBackgroundView()
        
    }
    
    func configBackgroundView() {
        
        let dismissKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        
        backgroundView.addGestureRecognizer(dismissKeyboardGesture)
        
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func configButton() {
        loginButton.layer.cornerRadius = 6.0
    }
    
    func configTextField() {
        usernameTextField.backgroundColor = UIColor.clear
        passwordTextField.backgroundColor = UIColor.clear
        passwordTextField.isSecureTextEntry = true
        
        //Placeholder
        usernameTextField.placeholder = "Input your username"
        passwordTextField.placeholder = "Input your password"
        
        //Corner Radius + Border
        usernameTextField.layer.cornerRadius = 6.0
        usernameTextField.layer.borderWidth = 2.0
        usernameTextField.layer.borderColor = UIColor.white.cgColor
        
        passwordTextField.layer.cornerRadius = 6.0
        passwordTextField.layer.borderWidth = 2.0
        passwordTextField.layer.borderColor = UIColor.white.cgColor
        
        //Placeholder Attributes
        usernameTextField.attributedPlaceholder = NSAttributedString(string: self.usernameTextField.placeholder ?? "",
                                                                     attributes: [NSAttributedStringKey.font: UIFont(name: "Roboto-medium", size: 12.0) ?? UIFont.systemFontSize,
                                                                                                                                    NSAttributedStringKey.foregroundColor: UIColor.white])
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: self.passwordTextField.placeholder ?? "",
                                                                     attributes: [NSAttributedStringKey.font: UIFont(name: "Roboto-medium", size: 12.0) ?? UIFont.systemFontSize,
                                                                                  NSAttributedStringKey.foregroundColor: UIColor.white])
    }

    fileprivate func alertView(_ message: String) {
        
        let alertController = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction public func onLogin(_ sender: UIButton) {
        
        guard let username = self.usernameTextField.text, let password = self.passwordTextField.text else {
            alertView("Username or Password is nil")
            return }
        
        if username.count == 0 || password.count == 0 {
            alertView("Please fill enough information for login")
            return
        }
        
        let aUser = User(username, password)
    
        
        Alamofire.request("http://localhost:31689/api/login", method: .post, parameters: aUser.dictionary!, encoding: JSONEncoding.default)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let responseDic = value as! NSDictionary
                    
                    let success = responseDic.object(forKey: "success") as? Bool
                    if (success == true) {
                        guard let allItemNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "NavigationController") as? UINavigationController else {
                            self.alertView("Can not create NavigationController")
                            return
                        }
                        
                        self.present(allItemNavigationController, animated: true, completion: nil)
                    } else{
                        let data = responseDic.object(forKey: "data") as? NSDictionary
                        self.alertView(data!.object(forKey: "message") as! String)
                        return
                    }
                case .failure(let error):
                    print(error)
                    self.alertView("Check network connection/api")
                    return
                }
        }
    }
}

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
