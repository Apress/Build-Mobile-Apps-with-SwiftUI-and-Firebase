//
//  AuthViewModel.swift
//  Note
//
//  Created by Sullivan De carli on 22/09/2022.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

final class AuthViewModel: ObservableObject {
    
    @Published var user: User?
    
    func listenToAuthState() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else {
                return
            }
            self.user = user
        }
    }
    
    // function to sign-in
    func signIn(
        emailAddress: String,
        password: String
    ) {
        Auth.auth().signIn(withEmail: emailAddress, password: password)
    }
    
    // function to create an account
    func signUp(emailAddress: String, password: String) {
        Auth.auth().createUser(withEmail: emailAddress, password: password) { result,  error in
            if let error = error {
                print("DEBUG: error \(error.localizedDescription)")
            } else {
                print("DEBUG: Succesfully created user with ID \(self.user?.uid ?? "")")
                guard let uid = Auth.auth().currentUser?.uid else { return }
                Firestore.firestore().collection("Users").document(uid).setData(["email" : emailAddress, "uid": uid]) { err in
                    if let err = err {
                        print(err)
                        return
                    }
                    print("Success")
                }
                
            }
        }
    }
    
    // function to logout
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    // function to reset password
    func resetPassword(emailAddress: String) {
        Auth.auth().sendPasswordReset(withEmail: emailAddress)
    }
    
}
