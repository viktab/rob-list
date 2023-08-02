//
//  dbDefinitions.swift
//  rob list
//
//  Created by Viktoriya Tabunshchyk on 7/20/23.
//

import Foundation

import RealmSwift

class UserProfile: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var realmId: String = ""
    @Persisted var email: String = ""
    @Persisted var name: String = ""
    @Persisted var username: String = ""
    @Persisted var bio: String = ""
    @Persisted var posts: List<ObjectId>
    @Persisted var followingUsers: List<ObjectId>
    @Persisted var followingGroups: List<ObjectId>
    @Persisted var followingIdols: List<ObjectId>
    @Persisted var followingEras: List<ObjectId>
    convenience init(realmId: String, name: String, email: String, username: String) {
        self.init()
        self.realmId = realmId
        self.name = name
        self.email = email
        self.username = username
        self.posts = List()
        self.followingUsers = List()
        self.followingGroups = List()
        self.followingIdols = List()
        self.followingEras = List()
    }
}

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

class Post: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var timestamp: Date = Date()
    @Persisted var userId: ObjectId = ObjectId()
    @Persisted var type: String = ""
    @Persisted var caption: String = ""
    @Persisted var price: Float = 0.0
    @Persisted var haveGroups: List<ObjectId> = List()
    @Persisted var haveMembers: List<ObjectId> = List()
    @Persisted var haveEras: List<ObjectId> = List()
    @Persisted var wantGroups: List<ObjectId> = List()
    @Persisted var wantMembers: List<ObjectId> = List()
    @Persisted var wantEras: List<ObjectId> = List()
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
