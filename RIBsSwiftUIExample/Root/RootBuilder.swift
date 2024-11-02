//
//  RootBuilder.swift
//  RIBsSwiftUIExample
//
//  Created by Alex Bush on 10/23/24.
//

import RIBs

protocol RootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class RootComponent: Component<RootDependency>, MainDependency, LoginDependency {
    
    var mainBuilder: MainBuildable {
        MainBuilder(dependency: self)
    }
    
    var loginBuilder: LoginBuildable {
        LoginBuilder(dependency: self)
    }
    
    var sessionManager: SessionManagerInterface {
        shared { SessionManager() }
    }
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {
    
    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }
    
    func build() -> LaunchRouting {
        let component = RootComponent(dependency: dependency)
        let viewController = RootViewController()
        let interactor = RootInteractor(presenter: viewController,
                                        sessionManager: component.sessionManager)
        
        let mainBuilder = component.mainBuilder
        let loginBuilder = component.loginBuilder
        
        return RootRouter(interactor: interactor,
                          viewController: viewController,
                          mainBuilder: mainBuilder,
                          loginBuilder: loginBuilder)
    }
}
