//
//  RealmService.swift
//  FindPhotos
//
//  Created by Iuliia Volkova on 22.10.2021.
//

import Foundation
import RealmSwift

class PhotoRealmObject: Object {
    @Persisted var id: String
    @Persisted var url: String
    
    convenience init(id: String, url: String) {
        self.init()
        self.id = id
        self.url = url
    }
}

class RealmDataBase {
    
    private let realm = try! Realm()
    
    func savePhoto (id: String, url: String) {
        let photo = PhotoRealmObject(id: id, url: url)
        try! realm.write {
            realm.add(photo)
        }
    }
    
    func deletePhoto(id: String) {
        let savedPhotos = realm.objects(PhotoRealmObject.self)
        let predicate = NSPredicate(format: "id == %@", id)
        let foundPhoto = savedPhotos.filter(predicate)
        try! realm.write {
            realm.delete(foundPhoto)
        }
    }
    
    func getSavedPhotos() -> [PhotoRealmObject] {
        let savedPhotos = realm.objects(PhotoRealmObject.self).toArray()
        return savedPhotos
    }
}


extension Results {
    func toArray() -> [Element] {
        return compactMap { $0 }
    }
}
