//
//  FormView.swift
//  Note
//
//  Created by Sullivan De carli on 27/09/2022.
//

import SwiftUI

struct FormView: View {
    @State private var titleText: String = ""
    @ObservedObject private var viewModel = NoteViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Enter your text", text: $titleText, axis: .vertical)
                        .lineLimit(5)
                }
                Section {
                    Button("Save") {
                        // post the text to Firestore, then erase the text:
                        self.viewModel.addData(title: titleText)
                        titleText = ""
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }.navigationTitle("Post")
                .toolbar {
                    ToolbarItemGroup(placement: .destructiveAction) {
                        Button("Cancel") {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
        }
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView()
    }
}
