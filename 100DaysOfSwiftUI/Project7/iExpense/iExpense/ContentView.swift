//
//  ContentView.swift
//  iExpense
//
//  Created by Chhaya Ahuja on 5/5/21.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    var name: String
    var type: String
    var cost: Int
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }

        self.items = []
    }
}

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showSheet = false
    
    var body: some View {
        NavigationView{
           
            List{
                ForEach(expenses.items){ item in
                    ZStack{
                        LinearGradient(gradient: Gradient(colors: [.yellow, .yellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            .edgesIgnoringSafeArea(.all)
                        HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
                                }

                                Spacer()
                                Text("$\(item.cost)")
                                    .foregroundColor(item.cost <= 10 ? .green : item.cost > 10 && item.cost < 100 ? .blue : .red)
                            }
                        .padding()
                    }
                }
                .onDelete(perform: removeItems)
                
            }
                .navigationBarTitle("iExpense")
            .navigationBarItems(leading: EditButton(), trailing:
                                    Button("Add"){
                                        self.showSheet = true
                                    })
            .sheet(isPresented: $showSheet, content: {
                AddExpense(expenses: self.expenses)
            })
        }
        
    }
    
    func removeItems(at offsets: IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
