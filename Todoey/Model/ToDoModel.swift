//
//  ToDoModel.swift
//  Todoey
//
//  Created by Maxim on 6/15/18.
//  Copyright © 2018 Oldmen. All rights reserved.
//

import Foundation

class ToDoModel: Encodable, Decodable{
    var name : String = ""
    var isChecked : Bool = false
    
    init(name : String, isChecked : Bool) {
        self.name = name
        self.isChecked = isChecked
    }
}
