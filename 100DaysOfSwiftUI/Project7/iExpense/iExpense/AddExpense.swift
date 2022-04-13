//
//  AddExpense.swift
//  iExpense
//
//  Created by Chhaya Ahuja 5/5/21.
//

import SwiftUI

struct AddExpense: View {
    @ObservedObject var expenses: Expenses
    @State var name: String = ""
    @State var type: String = ""
    @State var cost: String = ""
    static let types = ["Personal","Bussiness"]
    @State private var showAlert = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
 
        NavigationView{
            
            Form {
                
                TextField("Name:",text: $name)
                    .padding()
                    .background(Color.yellow)
                Picker("Type",selection: $type){
                    ForEach(Self.types, id: \.self){
                        Text($0)
                    }
                }
                .padding()
                .background(Color.yellow)
                TextField("Cost:", text: $cost)
                    .padding()
                    .background(Color.yellow)
                    .keyboardType(.numberPad)
            
            }
            .navigationBarTitle("Add new Expense")
            .navigationBarItems(trailing: Button("Save"){
                if let actualAmount = Int(self.cost){
                    let item = ExpenseItem(name: self.name, type: self.type, cost: actualAmount)
                    self.expenses.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                }
                else {
                    self.showAlert = true
                }
            })
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text("Invalid Cost"),
                      message: Text("Enter cost in digits"),
                      dismissButton: .default(Text("Dismiss")){
                        cost = ""
                      })
            })
        }
    }
}

struct AddExpense_Previews: PreviewProvider {
    static var previews: some View {
        AddExpense(expenses: Expenses())
    }
}
