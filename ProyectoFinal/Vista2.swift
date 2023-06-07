//
//  Vista2.swift
//  ProyectoFinal
//
//  Created by iOS Lab on 25/05/23.
//

import SwiftUI

struct Vista2: View {
    @State private var data = DataPersistence()
    @State private var newUserName = ""
    @State private var newUserBudget = ""
    @State private var status = false
    @State private var emptyFields = false
    @State private var wrongInput = false
    @State private var showAlert = false
    @State private var myUser: userModel = userModel.defaultUser
    
    private func saveNewUser() {
        if !newUserName.isEmpty || !newUserBudget.isEmpty {
            let newBudget = Float(newUserBudget) ?? -1
            
            if !newUserName.isEmpty && !newUserBudget.isEmpty {
                if newBudget <= 0 {
                    wrongInput = true
                    showAlert = true
                } else {
                    let newRemainingMoney = myUser.remainingMoney + newBudget - myUser.monthBudget
                    myUser = userModel(name: newUserName, monthBudget: newBudget, remainingMoney: newRemainingMoney, purchaseAmount: myUser.purchaseAmount, foodPurchases: myUser.foodPurchases, funPurchases: myUser.funPurchases, needPurchases: myUser.needPurchases)
                }
            } else {
                if !newUserName.isEmpty {
                    myUser = userModel(name: newUserName, monthBudget: myUser.monthBudget, remainingMoney: myUser.remainingMoney, purchaseAmount: myUser.purchaseAmount, foodPurchases: myUser.foodPurchases, funPurchases: myUser.funPurchases, needPurchases: myUser.needPurchases)
                } else {
                    if newBudget <= 0 {
                        wrongInput = true
                        showAlert = true
                    } else {
                        let newRemainingMoney = myUser.remainingMoney + newBudget - myUser.monthBudget
                        myUser = userModel(name: myUser.name, monthBudget: newBudget, remainingMoney: newRemainingMoney, purchaseAmount: myUser.purchaseAmount, foodPurchases: myUser.foodPurchases, funPurchases: myUser.funPurchases, needPurchases: myUser.needPurchases)
                    }
                }
            }
            
            // Save user data
            do {
                try data.saveUser(user: myUser)
                status = true
            } catch {}
            
        } else {
            emptyFields = true
            showAlert = true
        }
    }
    
    var body: some View {
        VStack {
            Text("Change my info")
                .font(.title)
                .foregroundColor(.blue)
                .padding(.bottom, 16)
            
            VStack(spacing: 16) {
                TextField("New name", text: $newUserName)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
                    )
                
                TextField("New month budget", text: $newUserBudget)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
                    )
            }
            .padding(.horizontal)
            
            Button("Save changes") {
                saveNewUser()
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(10)
            .padding(.top, 16)
            
            Text("\(status ? "Cargado" : "Cargando")")
                .foregroundColor(.gray)
                .padding(.top, 8)
        }
        .padding()
        .alert(isPresented: $showAlert) {
            if emptyFields {
                return Alert(title: Text("Error"), message: Text("Por favor rellene bien los campos"), dismissButton: .default(Text("OK")))
            } else if wrongInput {
                return Alert(title: Text("Error"), message: Text("Ingrese una cantidad válida"), dismissButton: .default(Text("OK")))
            } else {
                return Alert(title: Text("Error"), message: Text("Error desconocido"), dismissButton: .default(Text("OK")))
            }
        }
        .onAppear {
            newUserName = ""
            newUserBudget = ""
            do {
                myUser = try data.loadUser()
            } catch {}
        }
    }
}
