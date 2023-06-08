//
//  SignUpView.swift
//  Note
//
//  Created by Sullivan De carli on 22/09/2022.
//

import SwiftUI

struct SignUpView: View {
    @State private var emailAddress: String = ""
    @State private var password: String = ""
    @EnvironmentObject private var authModel: AuthViewModel
    @State private var showingSheet = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Email", text: $emailAddress)
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                    SecureField("Password", text: $password)
                }
                Section {
                    Button(action: {
                        // TODO
                        authModel.signUp(emailAddress: emailAddress,
                                         password: password)
                    }) {
                        Text("Sign Up").bold()
                    }
                }
                Section(header: Text("If you already have an account:")) {
                    Button(action: {
                        // TODO
                        authModel.signIn(emailAddress: emailAddress,
                                         password: password)
                    }) {
                        Text("Sign In")
                    }
                }
            }.navigationTitle("Welcome")
                .toolbar {
                    ToolbarItemGroup(placement: .cancellationAction) {
                        Button {
                            showingSheet.toggle()
                        } label: {
                            Text("Forgot password?")
                        }
                        .sheet(isPresented: $showingSheet) {
                            ResetPasswordView()
                        }
                    }
                }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
