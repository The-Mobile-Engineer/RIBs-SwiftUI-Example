//
//  LoginView.swift
//  RIBsSwiftUIExample
//
//  Created by Alex Bush on 11/1/24.
//

import SwiftUI

protocol LoginViewDelegate: AnyObject {
    func didTapLogin()
}

final class LoginViewObservableObject: ObservableObject {
    private weak var delegate: LoginViewDelegate?
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    init(delegate: LoginViewDelegate? = nil) {
        self.delegate = delegate
    }
    
    func onLoginTapped() {
        delegate?.didTapLogin()
    }
}

struct LoginView: View {
    
    @ObservedObject private var observableObject: LoginViewObservableObject
    
    init(observableObject: LoginViewObservableObject) {
        self.observableObject = observableObject
    }
    
    var body: some View {
        VStack {
            TextField("Email", text: $observableObject.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
            
            SecureField("Password", text: $observableObject.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                observableObject.onLoginTapped()
            }) {
                Text("Login")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding()
            }
        }
        .padding()
    }
}
