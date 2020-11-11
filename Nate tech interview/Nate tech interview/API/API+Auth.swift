//
//  API+Auth.swift
//  Nate tech interview
//
//  Created by Kyo on 11/10/20.
//

import Firebase

struct UserResponse {
    let email: String
    let username: String
    var address: Address
    let card: Card
    let uid: String
    let phoneNumber: String

    init(uid: String, dictionary: [String: AnyObject]) {
        guard let email = dictionary["email"] as? String,
              let username = dictionary["username"] as? String,
              let addressDic = dictionary ["address"] as? [String: Any],
              let street = addressDic["street"] as? String,
              let city = addressDic["city"] as? String,
              let state = addressDic["state"] as? String,
              let zipcode = addressDic["zipcode"] as? String,
              let cardNumber = dictionary["cardNumber"] as? String,
              let phoneNumber = dictionary["phoneNumber"] as? String
        else {
            self.uid = ""
            self.email = ""
            self.username = ""
            self.address = Address(street: "", city: "", state: "", zipcode: "")
            self.card = Card(number: "", cvv: "")
            self.phoneNumber = ""
            return
        }
        
        self.uid = uid
        self.email = email
        self.username = username
        self.address = Address(street: street, city: city, state: state, zipcode: zipcode)
        self.card = Card(number: cardNumber, cvv: "000")
        self.phoneNumber = phoneNumber
    }
}

struct AuthProperties {
    let email: String
    let password: String
    let username: String
}

extension API {
    static func registerUser(user: AuthProperties, completion: @escaping(Error?, DatabaseReference?) -> Void ) {
        let filename = NSUUID().uuidString
        Auth.auth().createUser(withEmail: user.email, password: user.password) { result, error in
            if let error = error {
                print("Error is \(error.localizedDescription)")
                completion(error, nil)
                return
            }

            guard let uid = result?.user.uid else { return }
            let values = ["email": user.email,
                          "username": user.username,
                          "address": ["street" : "",
                                      "city" : "",
                                      "state" : "",
                                      "zipcode" : ""],
                          "cardNumber" : "",
                          "phoneNumber" : ""] as [String : Any]

            DB_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
        }
    }
    
    static func logIn(email: String, password: String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    static func fetchUser(uid: String, completion: @escaping(UserResponse) -> Void) {
        DB_USERS.child(uid).observe(DataEventType.value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }

            let user = UserResponse(uid: uid, dictionary: dictionary)
            completion(user)
        })
    }
    
    static func changeAddresss(address: Address, completion: @escaping(Error?, DatabaseReference?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        DB_USERS.child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            let updates = ["address": ["street" : address.street, "city" : address.city, "state" : address.state, "zipcode" : address.zipcode]]
            DB_USERS.child(uid).updateChildValues(updates, withCompletionBlock: completion)
          }) { error in
            print(error.localizedDescription)
        }
    }
    
    static func changeCard(cardNumber: String, completion: @escaping(Error?, DatabaseReference?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        DB_USERS.child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            let updates = ["cardNumber": cardNumber]
            DB_USERS.child(uid).updateChildValues(updates, withCompletionBlock: completion)
          }) { error in
            print(error.localizedDescription)
        }
    }
    
    static func changePhoneNumber(phoneNumber: String, completion: @escaping(Error?, DatabaseReference?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        DB_USERS.child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            let updates = ["phoneNumber": phoneNumber]
            DB_USERS.child(uid).updateChildValues(updates, withCompletionBlock: completion)
          }) { error in
            print(error.localizedDescription)
        }
    }
    
}
