//
//  PostView.swift
//  Socially
//
//  Created by Sullivan De carli on 13/12/2022.
//

import SwiftUI

struct PostView: View {
    
    @ObservedObject private var viewModel = PostViewModel()
    @State private var description: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Add a description", text: $description, axis: .vertical)
                        .lineLimit(6)
                }
                Section {
                    Button("Post") {
                        // MARK: Post data to Firestore
                        Task {
                            await self.viewModel.addData(description: description, datePublished: Date())
                        }
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationTitle("Post")
            .toolbar {
                ToolbarItemGroup(placement: .cancellationAction) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
