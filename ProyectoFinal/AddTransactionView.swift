//
//  AddTransactionView.swift
//  Datos
//
//  Created by iOS Lab on 01/06/23.
//

import SwiftUI

struct AddTransactionView: View {
    var handleAdd: (TransactionModel) -> Bool
    let categories = ["Alimentos", "Entretenimiento", "Gastos necesarios"]
    
    @State private var emptyFields = false
    @State private var wrongInput = false
    @State private var notEnoughBudget = false
    @State private var showAlert = false
    
    @State private var newTransactionTitle = ""
    @State private var newTransactionCategory = "Alimentos"
    @State private var newTransactionAmount = ""
    @State private var newTransactionDescription = ""
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Transaction Details")) {
                    TextField("Title", text: $newTransactionTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Amount", text: $newTransactionAmount)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                    
                    Picker("Category", selection: $newTransactionCategory) {
                        ForEach(categories, id: \.self) { category in
                            Text(category)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Description")) {
                    TextField("Description", text: $newTransactionDescription)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Section {
                    Button(action: {
                        validateAndAddTransaction()
                    }) {
                        Text("Add new transaction")
                            .frame(maxWidth: .infinity, maxHeight: 40)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .font(.headline)
                            .cornerRadius(8)
                    }
                }
            }
            .navigationTitle("Add Transaction")
            .alert(isPresented: $showAlert) {
                getAlert()
            }
        }
    }
    
    private func validateAndAddTransaction() {
        if newTransactionTitle.isEmpty || newTransactionAmount.isEmpty || newTransactionCategory.isEmpty {
            emptyFields = true
            showAlert = true
        } else {
            if let transactionValue = Float(newTransactionAmount), transactionValue > 0 {
                let transaction = TransactionModel(id: UUID(), title: newTransactionTitle, date: Date(), amount: transactionValue, category: newTransactionCategory, description: newTransactionDescription)
                notEnoughBudget = handleAdd(transaction)
                presentation.wrappedValue.dismiss()
            } else {
                wrongInput = true
                showAlert = true
            }
        }
    }
    
    private func getAlert() -> Alert {
        if emptyFields {
            return Alert(title: Text("Error"), message: Text("Please fill in all the fields"), dismissButton: .default(Text("OK")))
        } else if wrongInput {
            return Alert(title: Text("Error"), message: Text("Please enter a valid amount"), dismissButton: .default(Text("OK")))
        } else if notEnoughBudget {
            return Alert(title: Text("Error"), message: Text("Not enough budget"), dismissButton: .default(Text("OK")))
        } else {
            return Alert(title: Text("Error"), message: Text("Unknown error"), dismissButton: .default(Text("OK")))
        }
    }
}



        /*
            .alert(isPresented: $emptyFields, content:{
                Alert(
                    title: Text("Error"),
                    message: Text("Por favor rellene bien los campos"),
                    dismissButton: .default(Text("OK"))
                )
            })
            
            .alert(isPresented: $wrongInput, content:{
                Alert(
                    title: Text("Error"),
                    message: Text("Ingrese una cantidad valida"),
                    dismissButton: .default(Text("OK"))
                )
            })
            .alert(isPresented: $notEnoughBudget, content:{
                Alert(
                    title: Text("Error"),
                    message: Text("Ingrese una cantidad valida"),
                    dismissButton: .default(Text("OK"))
                )
            })
             */

