//
//  TramLinesViewController.swift
//  TramBye
//
//  Created by Dominika Kokowicz on 18/03/2021.
//

import UIKit

class TramLinesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var viewModel = TramLinesViewModel()

    @IBOutlet weak var tramLinesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tramLinesCollectionView.delegate = self
        tramLinesCollectionView.dataSource = self
        tramLinesCollectionView.allowsMultipleSelection = true
       
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }

}

extension TramLinesViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.tramLines.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TramLineCell.reuseIdentifier, for: indexPath) as! TramLineCell
        
        let line = "\(viewModel.tramLines[indexPath.row])"
        cell.configure(with: line)
        
        viewModel.isLineSelected( line )
            ? collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
            : collectionView.deselectItem(at: indexPath, animated: true)
        
        cell.isSelected = viewModel.isLineSelected( line )
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! TramLineCell
        
        cell.tramLineLabel.text
            .map { (selectedLine: String) in
                viewModel.didSelect(line: selectedLine)
            }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! TramLineCell
        
        cell.tramLineLabel.text
            .map { (selectedLine: String) in
                viewModel.didDeselect(line: selectedLine)
            }
    }
}
