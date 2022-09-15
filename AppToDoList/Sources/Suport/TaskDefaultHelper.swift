//
//  TaskDefaultHelper.swift
//  AppToDoList
//
//  Created by Jean Lucas Vitor on 14/09/22.
//

import Foundation

class TaskDefaultHelper {
    
    //MARK: - Public propertie
    let keyTask: String = "keyString"
    
    //MARK: - Public methods
    func saveTaskList(list: [Task]) {
        do {
            let auxList = try JSONEncoder().encode(list)
            UserDefaults.standard.set(auxList, forKey: keyTask)
        } catch {
            print(error)
        }
    }
    
    func getTaskList() -> [Task] {
        do {
            guard let list = UserDefaults.standard.object(forKey: keyTask) else { return [] }
            let auxList = try JSONDecoder().decode([Task].self, from: list as! Data)
            return auxList
        } catch {
            print(error)
        }
        
        return []
    }
    
    func updateTask(task: Task) {
        var list: [Task] = getTaskList()
        list.removeAll { taskList in
            return taskList.id == task.id
        }
        list.append(task)
        saveTaskList(list: list)
    }
    
    func deleteTask(task: Task) {
        var list: [Task] = getTaskList()
        list.removeAll { taskList in
            return taskList.id == task.id
        }
        saveTaskList(list: list)
    }
    
    func getNextId() -> Int {
        let list: [Task] = getTaskList()
        
        for index in 0...list.count {
            let auxList = list.filter {$0.id == index}
            
            if auxList.count == 0 {
                return index
            }
        }
        
        return 0
    }
}
