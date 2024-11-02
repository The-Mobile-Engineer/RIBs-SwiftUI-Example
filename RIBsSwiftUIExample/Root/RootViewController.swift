//
//  RootViewController.swift
//  RIBsSwiftUIExample
//
//  Created by Alex Bush on 10/23/24.
//

import RIBs
import RxSwift
import UIKit

protocol RootPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class RootViewController: UIViewController, RootPresentable, RootViewControllable {
    
    weak var listener: RootPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
    }
    
    func showMainView(_ mainViewController: MainViewControllable) {
        present(mainViewController.uiviewController, animated: true)
    }
    
    func removeMainView(_ mainViewController: MainViewControllable) {
        mainViewController.uiviewController.dismiss(animated: true)
    }
    
    func embedLoginView(_ loginViewController: LoginViewControllable) {
        embed(childViewController: loginViewController.uiviewController)
    }
    
    func removeLoginView(_ loginViewController: LoginViewControllable) {
        removeChildViewController(loginViewController.uiviewController)
    }
    
    private func embed(childViewController: UIViewController) {
        addChild(childViewController)
        view.addSubview(childViewController.view)
        childViewController.didMove(toParent: self)
        
        if let childView = childViewController.view {
            childView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                childView.topAnchor.constraint(equalTo: self.view.topAnchor),
                childView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                childView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                childView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            ])
        }
    }
    
    private func removeChildViewController(_ childViewController: UIViewController) {
        childViewController.willMove(toParent: nil)
        childViewController.view.removeFromSuperview()
        childViewController.removeFromParent()
    }
}
