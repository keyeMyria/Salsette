//
//  Salsette
//
//  Created by Marton Kerekes on 16/03/2017.
//  Copyright © 2017 Marton Kerekes. All rights reserved.
//

import UIKit

fileprivate let contentCellIdentifier = "ContentCell"
enum ContentViewConstants {
    static let margin: CGFloat = 16.0
    static let iPadNumberOfCellsPerRow: CGFloat = 3
    static let labelPadding: CGFloat = 56
    static let iphoneCellFixedHeight: CGFloat = 300
}

protocol ContentEntityInterface {
    var image: UIImage? { get }
    var title: String? { get }
    var organiser: String? { get }
}

class ContentViewController: UICollectionViewController {
 
    var items = [ContentEntityInterface]()
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let presentableContent = items[indexPath.row]
        let cell: ContentViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellIdentifier, for: indexPath) as! ContentViewCell
        
        cell.imageView.image = presentableContent.image
        cell.titleLabel.text = presentableContent.title
        cell.organiserLabel.text = presentableContent.organiser
        
        return cell
    }
}

class ContentViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var organiserLabel: UILabel!
}

class ContentViewLayout: UICollectionViewFlowLayout {
    var idiom: UIUserInterfaceIdiom = UIDevice.current.userInterfaceIdiom
    
    override func prepare() {
        self.scrollDirection = .vertical
        self.minimumLineSpacing = idiom == .pad ? 16 : 0
        self.minimumInteritemSpacing = idiom == .pad ? 16 : 0
        self.sectionInset = UIEdgeInsets(top: minimumLineSpacing, left: minimumLineSpacing, bottom: self.minimumLineSpacing, right: minimumLineSpacing)
        
        switch idiom {
        case .phone:
            guard let safeCollectionView = collectionView else { return }
            self.itemSize = CGSize(width: safeCollectionView.bounds.width, height: CGFloat(ContentViewConstants.iphoneCellFixedHeight))
        case .pad:
            let cellSize = calculateDynamicCellSize(forCells: ContentViewConstants.iPadNumberOfCellsPerRow, padding: minimumLineSpacing, margin: ContentViewConstants.margin)
            
            self.itemSize = CGSize(width: cellSize, height: cellSize + CGFloat(ContentViewConstants.labelPadding))
        default:
            super.prepare()
            return
        }
        super.prepare()
    }
    
    func calculateDynamicCellSize(forCells numberOfCellsPerRow: CGFloat, padding: CGFloat, margin: CGFloat) -> CGFloat {
        guard let width = collectionView?.bounds.width else {
            return 0
        }
        
        let totalMarginWidth = (numberOfCellsPerRow - 1) * padding
        return floor(((width - (2 * margin)) - totalMarginWidth) / numberOfCellsPerRow)
    }
}