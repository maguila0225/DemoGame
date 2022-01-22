//
//  FirebaseExtension.swift
//  DemoGame
//
//  Created by OPSolutions on 1/22/22.
//

import Foundation
import FirebaseFirestore
import Firebase

extension UIViewController{

    func addFirestoreListener(collectionName: String, documentName: String, fieldName: String, fieldValue: Any){
        let db = Firestore.firestore()
        db.collection(collectionName).document(documentName).parent.whereField(fieldName, isEqualTo: fieldValue)
            .addSnapshotListener { querySnapshot, error in
                guard let snapshot = querySnapshot else {
                    print("Error fetching snapshots: \(error!)")
                    return
                }
                snapshot.documentChanges.forEach { diff in
                    if (diff.type == .added) {
                        print("New city: \(diff.document.data())")
                    }
                    if (diff.type == .modified) {
                        print("Modified city: \(diff.document.data())")
                    }
                    if (diff.type == .removed) {
                        print("Removed city: \(diff.document.data())")
                    }
                }
            }
    }
}
