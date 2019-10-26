//
//  ActivityTableView.swift
//  ios-recruitment
//
//  Created by Vinicius Mangueira on 16/10/19.
//  Copyright © 2019 Vinicius Mangueira. All rights reserved.
//

import UIKit

class ActivityTableView: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        translatesAutoresizingMaskIntoConstraints = false
        separatorStyle = .none
        backgroundColor = .clear
        
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        self.refreshControl = refreshControl
        addSubview(refreshControl)
        
    }
    
    func addRefreshAction(target: Any, action: Selector){
        guard let refreshControl = self.refreshControl else { return }
        refreshControl.addTarget(target, action: action, for: .valueChanged)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UILabel {
    convenience init(textColor: UIColor, font: UIFont) {
        self.init()
        self.textColor = textColor
        self.font = font
        self.lineBreakMode = .byWordWrapping
        self.numberOfLines = 2
    }
}
