//
//  CoreDataStack.swift
//  LearnSwiftKnowledge
//
//  Created by 刘帅 on 2026/1/16.
//


import CoreData

/// CoreData管理工具
class CoreDataManager {
    //    单例对象
    static let shared = CoreDataManager()

    private init() {}

    // MARK: - Persistent Container
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "LearnSwiftKnowledge") // 替换为你的 .xcdatamodeld 文件名
        // 启用自动合并（关键！）
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Core Data 加载失败:\(error), \(error.userInfo)")
            }
        }
        return container
    }()
    // MARK: - 主线程上下文
    var mainContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    // MARK: - 后台线程上下文
    func backgroundContext() -> NSManagedObjectContext {
        let context = persistentContainer.newBackgroundContext()
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        // 注意：不需要手动 merge，因为 viewContext 已开启 automaticallyMergesChangesFromParent
        return context
    }
    // MARK: - 主线程保存
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("保存上下文失败: \(nserror), \(nserror.userInfo)")
            }
        }
    }
    //MARK: - 后台线程保存
    func saveBackgroundContext(_ context: NSManagedObjectContext) {
        if context.hasChanges {
            context.perform {
                do {
                    try context.save()
                    // 保存成功后，viewContext 会自动合并（因开启了 automaticallyMergesChangesFromParent）
                } catch {
                    let nserror = error as NSError
                    fatalError("后台上下文保存失败: \(nserror), \(nserror.userInfo)")
                }
            }
        }
    }
    
 
}
