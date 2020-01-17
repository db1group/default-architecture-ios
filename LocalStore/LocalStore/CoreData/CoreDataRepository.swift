//
//  CoreDataRepository.swift
//
//  Created by Raul.Lermen on 15/01/20.
//  Copyright © 2020 DB1. All rights reserved.
//

import Foundation
import CoreData

/// Essa classe é utilizada para encapsular a lógica de acesso aos dados do contexto do CoreData.
/// Para adição de regras de negócio na manipulação de classes específicas do CoreData, é aconselhado a criação de extensões desse repositório.
///
/// Utilização:
///
/// Criação de um objeto
/// if let article = CoreDataRepository.create(new: Article.self) {
///    article.title = "Title"
///    article.subtitle = "Subtitle"
///    CoreDataRepository.save()
/// }
///
/// Listagem de objetos
/// if let result = CoreDataRepository.list(type: Article.self) {
///    print(result.map({ $0.title }))
/// }
///
/// Encontrar um objeto
/// if let article = CoreDataRepository.find(type: Article.self, id: 1) {
///    print(article)
/// }
///
/// Apagar um objeto
/// let result: Bool = CoreDataRepository.delete(type: Article.self, id: 1)

public class CoreDataRepository {

    public static func list<T: NSManagedObject>(type: T.Type, with predicate: NSPredicate? = nil) -> [T]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: T.entityName)
        request.predicate = predicate

        do {
            let result = try CoreDataManager.shared.context.fetch(request)
            return result as? [T]
        } catch {
            return nil
        }
    }

    public static func find<T: NSManagedObject>(type: T.Type, id: Int) -> T? {
        if !T.containsKey(key: "id") { return nil }
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: T.entityName)
        request.predicate = NSPredicate(format: "id == %@", String(describing: id))

        do {
            guard let object = try CoreDataManager.shared.context.fetch(request).first else { return nil }
            return object as? T
        } catch {
            return nil
        }
    }

    public static func create<T: NSManagedObject>(new type: T.Type) -> T? {
        let object = NSEntityDescription.insertNewObject(forEntityName: T.entityName, into: CoreDataManager.shared.context)
        return object as? T
    }

    @discardableResult
    public static func delete<T: NSManagedObject>(type: T.Type, id: Int) -> Bool {
        if !T.containsKey(key: "id") { return false }
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: T.entityName)
        request.predicate = NSPredicate(format: "id == %@", String(describing: id))

        do {
            guard let result = try CoreDataManager.shared.context.fetch(request).first as? NSManagedObject else { return false }
            CoreDataManager.shared.context.delete(result)
            return save()
        } catch {
            return false
        }
    }

    @discardableResult
    public static func save() -> Bool {
        do {
            try CoreDataManager.shared.context.save()
            return true
        } catch {
            return false
        }
    }

}
