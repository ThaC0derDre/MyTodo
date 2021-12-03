//
//  Category.swift
//  MyTodo
//
//  Created by Andres Gutierrez on 11/30/21.
//

import Foundation
import RealmSwift

class Category: Object{
    @objc dynamic var name = ""
    let items = List<Items>()
}
