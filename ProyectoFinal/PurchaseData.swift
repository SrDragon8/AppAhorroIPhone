//
//  PurchaseData.swift
//  ProyectoFinal
//
//  Created by iOS Lab on 30/05/23.
//

import Foundation

struct TransactionModel: Identifiable, Encodable, Decodable, Equatable {
    
    let id: UUID
    let title: String
    let date: Date
    let amount: Float
    let category: String
    let description: String
    
}


