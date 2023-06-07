//
//  userModel.swift
//  ProyectoFinal
//
//  Created by iOS Lab on 01/06/23.
//

import Foundation

struct userModel: Encodable, Decodable {
    let name: String
    let monthBudget: Float
    let remainingMoney: Float
    let purchaseAmount: Int
    let foodPurchases: Int
    let funPurchases: Int
    let needPurchases: Int
}

extension userModel{
    static let defaultUser = userModel(name: "usuario", monthBudget: 0.0, remainingMoney: 0.0, purchaseAmount: 0, foodPurchases: 0, funPurchases: 0, needPurchases: 0)
}
