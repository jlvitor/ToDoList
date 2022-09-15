//
//  ListTaskController.swift
//  AppToDoList
//
//  Created by Jean Lucas Vitor on 12/09/22.
//

import UIKit

class ListTaskController: UIViewController {
    
    //MARK: - Private properties
    @IBOutlet private weak var tableView: UITableView!
    
    private var taskList: [Task] = []
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        registerNib()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadList()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? TaskManagerTableController {
            guard let task = sender as? Task else { return }
            controller.task = task
        }
    }
    
    //MARK: - Private methods
    private func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func registerNib() {
        tableView.register(UINib(
            nibName: "EmptyTableCell",
            bundle: nil), forCellReuseIdentifier: "empityCell")
    }
    
    @IBAction private func addButtonAction(_ sender: UIButton) {
        callCreateTask(task: nil)
    }
    
    private func loadList() {
        taskList = TaskDefaultHelper().getTaskList()
        tableView.reloadData()
    }
    
    private func callCreateTask(task: Task?) {
        performSegue(withIdentifier: "createNewTaskSegue", sender: task)
    }
}

//MARK: - UITableViewDelegate
extension ListTaskController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if taskList.count > 0 {
            callCreateTask(task: taskList[indexPath.row])
        } else {
            callCreateTask(task: nil)
        }
    }
}

//MARK: - UITableViewDataSource
extension ListTaskController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count > 0 ? taskList.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if taskList.count > 0 {
            if let cell: TaskTableCell = tableView.dequeueReusableCell(withIdentifier: "cellTask", for: indexPath) as? TaskTableCell {
                let task: Task = taskList[indexPath.row]
                cell.config(
                    date: task.date,
                    hour: task.hour,
                    title: task.title)
                return cell
            }
        } else {
            if let cell: EmptyTableCell = tableView.dequeueReusableCell(withIdentifier: "empityCell", for: indexPath) as? EmptyTableCell {
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return taskList.count > 0 ? 70 : 141
    }
}
