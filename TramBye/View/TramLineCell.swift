//
//  TramLineCell.swift
//  TramBye
//
//  Created by Dominika Kokowicz on 30/03/2021.
//

import UIKit

protocol TramsCollectionViewCellDelegate: AnyObject {
    func didTapButton(with title: String)
}

class TramLineCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: TramLineCell.self)
    private var title: String = ""
    weak var delegate: TramsCollectionViewCellDelegate?
    
    @IBOutlet weak var tramLineCellButton: UIButton!
    
    func configure(with title: String) {
        self.layer.cornerRadius = 10.0
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.title = title
        tramLineCellButton.setTitle(title, for: .normal)
    
    }
    
    @IBAction func tramLineCellButtonTapped(_ sender: UIButton) {
        
        delegate?.didTapButton(with: title)

        if !sender.isSelected {
            sender.isSelected = true
            self.contentView.backgroundColor = UIColor.yellow
        }
        else {
            sender.isSelected = false
            self.contentView.backgroundColor = UIColor.white
        }
    
    }
   
}
