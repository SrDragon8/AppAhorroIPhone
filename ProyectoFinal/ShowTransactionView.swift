//
//  ShowTransactionView.swift
//  ProyectoFinal
//
//  Created by iOS Lab on 01/06/23.
//

import SwiftUI

struct ShowTransactionView: View {
    let transaction: TransactionModel
    var handleDelete: (TransactionModel) -> Bool
    
    @Environment(\.presentationMode) var presentation
    
    @State var show = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(transaction.title)
                .font(.title)
                .fontWeight(.bold)
            
            Text(transaction.date.formatted())
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text(transaction.category)
                .font(.headline)
                .foregroundColor(.blue)
            
            Text("$\(transaction.amount.redondear(numeroDecimales: 2))")
                .font(.headline)
                .foregroundColor(.green)
            
            if !transaction.description.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Descripción:")
                        .font(.headline)
                    
                    Text(transaction.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                .padding(.vertical)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.2))
                )
            }
            
            Button(action: {
                if handleDelete(transaction) {
                    presentation.wrappedValue.dismiss()
                }
            }, label: {
                Text("Delete transaction")
                    .font(.headline)
                    .foregroundColor(.red)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.red.opacity(0.2))
                    )
            })
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
        .padding()
    }
}
