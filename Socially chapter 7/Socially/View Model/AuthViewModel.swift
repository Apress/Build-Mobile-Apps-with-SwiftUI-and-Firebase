//
//  AuthViewModel.swift
//  Socially
//
//  Created by Sullivan De carli on 13/12/2022.
//

import Foundation
import FirebaseAuth
import AuthenticationServices
import CryptoKit

class AuthViewModel: ObservableObject {
    
    var currentNonce: String?
    @Published var user: User?
    
    func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError(
                        "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
                    )
                }
                return random
            }
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        return result
    }
    
    func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        return hashString
    }
    
    func listenToAuthState() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else {
                return
            }
            self.user = user
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
    
    
    // MARK: Sign Up users with email
    // I left this code in case you don't have a developer account
    // to integrate Sign In With Apple.
    // You can implement the login flow with email/password method.
    // Don't forget to enable in the Firebase authenticate console.
    
    
//    func signIn(
//        emailAddress: String,
//        password: String
//    ) {
//        Auth.auth().signIn(withEmail: emailAddress, password: password)
//    }
    
//    func signUp(emailAddress: String, password: String) {
//        Auth.auth().createUser(withEmail: emailAddress, password: password) { result,  error in
//            if let error = error {
//                print("DEBUG: error \(error.localizedDescription)")
//            } else {
//                print("DEBUG: Succesfully created user with ID \(self.user?.uid ?? "")")
//
//            }
//        }
//    }
    
}
