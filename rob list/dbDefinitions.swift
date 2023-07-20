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
   @Persisted var idols: List<String>
   @Persisted var eras: List<String>
   @Persisted var posts: List<String>
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
   @Persisted var group: String = ""
   @Persisted var eras: List<String>
   @Persisted var posts: List<String>
   convenience init(name: String, group: String) {
       self.init()
       self.name = name
       self.group = group
       self.eras = List()
       self.posts = List()
   }
}
