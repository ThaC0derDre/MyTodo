//
//  Category.swift
//  MyTodo
//
//  Created by Andres Gutierrez on 11/30/21.
//

import Foundation
import RealmSwift
class Category: Object{
    
    @Persisted var name = ""
    let items = List<Items>()
    
}
