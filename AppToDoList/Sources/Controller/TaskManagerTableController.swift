//
//  TaskManagerTableController.swift
//  AppToDoList
//
//  Created by Jean Lucas Vitor on 12/09/22.
//

import UIKit
import FSCalendar

class TaskManagerTableController: UITableViewController {
    
    //MARK: - Private properties
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var calendar: FSCalendar!
    @IBOutlet private weak var timeButton: UIButton!
    @IBOutlet private weak var removeButton: UIButton!
    
    private var hour: String = ""
    private var date: String = ""
    
    //MARK: - Public properti
    var task: Task?
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        calendar.delegate = self
        configView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? TimePickerController {
            controller.delegate = self
        }
    }
    
    //MARK: - Private methods
    @IBAction private func backButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction private func openTimeComponent(_ sender: UIButton) {
        performSegue(withIdentifier: "segueTimeComponent", sender: nil)
    }
    
    @IBAction private func deleteTaskButton(_ sender: UIButton) {
        TaskDefaultHelper().deleteTask(task: task!)
        dismiss(animated: true)
    }
    
    @IBAction private func createTaskButton(_ sender: UIButton) {
        createTask()
    }
    
    private func configView() {
        removeButton.isHidden = task == nil
        guard let auxTask = task else { return }
        titleTextField.text = auxTask.title
        date = auxTask.date
        hour = auxTask.hour
        timeButton.setTitle(auxTask.hour, for: .normal)
    }
    
    private func createTask() {
        if task != nil {
            task!.date = date
            task!.hour = hour
            task!.title = titleTextField.text!
            
            TaskDefaultHelper().updateTask(task: task!)
        } else {
            var list: [Task] = TaskDefaultHelper().getTaskList()
            let task: Task = Task(
                id: TaskDefaultHelper().getNextId(),
                title: titleTextField.text ?? "Sem título",
                hour: self.hour,
                date: self.date)
            
            list.append(task)
            TaskDefaultHelper().saveTaskList(list: list)
        }
        
        dismiss(animated: true)
    }
}

//MARK: - FSCalendarDelegate
extension TaskManagerTableController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.date = Date().convertDateToString( date: date, dateFormatter: "dd/MM/yyyy")
    }
}

//MARK: - FSCalendarDelegateAppearance
extension TaskManagerTableController: FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        let auxDate = Date().convertDateToString(date: date, dateFormatter: "dd/MM/yyyy")
        
        if task != nil {
            if self.date == auxDate {
                return .green
            }
        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        let auxDate = Date().convertDateToString(date: date, dateFormatter: "dd/MM/yyyy")
        
        if task != nil {
            if self.date == auxDate {
                return .black
            }
        }
        return nil
    }
}

//MARK: - TimePickerProtocol
extension TaskManagerTableController: TimePickerProtocol {
    func sendTime(from time: String) {
        timeButton.setTitle(time, for: .normal)
        hour = time
    }
}

// MARK: - UITableViewDataSource
extension TaskManagerTableController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
}
