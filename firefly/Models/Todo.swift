//
//  Todo.swift
//  firefly
//
//  Created by Rodrigo, Thenuk (Coll) on 11/06/2024.
//

import Foundation
import FirebaseFirestore

struct Todo {
    let content: String
    let createdAt: Date
    
    init(data: [String: Any]) {
        self.content = data["content"] as? String ?? ""
        let timestamp = data["creaetedAt"] as? Timestamp ?? nil
        self.createdAt = timestamp?.dateValue() ?? Date()
    }
}



