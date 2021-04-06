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
       
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.viewWillDisappear()
    }

}

extension TramLinesViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.tramLines.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TramLineCell.reuseIdentifier, for: indexPath) as! TramLineCell
        cell.tramLineCellButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        cell.configure(with: "\(viewModel.tramLines[indexPath.row])")
        cell.tramLineCellButton.tag = viewModel.tramLines[indexPath.row]
           return cell
       }
    
 
}


