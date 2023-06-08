//
//  HolderView.swift
//  Note
//
//  Created by Sullivan De carli on 22/09/2022.
//

import SwiftUI

struct HolderView: View {
    @EnvironmentObject private var authModel: AuthViewModel
    
    var body: some View {
        Group {
            if authModel.user == nil {
                SignUpView()
            } else {
                ContentView()
            }
        }.onAppear {
            authModel.listenToAuthState()
        }
    }
}

struct HolderView_Previews: PreviewProvider {
    static var previews: some View {
        HolderView()
    }
}
