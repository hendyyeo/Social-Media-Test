//
//  PostModel.swift
//  Social Media Test
//
//  Created by Hendy Rusnanto on 23/12/21.
//

import SwiftUI

struct PostModel: Identifiable {
    
    var id: String
    var title: String
    var pic: String
    var time: Date
    var user: UserModel
}
