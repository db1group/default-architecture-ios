//
//  ViewController.swift
//  Demo
//
//  Created by Glauco Dantas Beserra  on 16/01/20.
//  Copyright © 2020 Glauco Dantas Beserra . All rights reserved.
//

import UIKit
import LocalStore

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func coreDataExample() {
        
        //MARK - Create article
        
        if let article = CoreDataRepository.create(new: Article.self) {
            article.id = 1
            article.title = "Title"
            article.subtitle = "Subtitle"
            CoreDataRepository.save()
        }
        
        //MARK - List Articles
        if let result = CoreDataRepository.list(type: Article.self) {
            print(result.map({ $0.title }))
        }
        
        //MARK - Find article
        if let article = CoreDataRepository.find(type: Article.self, id: 1) {
            print(article)
        }
        
        //MARK - Delete article
        let result: Bool = CoreDataRepository.delete(type: Article.self, id: 1)
        print(result)
    }


}

