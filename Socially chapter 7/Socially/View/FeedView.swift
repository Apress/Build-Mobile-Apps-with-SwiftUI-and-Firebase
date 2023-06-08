//
//  FeedView.swift
//  Socially
//
//  Created by Sullivan De carli on 13/12/2022.
//
import SwiftUI
import FirebaseFirestoreSwift

struct FeedView: View {
    @State private var showSheet: Bool = false
    @FirestoreQuery(collectionPath: "Posts")
    var posts: [Post]
    
    var body: some View {
        NavigationStack {
        List(posts) { posts in
            VStack(alignment: .leading) {
                VStack {
                    AsyncImage(url: URL(string: posts.imageURL ?? "")) { phase in
                        switch phase {
                        case .empty:
                            EmptyView()
                        case .success(let image):
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 120, maxHeight: 120)
                        case .failure:
                            Image(systemName: "photo")
                        @unknown default:
                            EmptyView()
                        }
                    }
                    
                    Text(posts.description ?? "")
                        .font(.headline)
                        .padding(12)
                    Text("Published on the \(posts.datePublished?.formatted() ?? "")")
                        .font(.caption)
                }
            }.frame(minHeight: 100, maxHeight: 350)
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
