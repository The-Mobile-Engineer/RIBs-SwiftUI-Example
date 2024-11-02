//
//  RootRouter.swift
//  RIBsSwiftUIExample
//
//  Created by Alex Bush on 10/23/24.
//

import RIBs

protocol RootInteractable: Interactable, MainListener, LoginListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    func showMainView(_ mainViewController: MainViewControllable)
    func removeMainView(_ mainViewController: MainViewControllable)
    func embedLoginView(_ loginViewController: LoginViewControllable)
    func removeLoginView(_ loginViewController: LoginViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    
    private let mainBuilder: MainBuildable
    private var mainRouter: MainRouting?
    
    private let loginBuilder: LoginBuildable
    private var loginRouter: LoginRouting?
    
    init(interactor: RootInteractable, viewController: RootViewControllable,
         mainBuilder: MainBuildable,
         loginBuilder: LoginBuildable) {
        self.mainBuilder = mainBuilder
        self.loginBuilder = loginBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func routeToMain() {
        let mainRouter = mainBuilder.build(withListener: interactor)
        self.mainRouter = mainRouter
        let mainViewController = mainRouter.mainViewController
        viewController.showMainView(mainViewController)
        attachChild(mainRouter)
    }
    
    func routeAwayFromMain() {
        if let mainRouter = mainRouter {
            self.mainRouter = nil
            viewController.removeMainView(mainRouter.mainViewController)
            detachChild(mainRouter)
        }
    }
    
    func routeToLogin() {
        let loginRouter = loginBuilder.build(withListener: interactor)
        self.loginRouter = loginRouter
        let loginViewController = loginRouter.loginViewController
        viewController.embedLoginView(loginViewController)
        attachChild(loginRouter)
    }
    
    func routeAwayFromLogin() {
        if let loginRouter = loginRouter {
            self.loginRouter = nil
            viewController.removeLoginView(loginRouter.loginViewController)
            detachChild(loginRouter)
        }
    }
}
