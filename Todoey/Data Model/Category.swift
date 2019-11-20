//
//  Category.swift
//  Todoey
//
//  Created by Samuel Lopez on 11/4/19.
//  Copyright © 2019 Samuel Lopez. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object{
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
