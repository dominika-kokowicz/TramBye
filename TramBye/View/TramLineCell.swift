//
//  TramLineCell.swift
//  TramBye
//
//  Created by Dominika Kokowicz on 30/03/2021.
//

import UIKit


class TramLineCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: TramLineCell.self)
    
    @IBOutlet weak var tramLineLabel: UILabel!
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? .yellow : .white
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.layer.cornerRadius = 10.0
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    func configure(with title: String) {        
        tramLineLabel.text = title
    }
}
