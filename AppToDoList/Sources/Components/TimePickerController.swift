//
//  TimePickerController.swift
//  AppToDoList
//
//  Created by Jean Lucas Vitor on 14/09/22.
//

import UIKit

protocol TimePickerProtocol {
    func sendTime(from time: String)
}

class TimePickerController: UIViewController {

    //MARK: - Private properties
    @IBOutlet private weak var datePicker: UIDatePicker!
    
    //MARK: - Public properties
    var delegate: TimePickerProtocol?
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: - Private methods
    @IBAction private func cancelButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction private func okButton(_ sender: UIButton) {
        dismiss(animated: true) {
            guard let delegate = self.delegate else { return }
            let datePickerSelect: Date = self.datePicker.date
            let dateStr: String = Date().convertDateToString(
                date: datePickerSelect,
                dateFormatter: "HH:mm")
            delegate.sendTime(from: dateStr)
        }
    }
}
