//
//  AddBookView.swift
//  Bookworm
//
//  Created by Chhaya Ahuja on 6/13/21.
//

import SwiftUI

struct AddBookView: View {
    @Environment (\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var isShowingAlert =  false
    @State private var title = ""
    @State private var author = ""
    @State private var genre = ""
    @State private var review = ""
    @State private var rating = 3
    var date: String {
        let dt = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: dt)
    }
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter Title", text: $title)
                    TextField("Enter Author", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    RatingView(rating: $rating)
                    
                    TextField("Write a review", text: $review)
                }
                
                Section {
                    Button("Save") {
                        if(self.genre == "") {
                            self.isShowingAlert = true
                        }
                        else {
                            let newBook = Book(context: self.moc)
                            newBook.title = self.title
                            newBook.author = self.author
                            newBook.rating = Int16(self.rating)
                            newBook.genre = self.genre
                            newBook.review = self.review
                            newBook.date = date
                            try? self.moc.save()
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
            .navigationBarTitle("Add Book")
            .alert(isPresented: $isShowingAlert) {
                Alert(title:Text("Genre Required"), message: Text("Please select book's Genre"), dismissButton: .cancel())
            }
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
