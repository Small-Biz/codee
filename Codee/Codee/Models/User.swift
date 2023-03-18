//
//  User.swift
//  Codee
//
//  Created by Ray Cheng on 14/9/2022.
//

import Foundation

class User: Hashable{
    
    var name: String!
    var gender: Int!
    
    required init?(){}
    
    required init(name: String, gender:Int){
        self.name=name
        self.gender=gender
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(gender)
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.name == rhs.name && lhs.gender == rhs.gender
    }
    
}
