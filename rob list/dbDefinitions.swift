//
//  dbDefinitions.swift
//  rob list
//
//  Created by Viktoriya Tabunshchyk on 7/20/23.
//

import Foundation

import RealmSwift

class Group: Object {
   @Persisted(primaryKey: true) var _id: ObjectId
   @Persisted var name: String = ""
   @Persisted var idols: List<ObjectId>
   @Persisted var eras: List<ObjectId>
   @Persisted var posts: List<ObjectId>
   convenience init(name: String) {
       self.init()
       self.name = name
       self.idols = List()
       self.eras = List()
       self.posts = List()
   }
}

class Idol: Object {
   @Persisted(primaryKey: true) var _id: ObjectId
   @Persisted var name: String = ""
   @Persisted var group: ObjectId
   @Persisted var eras: List<ObjectId>
   @Persisted var posts: List<ObjectId>
   convenience init(name: String, group: ObjectId) {
       self.init()
       self.name = name
       self.group = group
       self.eras = List()
       self.posts = List()
   }
}

class RequestedGroup: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String = ""
    @Persisted var numRequests: Int
    @Persisted var requestedByUsers: List<ObjectId>
    convenience init(name: String) {
        self.init()
        self.name = name
        self.numRequests = 0
        self.requestedByUsers = List()
    }
}
