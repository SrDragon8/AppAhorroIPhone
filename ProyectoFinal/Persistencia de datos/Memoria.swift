//
//  Memoria.swift
//  ProyectoFinal
//
//  Created by iOS Lab on 25/05/23.
//

import Foundation

class DataPersistence {
    private let fileManager =  FileManager.default
    private let documentDirectory: URL
    private let itemsURL: URL
    
    //Constructor de objetos. Sobreescribe el constructor por defecto
    init(){
        self.documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.itemsURL = documentDirectory.appendingPathComponent("items").appendingPathExtension("json")
    }
    
    //Throws dice "tú no tienes que manejar los errores, de eso se encarga quien cache estas cosas"
    func saveTransactions(transactions: [TransactionModel]) throws{
        let encoder = JSONEncoder()
        let encodedItems = try encoder.encode(transactions)
        try encodedItems.write(to: itemsURL)
    }
    
    func loadTransactions() throws -> [TransactionModel]{
        guard fileManager.fileExists(atPath: itemsURL.path) else {
            return[]
        }
        let decoder = JSONDecoder()
        let decodedItems = try decoder.decode([TransactionModel].self, from: Data(contentsOf: itemsURL))
        return decodedItems
    }
    
    func saveUser(user: userModel) throws{
        let encoder = JSONEncoder()
        let encodedUser = try encoder.encode(user)
        try encodedUser.write(to: itemsURL)
    }
    
    func loadUser() throws -> userModel{
        guard fileManager.fileExists(atPath: itemsURL.path) else {
            return userModel.defaultUser
        }
        let decoder = JSONDecoder()
        let decodedUser = try decoder.decode(userModel.self, from: Data(contentsOf: itemsURL))
        return decodedUser
    }
    
}

