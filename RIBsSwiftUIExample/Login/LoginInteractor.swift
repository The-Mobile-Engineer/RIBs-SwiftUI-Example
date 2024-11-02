//
//  LoginInteractor.swift
//  RIBsSwiftUIExample
//
//  Created by Alex Bush on 10/23/24.
//

import RIBs
import RxSwift

protocol LoginRouting: ViewableRouting {
    var loginViewController: LoginViewControllable { get }
}

protocol LoginPresentable: Presentable {
    var listener: LoginPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol LoginListener: AnyObject {
    func didLoginWithSession(_ session: Session, _ interactor: LoginInteractable)
}

final class LoginInteractor: PresentableInteractor<LoginPresentable>, LoginInteractable, LoginPresentableListener {

    weak var router: LoginRouting?
    weak var listener: LoginListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: LoginPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func login(withEmail email: String, password: String) {
        // TODO: pretend there is validation and email and password are actually used and there are actual network requests here
        listener?.didLoginWithSession(Session(), self)
    }
}
