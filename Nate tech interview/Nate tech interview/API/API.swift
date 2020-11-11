//
//  API.swift
//  Nate tech interview
//
//  Created by Kyo on 11/6/20.
//

import Alamofire
import Firebase

let DB_REF = Database.database().reference()
let DB_USERS = DB_REF.child("users")

class API {
    static let baseURL = "http://localhost:4000/graphql"
}
