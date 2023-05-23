//
//  ContentView.swift
//  Bookworm
//
//  Created by Berardino Chiarello on 21/05/23.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var books : FetchedResults<Book>
    
    @State private var addBookIsShowed = false
    
    var body: some View {
        NavigationView {
            List{
                ForEach(books) { book in
                    NavigationLink{
                        Text(book.title ?? "Unknown Title")
                    } label: {
                        HStack {
                            VStack (alignment: .leading){
                                Text(book.title ?? "Unknown Title")
                                    .font(.headline)
                                Text(book.author ?? "Unkwnown Author")
                                    .foregroundColor(.secondary)
                            }
                            
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                        }
                    }
                }
                .onDelete(perform: removeBook)
            }
            .navigationTitle("Bookworm")
            
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button{
                        addBookIsShowed = true
                    } label: {
                        Text("Add book \(Image(systemName: "plus"))")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            
            .sheet(isPresented: $addBookIsShowed, content: {
                AddBookView()
            })
        }
    }
    
    func removeBook(at offsets: IndexSet){
        for index in offsets {
            let book = books[index]
            moc.delete(book)
        }
        
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
