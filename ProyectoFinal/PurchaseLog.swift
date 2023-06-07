//
//  PurchaseLog.swift
//  ProyectoFinal
//
//  Created by iOS Lab on 30/05/23.
//

import Foundation
import SwiftUI

struct TransactionView: View {
    
    private var data = DataPersistence()
    @State private var transactions: [TransactionModel] = []
    @State private var myUser : userModel = userModel.defaultUser
    
    
    func addTransaction(transaction: TransactionModel) -> Bool {
        
        if myUser.monthBudget - transaction.amount < 0 {
            return false
        } else {
            transactions.append(transaction)
            
            let remainingMoney = myUser.remainingMoney - transaction.amount
            myUser = userModel(name: myUser.name, monthBudget: myUser.monthBudget, remainingMoney: remainingMoney, purchaseAmount: myUser.purchaseAmount + 1, foodPurchases: myUser.foodPurchases + (transaction.category == "Alimentos" ? 1 : 0), funPurchases: myUser.funPurchases + (transaction.category == "Entretenimiento" ? 1 : 0), needPurchases: myUser.needPurchases + (transaction.category == "Gastos necesarios" ? 1 : 0))
            do{
                try data.saveTransactions(transactions: transactions)
                try data.saveUser(user: myUser)
            } catch{}
            
            return true
        }
    }
    
    func deleteTransaction(transaction: TransactionModel) -> Bool {
        transactions = transactions.filter{ $0.id != transaction.id}
        do{
            try data.saveTransactions(transactions: transactions)
            return true
        } catch{}
        return false
    }
    
    var body: some View {
        
        VStack{
            Text("\(myUser.name )")
            NavigationStack{
                    List(transactions) { transaction in
                        NavigationLink(destination: ShowTransactionView(transaction: transaction, handleDelete: deleteTransaction), label: {
                            VStack(alignment: .leading){
                                Text(transaction.title)
                                    .font(.headline)
                                Text(transaction.date.formatted())
                                    .font(.subheadline)
                            }.foregroundColor(.black)
                        })
                }.navigationTitle("Your transactions")
                    .navigationBarItems(trailing:
                                            NavigationLink(destination: {
                        AddTransactionView(handleAdd: addTransaction)
                    }){
                        Image(systemName: "plus")
                    }
                    )
            }
        }
        .onAppear{
            do{
                myUser = try data.loadUser()
                transactions = try data.loadTransactions()
            } catch{
                
            }
        }
    }
}

