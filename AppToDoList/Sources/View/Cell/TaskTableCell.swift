//
//  TaskTableCell.swift
//  AppToDoList
//
//  Created by Jean Lucas Vitor on 14/09/22.
//

import UIKit

class TaskTableCell: UITableViewCell {

    //MARK: - Private properties
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var hourLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    
    //MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Public method
    func config(date: String, hour: String, title: String) {
        dateLabel.text = date
        hourLabel.text = hour
        titleLabel.text = title
    }

}
