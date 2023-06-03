//
//  ViewController.swift
//  FaceIdProject
//
//  Created by Gizem on 17.04.2023.
//

import UIKit

class LoginViewController: UIViewController {

    private let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        viewModel.authenticateUser()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.authenticateUser()
    }
}

extension LoginViewController: LoginViewModelDelegate {
    func success() {
        if let homeViewController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
            self.navigationController?.pushViewController(homeViewController, animated: true)
        }
    }
}
