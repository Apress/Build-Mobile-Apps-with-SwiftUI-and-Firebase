//
//  ContentView.swift
//  Note
//
//  Created by Sullivan De carli on 19/09/2022.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = NoteViewModel()
    @State private var showSheet: Bool = false
    @State private var postDetent = PresentationDetent.medium
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.notes, id:\.id) { Note in
                    NavigationLink(destination: DetailsView(note: Note)) {
                        VStack(alignment: .leading) {
                            Text(Note.title ?? "").font(.system(size: 22, weight: .regular))
                        }.frame(maxHeight: 200)
                    }
                }.onDelete(perform: self.viewModel.deleteData(at:))
            }.onAppear(perform: self.viewModel.fetchData)
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Text("\(viewModel.notes.count) notes")
                    }
                    ToolbarItem(placement: .bottomBar) {
                        Button {
                            showSheet.toggle()
                        }  label: {
                            Image(systemName: "square.and.pencil")
                                .imageScale(.large)
                        }.sheet(isPresented: $showSheet) {
                            FormView().presentationDetents([.large, .medium])
                        }
                    }
                    
                }.navigationTitle("Notes")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
