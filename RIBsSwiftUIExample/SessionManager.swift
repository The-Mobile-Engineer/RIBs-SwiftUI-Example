//
//  SessionManager.swift
//  RIBsSwiftUIExample
//
//  Created by Alex Bush on 10/23/24.
//

import Foundation

struct Session {
    
}

protocol SessionManagerInterface {
    func getSession() -> Session?
    func saveSession(session: Session)
    func deleteSession()
}

final class SessionManager: SessionManagerInterface {
    
    // NOTE: for example purposes, retreive session from your storage such as user defaults or keychain
    func getSession() -> Session? {
        return nil
//        return Session()
    }
    
    func saveSession(session: Session) {
        
    }
    
    func deleteSession() {
        
    }
}
