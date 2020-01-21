//
//  LocalStoreTests.swift
//  LocalStoreTests
//
//  Created by Raul.Lermen on 17/01/20.
//  Copyright © 2020 db1. All rights reserved.
//

import XCTest
@testable import LocalStore

class LocalStoreTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCreateAsset() {
        CoreDataRepository.deleteAll(type: Article.self)
        
        let newId: Int = 1
        if let article = CoreDataRepository.create(new: Article.self) {
            article.id = Int16(newId)
            article.title = "Title"
            article.subtitle = "Subtitle"
            CoreDataRepository.save()
        }
        
        let created = CoreDataRepository.find(type: Article.self, id: newId)
        XCTAssertNotNil(created)
    }
    
    func testListAssets() {
        CoreDataRepository.deleteAll(type: Article.self)
        
        let total = 3
        for i in 0..<total {
            if let article = CoreDataRepository.create(new: Article.self) {
                article.id = Int16(i)
                article.title = "Title"
                article.subtitle = "Subtitle"
                CoreDataRepository.save()
            }
        }
        
        let totalInserted = CoreDataRepository.list(type: Article.self)?.count
        XCTAssertEqual(totalInserted, total)
    }
    
    func testFindAsset() {
        CoreDataRepository.deleteAll(type: Article.self)
        
        let newId: Int = 1
        if let article = CoreDataRepository.create(new: Article.self) {
            article.id = Int16(newId)
            article.title = "titulo teste"
            article.subtitle = "subtitulo teste"
            CoreDataRepository.save()
            
            let found = CoreDataRepository.find(type: Article.self, id: newId)
            XCTAssertEqual(found, article)
            return
        }
        
        XCTFail("Erro ao criar item")
    }
    
    func testDeleteAsset() {
        CoreDataRepository.deleteAll(type: Article.self)
        
        let newId: Int = 1
        if let article = CoreDataRepository.create(new: Article.self) {
            article.id = Int16(newId)
            article.title = "Title"
            article.subtitle = "Subtitle"
            CoreDataRepository.save()
        }
        
        let deleted = CoreDataRepository.delete(type: Article.self, id: newId)
        XCTAssertTrue(deleted)
    }


}
