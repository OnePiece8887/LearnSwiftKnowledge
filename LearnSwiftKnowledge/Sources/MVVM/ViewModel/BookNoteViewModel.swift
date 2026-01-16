//
//  BookNoteViewModel.swift
//  LearnSwiftKnowledge
//
//  Created by 刘帅 on 2026/1/16.
//

import UIKit
import Combine
import CoreData

// MARK: - 协议抽象（便于 Mock）
protocol DataFetching {
    func InitCoreData() async throws
    func fetchItems() async throws -> [BookNoteModel?]
    func getItemByBookName(bookName: String) async throws -> [BookNoteModel?]
    func addNewItem(item: BookNoteModel)
}

class BookNoteViewModel{
    
   // MARK: - 输入：依赖注入
   private let dataService: DataFetching
    
   // MARK: - 初始化（依赖注入）
   init(dataService: DataFetching) {
       self.dataService = dataService
   }
    
    //MARK:- 输出 数据源
    private var bookNoteModels = CurrentValueSubject<[BookNoteModel?],Never>([])
    //MARK:- 输出 数据源发布者
    var bookNoteModelsPublisher: AnyPublisher<[BookNoteModel?],Never>{
        bookNoteModels.eraseToAnyPublisher()
    }
    
    //MARK:- 从CoreData中获取数据源
    func loadDataFromCoreData() {
        Task {
             let result =  try await dataService.fetchItems()
            await MainActor.run {
                // 发布数据源
                bookNoteModels.send(result)
            }
        }
    }
    //MARK:- 初始化数据
    func InitOriginCoreData() async throws{
        try await dataService.InitCoreData()
        loadDataFromCoreData()
    }
    
    //   添加新数据数据
    func addNewBookNote(bookNoteModel: BookNoteModel)  {
        dataService.addNewItem(item: bookNoteModel)
        loadDataFromCoreData()
    }
    
}

// MARK: - 示例服务实现（生产环境）
struct ProductionDataService: DataFetching {
    
    func InitCoreData() async throws{
        let coreDataManager = CoreDataManager.shared
        let context = coreDataManager.backgroundContext()
        try await context.perform {
              // 1. 获取所有对象
              let fetchRequest: NSFetchRequest<BookNote> = BookNote.fetchRequest()
              let objects = try context.fetch(fetchRequest)
              
              // 2. 逐个删除
              for object in objects {
                  context.delete(object)
              }
              
              // 3. 保存
              try context.save()
          }
    }
    
    func fetchItems() async throws -> [BookNoteModel?] {
        // 实际网络/Core Data 调用
        let coreDataManager = CoreDataManager.shared
        return try await coreDataManager.mainContext.perform {
            let result = try  coreDataManager.mainContext.fetch(BookNote.fetchRequest())
            let arr = result.map { booknote in
                BookNoteModel(bookName: booknote.bookName ?? "", age: booknote.age)
            }
            return arr
        }
    }
    
    func getItemByBookName(bookName: String) async throws -> [BookNoteModel?] {
        let coreDataManager = CoreDataManager.shared
        let request = BookNote.fetchRequest()
        request.predicate = NSPredicate(format: "bookName == %@", bookName)
        let result = try coreDataManager.mainContext.fetch(request).map {
            BookNoteModel(bookName: $0.bookName ?? "", age: $0.age)
        }
        return result
    }
    
    func addNewItem(item: BookNoteModel) {
        let coreDataManager = CoreDataManager.shared
        let booknote = BookNote(context: coreDataManager.mainContext)
        booknote.bookName = item.bookName
        booknote.age =  item.age
        coreDataManager.saveContext()
    }
}
 

