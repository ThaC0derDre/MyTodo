//
//  Items.swift
//  MyTodo
//
//  Created by Andres Gutierrez on 11/27/21.
//

import Foundation
import RealmSwift

class Items: Object{
    @Persisted var title = ""
    @Persisted var done = false
    
}
