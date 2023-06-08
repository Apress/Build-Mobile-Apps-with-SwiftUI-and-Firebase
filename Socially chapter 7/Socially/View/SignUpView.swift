//
//  SignUpView.swift
//  Socially
//
//  Created by Sullivan De carli on 13/12/2022.
//

import SwiftUI
import AuthenticationServices
import FirebaseAuth
import FirebaseFirestore

struct SignUpView: View {
    @ObservedObject private var authModel = AuthViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                // credit photo: https://unsplash.com/photos/e3OUQGT9bWU?utm_source=unsplash&utm_medium=referral&utm_content=creditShareLink
                Image("signup-picture")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 220)
                Text("Sign Up").font(.title2)
                    .bold()
                    .italic()
                    .padding(.bottom, 10)
                Text("Create your account to post your best content on Socially")
                    .font(.subheadline).multilineTextAlignment(.center)
                Spacer()
                SignInWithAppleButton(onRequest:  { request in
                    let nonce = authModel.randomNonceString()
                    authModel.currentNonce = nonce
                    request.requestedScopes = [.email]
                    request.nonce = authModel.sha256(nonce)
                },
                                      onCompletion: { result in
                    //Completion
                    switch result {
                    case .success(let authResults):
                        switch authResults.credential {
                        case let appleIDCredential as ASAuthorizationAppleIDCredential:
                            guard let nonce = authModel.currentNonce else {
                                fatalError("Invalid state: A login callback was received, but no login request was sent.")
                            }
                            guard let appleIDToken = appleIDCredential.identityToken else {
                                fatalError("Invalid state: A login callback was received, but no login request was sent.")
                            }
                            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                                return
                            }
                            let credential = OAuthProvider.credential(withProviderID: "apple.com",idToken: idTokenString,rawNonce: nonce)
                            Auth.auth().signIn(with: credential) { (authResult, error) in
                                if (error != nil) {
                                    print(error?.localizedDescription as Any)
                                    return
                                }
                                print("signed in")
                                guard let user = authResult?.user else { return }
                                
                                let userData = [
                                    "email": user.email,
                                    "uid": user.uid]
                                
                                Firestore.firestore().collection("User")
                                    .document(user.uid)
                                    .setData(userData) { _ in
                                    print("DEBUG:user data uploaded.")
                                    }
                            }
                            print("\(String(describing: Auth.auth().currentUser?.uid))")
                        default:
                            break
                        }
                    default:
                        break
                    }
                }
                ).signInWithAppleButtonStyle(.whiteOutline)
                    .frame(width: 290, height: 45, alignment: .center)
            }
            .toolbar {
                ToolbarItemGroup(placement: .cancellationAction) {
                    Button("Close") {
                        presentationMode.wrappedValue.dismiss()
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
