//
//  User.swift
//  Nate tech interview
//
//  Created by Kyo on 11/9/20.
//

import Foundation

struct Order {
    let product: API.ProductResponse
    let purchaseDate: Date
}

class User {
    static let shared = User()
    private(set) var name = "Kyeore Heo"
    private(set) var email = "91kyoheo@gmail.com"
    private(set) var address = Address(street: "45 River Drive South #1509", city: "Jersey City", state: "NJ", zipcode: "07310")
    private(set) var card = Card(number: "4419 5849 1004 3030", cvv: "330")
    private(set) var phone = "808 457 6940"
    private(set) var orders = [Order]()
    
    func addresToString() -> String {
        return "\(address.street), \(address.city), \(address.state), \(address.zipcode)"
    }
    
    func setName(_ name: String) { self.name = name }
    func setEmail(_ email: String) { self.email = email }
    func setAddress(_ address: Address) { self.address = address }
    func setCard(_ card: Card) { self.card = card }
    func setPhone(_ phone: String) { self.phone = phone }
    func addOrder(_ product: API.ProductResponse) { self.orders.append(Order(product: product, purchaseDate: Date())) }
    
}
