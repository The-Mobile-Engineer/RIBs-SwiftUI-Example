//
//  LoginViewController.swift
//  RIBsSwiftUIExample
//
//  Created by Alex Bush on 10/23/24.
//

import RIBs
import RxSwift
import UIKit
import SwiftUI

protocol LoginPresentableListener: AnyObject {
    func login(withEmail email: String, password: String)
}

final class LoginViewController: UIViewController, LoginPresentable, LoginViewControllable, LoginViewDelegate {

    weak var listener: LoginPresentableListener?
    
    private lazy var observableObject = LoginViewObservableObject(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView(view: LoginView(observableObject: observableObject))
    }
    
    private func setupView<Content>(view: Content) where Content : View {
        let contentVC = UIHostingController<Content>(rootView: view)
        
        self.addChild(contentVC)
        contentVC.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(contentVC.view)
        contentVC.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            contentVC.view.topAnchor.constraint(equalTo: self.view.topAnchor),
            contentVC.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            contentVC.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            contentVC.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
    
    func didTapLogin() {
        listener?.login(withEmail: observableObject.email, password: observableObject.password)
    }
}
