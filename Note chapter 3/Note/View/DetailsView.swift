//
//  DetailsView.swift
//  Note
//
//  Created by Sullivan De carli on 27/09/2022.
//

import SwiftUI

struct DetailsView: View {
    
    var note: Note
    @State private var presentAlert = false
    @ObservedObject private var viewModel = NoteViewModel()
    @State private var titleText: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Text(note.title ?? "")
                        .font(.system(size: 22, weight: .regular))
                        .padding()
                    Spacer()
                }
            }
        }.navigationTitle("Details")
            .toolbar {
                ToolbarItemGroup(placement: .confirmationAction) {
                    Button {
                        presentAlert = true
                    } label: {
                        Text("Edit").bold()
                    }.alert("Note", isPresented: $presentAlert, actions: {
                        TextField("\(note.title ?? "")", text: $titleText)
                        Button("Update", action: {
                            //TODO: Update data and erase the text
                            self.viewModel.updateData(title: titleText, id: note.id ?? "")
                            titleText = ""
                        })
                        Button("Cancel", role: .cancel, action: {
                            presentAlert = false
                            titleText = ""
                        })
                    }, message: {
                        Text("Write your new note")
                    })
                }
            }
    }
}


struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
 DetailsView(note: Note(id: "bKrivNkYirmMvHyAUBWv", title: "Issues are never simple. One thing I'm proud of is that very rarely will you hear me simplify the issues.Barack Obama"))
    }
}

