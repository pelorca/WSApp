//
//  ViewController.swift
//  WSApp
//
//  Created by Pelorca on 06/12/2017.
//  Copyright © 2017 Eduardo Pelorca. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var token: Token?
    @IBOutlet weak var txtLogin: UITextField!
    @IBOutlet weak var txtSenha: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Repository().selectPost().count == 1 {
           
            DispatchQueue.main.async(execute: {
               self.performSegue(withIdentifier: "task", sender: self)
            })
        }
        
        
        
    }
    

    
    
    
    
    @IBAction func btnOK(_ sender: Any) {
      if validarCamposLogin() {
        let senha: String = self.txtSenha.text!
        let password: String = self.txtLogin.text!
        
        PostService().login(username: password, password: senha, onSuccess: { response in
            self.token = response?.body
            
            print("Login do usuario '\(String(describing: self.txtLogin?.text))' realizado com sucesso")
            self.performSegue(withIdentifier: "task", sender: self)
            print("Token: \(String(describing: self.token))")
            UserDefaults.standard.set(self.token?.accessToken, forKey: Constants.token)
            UserDefaults.standard.synchronize()
            self.addReal(token: (self.token?.accessToken)!)
            
        }, onError: { _ in
            
            print("Falha ao realizar login para o usuario '\(String(describing: self.txtLogin?.text))'")
            Constants.showMessage(self, I18n.msgLoginSenhaInvalidos)
            
        }, always: {
            //hide loading
        })
        
        }
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addReal(token: String) {
        let post = PostEntity()
        post.accessToken = token
        post.id = UUID().uuidString
        Repository().save(data: post)
    }
    
    
    func validarCamposLogin() -> Bool {
        if self.txtLogin.text == "" {
            Constants.showMessage(self, I18n.msgLoginInvalido)
            return false
        }
        if txtSenha.text ==  "" {
            Constants.showMessage(self, I18n.msgSenhaInvalida)
            return false
        }
        return true
    }

    
}

