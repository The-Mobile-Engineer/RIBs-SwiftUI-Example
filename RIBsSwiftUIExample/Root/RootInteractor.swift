//
//  RootInteractor.swift
//  RIBsSwiftUIExample
//
//  Created by Alex Bush on 10/23/24.
//

import RIBs
import RxSwift

protocol RootRouting: ViewableRouting {
    func routeToMain()
    func routeAwayFromMain()
    
    func routeToLogin()
    func routeAwayFromLogin()
}

protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol RootListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable, RootPresentableListener {
    
    weak var router: RootRouting?
    weak var listener: RootListener?
    
    private let sessionManager: SessionManagerInterface
    
    init(presenter: RootPresentable,
         sessionManager: SessionManagerInterface) {
        self.sessionManager = sessionManager
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        
        if sessionManager.getSession() != nil {
            router?.routeToMain()
        } else {
            router?.routeToLogin()
        }
    }
    
    func didLoginWithSession(_ session: Session, _ interactor: LoginInteractable) {
        sessionManager.saveSession(session: session)
        router?.routeAwayFromLogin()
        router?.routeToMain()
    }
    
    // TODO: remove from Home RIB when done testing
    func logout() {
        sessionManager.deleteSession()
        router?.routeToLogin()
    }
    // TODO: remove from Home RIB when done testing
}
