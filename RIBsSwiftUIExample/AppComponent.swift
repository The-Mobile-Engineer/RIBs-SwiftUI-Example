//
//  AppComponent.swift
//  RIBsSwiftUIExample
//
//  Created by Alex Bush on 10/23/24.
//

import Foundation
import RIBs

class AppComponent: Component<EmptyDependency>, RootDependency {
    
    init() {
        super.init(dependency: EmptyComponent())
    }
    
}
