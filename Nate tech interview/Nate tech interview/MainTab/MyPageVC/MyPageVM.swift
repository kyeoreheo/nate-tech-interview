//
//  MyPageVM.swift
//  Nate tech interview
//
//  Created by Kyo on 11/6/20.
//

import UIKit
import Firebase

class MyPageVM {
    private let viewController: Any
    
    init(_ vc: Any) {
        self.viewController = vc
    }
    
    func checkAddressFormat() {
        guard let vc = viewController as? ChangeAddresssVC
        else { return }
        if vc.address.street != "" && vc.address.city != "" && vc.address.state.count >= 2 && vc.address.zipcode.count >= 5 {
            vc.confirmButton.backgroundColor = .orange
            vc.confirmButton.setTitleColor(.white, for: .normal)
            vc.confirmButton.layer.borderWidth = 0
            vc.confirmButton.isEnabled = true
        } else {
            vc.confirmButton.backgroundColor = .white
            vc.confirmButton.setTitleColor(.gray5, for: .normal)
            vc.confirmButton.layer.borderWidth = 2
            vc.confirmButton.isEnabled = false
        }
    }
    
    func checkCardFormat() {
        guard let vc = viewController as? ChangeCardVC
        else { return }
        if (vc.cardNumber.count == 19) && (vc.cvv.count == 3) {
            vc.confirmButton.backgroundColor = .orange
            vc.confirmButton.setTitleColor(.white, for: .normal)
            vc.confirmButton.layer.borderWidth = 0
            vc.confirmButton.isEnabled = true
        } else {
            vc.confirmButton.backgroundColor = .white
            vc.confirmButton.setTitleColor(.gray5, for: .normal)
            vc.confirmButton.layer.borderWidth = 2
            vc.confirmButton.isEnabled = false
        }
    }
    
    func checkPhoneNumberFormat() {
        guard let vc = viewController as? ChangePhoneVC
        else { return }
        
        if vc.phoneNumber.count == 12 {
            vc.confirmButton.backgroundColor = .orange
            vc.confirmButton.setTitleColor(.white, for: .normal)
            vc.confirmButton.layer.borderWidth = 0
            vc.confirmButton.isEnabled = true
        } else {
            vc.confirmButton.backgroundColor = .white
            vc.confirmButton.setTitleColor(.gray5, for: .normal)
            vc.confirmButton.layer.borderWidth = 2
            vc.confirmButton.isEnabled = false
        }
    }
    
    func fetchUser() {
        guard let vc = viewController as? MyPageVC,
              let username = vc.usernameInfoField.viewWithTag(1) as? UILabel,
              let email = vc.emailInfoField.viewWithTag(1) as? UILabel,
              let address = vc.addressInfoField.viewWithTag(1) as? UILabel,
              let card = vc.cardInfoField.viewWithTag(1) as? UILabel,
              let phone = vc.phoneInfoField.viewWithTag(1) as? UILabel
        else { return }
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        API.fetchUser(uid: uid) { response in
            User.shared.setName(response.username)
            User.shared.setEmail(response.email)
            User.shared.setAddress(response.address)
            User.shared.setCard(Card(number: response.card.number, cvv: ""))
            User.shared.setPhone(response.phoneNumber)
            
            username.text = User.shared.name
            email.text = User.shared.email
            address.text = User.shared.addresToString()
            card.text = User.shared.card.number
            phone.text = User.shared.phone
        }
    }
   
}
