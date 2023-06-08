//
//  FeedView.swift
//  Socially
//
//  Created by Sullivan De carli on 13/12/2022.
//

import SwiftUI

struct FeedView: View {
    @State private var showSheet: Bool = false

    var body: some View {
        NavigationStack {
            List(0..<10) { index in
                Text("\(index)")
            }.listStyle(GroupedListStyle())
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button {
                            showSheet.toggle()
                        }  label: {
                            Image(systemName: "square.and.pencil")
                                .imageScale(.large)
                        }.sheet(isPresented: $showSheet) {
                            PostView()
                        }
                    }
                }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
