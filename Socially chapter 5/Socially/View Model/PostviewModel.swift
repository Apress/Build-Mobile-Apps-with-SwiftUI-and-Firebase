//
//  PostviewModel.swift
//  Socially
//
//  Created by Sullivan De carli on 13/12/2022.
//

import SwiftUI
import FirebaseFirestore

class PostViewModel: ObservableObject {
    
    @Published var posts = [Post]()
    private var databaseReference = Firestore.firestore().collection("Posts")
    
    // function to post data
    func addData(description: String, datePublished: Date) async {
        do {
            _ = try await databaseReference.addDocument(data: [ "description": description, "datePublished": datePublished])
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
