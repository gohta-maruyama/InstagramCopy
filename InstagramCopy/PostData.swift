//
//  PostData.swift
//  InstagramCopy
//
//  Created by 丸山昂大 on 2021/11/26.
//

import UIKit
import Firebase

class PostData: NSObject {
    var id: String
    var name: String?
    var caption: String?
    var date: Date?
    var likes: [String] = []
    var isLiked: Bool = false
    
    init(document: QueryDocumentSnapshot){
        self.id = document.documentID
        
        let postDic = document.data()
        
        self.name = postDic["name"] as? String
        
        self.caption = postDic["caption"] as? String
        
        let timestamp = postDic["date"] as? Timestamp
        self.date = timestamp?.dateValue()
        
        if let likes = postDic["likes"] as? [String]{
            self.likes = likes
        }
        if let myid = Auth.auth().currentUser?.uid {
            if self.likes.firstIndex(of: myid) != nil {
                self.isLiked = true
            }
        }
    }
}
