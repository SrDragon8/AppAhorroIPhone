//
//  UserView.swift
//  ProyectoFinal
//
//  Created by iOS Lab on 30/05/23.
//

import SwiftUI

struct Userview: View {
    private var data = DataPersistence()
    @State private var user: userModel = userModel.defaultUser
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Section(header: Text("User Info").font(.largeTitle).fontWeight(.bold)) {
                Text("Hola \(user.name)")
                    .font(.title)
                    .foregroundColor(.blue)
                
                Text("Total purchases: \(user.purchaseAmount)")
                    .font(.headline)
            }
            
            VStack(alignment: .leading) {
                Text("Purchase Info")
                    .font(.title)
                    .fontWeight(.bold)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Purchase description:")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Food:")
                            .font(.subheadline)
                        Text("\(user.foodPurchases)")
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Need:")
                            .font(.subheadline)
                        Text("\(user.needPurchases)")
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Fun:")
                            .font(.subheadline)
                        Text("\(user.funPurchases)")
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
                )
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Budget Disponible")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Text("$\(user.remainingMoney.redondear(numeroDecimales: 2))")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(user.remainingMoney >= 0 ? .green : .red)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
                )
                
                VStack(alignment: .leading) {
                    Text("Budget Mensual")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Text("$\(user.monthBudget.redondear(numeroDecimales: 2))")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
                )
            }
        }
        .padding()
        .onAppear {
            do {
                user = try data.loadUser()
            } catch {}
        }
    }
}
