//
//  ContentView.swift
//  Bookworm
//
//  Created by Berardino Chiarello on 21/05/23.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title)
    ]) var books : FetchedResults<Book>
    
    @State private var addBookIsShowed = false
    
    var body: some View {
        NavigationView {
            List{
                ForEach(books) { book in
                    NavigationLink{
                        DetailView(book: book)
                    } label: {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack (alignment: .leading){
                                Text(book.title ?? "Unknown Title")
                                    .font(.headline)
                                    .foregroundColor(book.rating == 1 ? Color.red : Color.primary)
                                Text(book.author ?? "Unknown Author")
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            HStack{
                                Text("\(book.rating)")
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            }
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
