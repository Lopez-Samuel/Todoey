//
//  Item.swift
//  Todoey
//
//  Created by Samuel Lopez on 11/4/19.
//  Copyright © 2019 Samuel Lopez. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated = NSDate()
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
