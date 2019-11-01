//
//  Data.swift
//  Todoey
//
//  Created by Samuel Lopez on 10/31/19.
//  Copyright © 2019 Samuel Lopez. All rights reserved.
//

import Foundation
import RealmSwift

class Data : Object {
    @objc dynamic var name : String = ""
    @objc dynamic var age : Int = 0
}
