//
//  PostviewModel.swift
//  Socially
//
//  Created by Sullivan De carli on 13/12/2022.
//

import SwiftUI
import FirebaseFirestore
import FirebaseStorage

class PostViewModel: ObservableObject {
    
    @Published var posts = [Post]()
    private var databaseReference = Firestore.firestore().collection("Posts")
    let storageReference = Storage.storage().reference().child("\(UUID().uuidString)")
    
    // function to post data
    func addData(description: String, datePublished: Date, data: Data) async {
        do {
            _ = try await
            storageReference.putData(data, metadata: nil) { (metadata, error) in
                guard let metadata = metadata else {
                    return
                }
                self.storageReference.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        // Uh-oh, an error occurred!
                        return
                    }
                    self.databaseReference.addDocument(data: [ "description": description, "datePublished": datePublished, "imageURL": downloadURL.absoluteString])
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }

}
