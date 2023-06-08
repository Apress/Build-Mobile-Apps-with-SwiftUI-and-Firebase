//
//  Post.swift
//  Socially
//
//  Created by Sullivan De carli on 13/12/2022.
//

import SwiftUI
import FirebaseFirestoreSwift

struct Post: Identifiable, Decodable {
    @DocumentID var id: String?
    var description: String?
    var imageURL: String?
    @ServerTimestamp var datePublished: Date?
}
