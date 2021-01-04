//
//  FetchImage.swift
//  Pod
//
//  Created by Luke Bettridge on 29/12/2020.
//

import FirebaseStorage

func fetchImage(_ imageUrl: String?, completion: @escaping (Data) -> Void) {
    if let imageUrl = imageUrl {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        if let dirPath = paths.first {
            let url = dirPath.appendingPathComponent(imageUrl)
            if FileManager.default.fileExists(atPath: url.path) {
                if let data = try? Data(contentsOf: url) {
                    completion(data)
                    return
                }
            }
            
            let storage = Storage.storage()
            let ref = storage.reference(withPath: imageUrl)
            ref.write(toFile: url) { url, err in
                if let err = err {
                    print("Error writing image: \(err)")
                } else if let data = try? Data(contentsOf: url!) {
                    completion(data)
                }
            }
        }
    }
}
