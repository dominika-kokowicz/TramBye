//
//  TramLinesViewController.swift
//  TramBye
//
//  Created by Dominika Kokowicz on 18/03/2021.
//

import UIKit

class TramLinesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var tramLinesCollectionView: UICollectionView!
    let defaults = UserDefaults.standard
    var tramLines = [1,2,3,4,6,7,9,10,11,13,14,15,17,18,20,22,23,24,25,26,27,28,31,33,35,41]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tramLines.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        fatalError("return cell")

//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TramLineCell.reuseIdentifier, for: indexPath) as! TramLineCell
//        //cell.tramLineCellButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
//        cell.configure(with: "\(tramLines[indexPath.row])")
//        cell.tramLineCellButton.tag = tramLines[indexPath.row]
//           return cell
       }

      // @objc func buttonTapped(sender: UIButton?) {
//        guard let tag = sender?.tag else { return }
//        print(tag)
    
        //chosenTramLines.append(tag)
        //let url = tramsManager.fetchTramLineLocation(tramLine: String(tag))
        //urlsOfChosenTramLines.append(url)
        //tramsManager.performRequest(urlString: url)
//        let fuckingNewArray = Array(Set(chosenTramLines))
//        print("FLELELE FUCK \(fuckingNewArray)")
        
      // }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tramLinesCollectionView.delegate = self
        tramLinesCollectionView.dataSource = self
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let arrayToSave = chosenTramLines.removingDuplicates()
//        defaults.set(arrayToSave, forKey: "arrayToSave")
        
//        let destVC = segue.destination as! MapScreenViewController
//        //destVC.chosenTramLines2 = arrayToSave
//        print("Prepare for segue")
//
//    }

}




