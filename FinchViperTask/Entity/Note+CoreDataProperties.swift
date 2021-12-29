//
//  Note+CoreDataProperties.swift
//  FinchViperTask
//
//  Created by Alex on 26.12.2021.
//
//

import Foundation
import CoreData

extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var titleNote: String?
    @NSManaged public var descriptionNote: String?
    @NSManaged public var imageNote: Data?

}
