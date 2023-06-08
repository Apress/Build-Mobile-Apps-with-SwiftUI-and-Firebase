//
//  Note.swift
//  Note
//
//  Created by Sullivan De carli on 20/09/2022.
//

import Foundation
import FirebaseFirestoreSwift

struct Note: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String?
}
