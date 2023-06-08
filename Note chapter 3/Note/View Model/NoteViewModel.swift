//
//  NoteViewModel.swift
//  Note
//
//  Created by Sullivan De carli on 20/09/2022.
//

import Foundation
import FirebaseFirestore
import Combine
import FirebaseAuth

class NoteViewModel: ObservableObject {
    
    @Published var notes = [Note]()
    private var databaseReference = Firestore.firestore().collection("Notes")
    
    // function to post data
    func addData(title: String) {
        do {
            _ = try databaseReference.addDocument(data: ["title": title])
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    // function to read data
    func fetchData() {
        databaseReference.addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.notes = documents.compactMap { queryDocumentSnapshot -> Note? in
                return try? queryDocumentSnapshot.data(as: Note.self)
            }
        }
    }
    
    // function to update data
    func updateData(title: String, id: String) {
        databaseReference.document(id).updateData(["title" : title]) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Note updated succesfully")
            }
        }
    }
    
    // function to delete data
    func deleteData(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let note = notes[index]
            databaseReference.document(note.id ?? "").delete { error in
                if let error = error {
                    print("\(error.localizedDescription)")
                } else {
                    print("Note with ID \(note.id ?? "") deleted")
                }
            }
        }
    }
}
