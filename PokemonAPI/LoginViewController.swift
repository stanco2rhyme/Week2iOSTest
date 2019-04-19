//
//  LoginViewController.swift
//  PokemonAPI
//
//  Created by Stanley Ejechi on 4/18/19.
//  Copyright © 2019 MobileConsultingSolutions. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var kUsernameTextfield: UITextField!
    @IBOutlet weak var kPasswordTextfield: UITextField!
    @IBOutlet weak var rememberMeSwitch: UISwitch!
    var kcUsernameKey: String?
    var kcPasswordKey: String?
    
    // Keychain Configuration
    struct KeychainConfiguration {
        static let serviceName = "PokemonAPI"
        static let accessGroup: String? = nil
        static let account: String? = nil

    }
    var passwordItems: [KeychainPasswordItem] = []
    let createLoginButtonTag = 0
    let loginButtonTag = 1

    
    @IBOutlet weak var loginButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(true, animated: false)
        //check if user has logged in before
        if hasLoginBefore() {
            if  autoRetrieveLoginInformation(){
//                let detailVC = PokemonViewController()
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let pokemonViewController = storyboard.instantiateViewController(withIdentifier: "PokemonViewController") as! PokemonViewController
                navigationController?.pushViewController(pokemonViewController, animated: true)
//                performSegue(withIdentifier: "dismissLogin", sender: self)

            } else {
                //do nothing
            }
        }
        
       
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
        rememberMeSwitch.setOn(false, animated: false)
        navigationController?.setNavigationBarHidden(false, animated: false)

    }
    
    //  check if the username has logged in before and pressed the switch and create button appropriately
    func hasLoginBefore() -> Bool {
        let hasLogin = UserDefaults.standard.bool(forKey: "hasLoginKey") && UserDefaults.standard.bool(forKey: "username")
        
        // 2
        if hasLogin {
            loginButton.setTitle("Login", for: .normal)
            loginButton.tag = loginButtonTag
//            createInfoLabel.isHidden = true
        } else {
            loginButton.setTitle("Create", for: .normal)
            loginButton.tag = createLoginButtonTag
//            createInfoLabel.isHidden = false
        }
        return hasLogin
    }
    
    //retrieve password with username auto remember
    func autoRetrieveLoginInformation() -> Bool {
        
        // 3
        guard let storedUsername = UserDefaults.standard.value(forKey: "username") as? String else {
            return false
        }
        do {
            kUsernameTextfield.text = storedUsername
            let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName,
                                                    account: storedUsername,
                                                    accessGroup: KeychainConfiguration.accessGroup)
            let keychainPassword = try passwordItem.readPassword()
            kPasswordTextfield.text = keychainPassword

            return true
        } catch {
            fatalError("Error reading password from keychain - \(error)")
        }
    }
    
    
    
    //authenticate username and password with keychain
    func checkLogin(username: String, password: String) -> Bool {
        guard username == UserDefaults.standard.value(forKey: "username") as? String else {
            return false
        }
        
        do {
            let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName,
                                                    account: username,
                                                    accessGroup: KeychainConfiguration.accessGroup)
            let keychainPassword = try passwordItem.readPassword()
            return password == keychainPassword
        } catch {
            fatalError("Error reading password from keychain - \(error)")
        }
    }
    
    //login credentials fail
    private func showLoginFailedAlert() {
        let alertView = UIAlertController(title: "Login Problem",
                                          message: "Wrong username or password.",
                                          preferredStyle:. alert)
        let okAction = UIAlertAction(title: "Foiled Again!", style: .default)
        alertView.addAction(okAction)
        present(alertView, animated: true)
    }
    
    //remember me security warning alert
    private func securityWarningAlert() {
        let alertView = UIAlertController(title: "Security warning Alert",
                                          message: "Using the Remember Me Button Feature will automatically log you in next time. Please ensure you are in control of your device at all time when using this feature.",
                                          preferredStyle:. alert)
        let okAction = UIAlertAction(title: "I Agree", style: .default)
        alertView.addAction(okAction)
        present(alertView, animated: true)
    }
    
    @IBAction func rememberMeSwitchWasPressed(_ sender: Any) {
        if rememberMeSwitch.isOn {
            securityWarningAlert()
        }
    }
    @IBAction func loginButtonWasPressed(_ sender: Any) {
        
        // 1
        // Check that text has been entered into both the username and password fields.
        guard let newAccountName = kUsernameTextfield.text,
            let newPassword = kPasswordTextfield.text,
            !newAccountName.isEmpty,
            !newPassword.isEmpty else {
                showLoginFailedAlert()
                return
        }
        
        // 2
        kUsernameTextfield.resignFirstResponder()
        kPasswordTextfield.resignFirstResponder()
        
        // 3. check if username has been saved before
        if loginButton.tag == createLoginButtonTag {
            // 4
            let hasLoginKey = UserDefaults.standard.bool(forKey: "hasLoginKey")
            if !hasLoginKey && kUsernameTextfield.hasText && rememberMeSwitch.isOn {
                UserDefaults.standard.setValue(kUsernameTextfield.text, forKey: "username")
            } else {
                UserDefaults.standard.set(false
                    , forKey: "hasLoginKey")
                loginButton.tag = createLoginButtonTag
            }
            
            // 5
            do {
                // This is a new account, create a new keychain item with the account name.
                let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName,
                                                        account: newAccountName,
                                                        accessGroup: KeychainConfiguration.accessGroup)
                
                // Save the password for the new item.
                try passwordItem.savePassword(newPassword)
            } catch {
                fatalError("Error updating keychain - \(error)")
            }
            
            // 6 save
            if rememberMeSwitch.isOn {
                UserDefaults.standard.set(true, forKey: "hasLoginKey")
                loginButton.tag = loginButtonTag
            } else {
                UserDefaults.standard.set(false, forKey: "hasLoginKey")
                loginButton.tag = createLoginButtonTag
            }
//            performSegue(withIdentifier: "dismissLogin", sender: self)
            kUsernameTextfield.text = nil
            kPasswordTextfield.text = nil
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let pokemonViewController = storyboard.instantiateViewController(withIdentifier: "PokemonViewController") as! PokemonViewController
            navigationController?.pushViewController(pokemonViewController, animated: true)
           
        } else if loginButton.tag == loginButtonTag {
            // 7
            if checkLogin(username: newAccountName, password: newPassword) {
                if rememberMeSwitch.isOn {
                    UserDefaults.standard.set(true, forKey: "hasLoginKey")

                } else {
                    UserDefaults.standard.set(false, forKey: "hasLoginKey")

                }
//                performSegue(withIdentifier: "dismissLogin", sender: self)
                kUsernameTextfield.text = nil
                kPasswordTextfield.text = nil
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let pokemonViewController = storyboard.instantiateViewController(withIdentifier: "PokemonViewController") as! PokemonViewController
                navigationController?.pushViewController(pokemonViewController, animated: true)
            } else {
                // 8
                showLoginFailedAlert()
            }
        }
        
        
        
        
        
        
    }
}
