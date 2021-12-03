//
//  Items.swift
//  MyTodo
//
//  Created by Andres Gutierrez on 11/27/21.
//

import Foundation
import RealmSwift

class Items: Object{
    @objc dynamic  var title = ""
    @objc dynamic var done = false
    let parentCategory = LinkingObjects(fromType:Category.self, property:"items")
}
