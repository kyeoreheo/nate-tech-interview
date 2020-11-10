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
    //let address: Address
   // let card: Card
    let uid: String

    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid

        self.email = dictionary["email"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        
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
                          "ussername": user.username]

            DB_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
        }
    }
}
