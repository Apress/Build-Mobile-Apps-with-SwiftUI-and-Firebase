//
//  SignUpView.swift
//  Socially
//
//  Created by Sullivan De carli on 13/12/2022.
//

import SwiftUI

struct SignUpView: View {
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
                // TODO: Sign In with Apple button
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
