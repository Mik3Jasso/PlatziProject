//
//  File.swift
//  PlatziProject
//
//  Created by Mike Jasso on 12/07/24.
//

import Foundation
import RealmSwift

class FavVideo: Object, Identifiable {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var videoID: Int

    class override func primaryKey() -> String? {
        "id"
    }
}
