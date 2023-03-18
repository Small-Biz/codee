//
//  TaskMenuCollectionCell.swift
//  Codee
//
//  Created by Ray Cheng on 1/9/2022.
//

import UIKit

class TaskMenuCollectionCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var badgeImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    /*
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame:CGRect){
        super.init(frame: frame)

        contentView.addSubview(imageView)
        
        let images = [
            UIImage(named: "resource/image/icon_tick.png"),
            UIImage(named: "resource/image/icon_cross.png"),
            UIImage(named: "resource/image/icon_tick.png"),
            UIImage(named: "resource/image/icon_cross.png"),
            UIImage(named: "resource/image/icon_tick.png"),
            UIImage(named: "resource/image/icon_cross.png"),
            UIImage(named: "resource/image/icon_tick.png"),
            UIImage(named: "resource/image/icon_cross.png"),
            UIImage(named: "resource/image/icon_tick.png"),
            UIImage(named: "resource/image/icon_cross.png"),
            UIImage(named: "resource/image/icon_tick.png"),
            UIImage(named: "resource/image/icon_cross.png"),
            UIImage(named: "resource/image/icon_tick.png"),
            UIImage(named: "resource/image/icon_cross.png")
        ].compactMap({ $0})
        imageView.image = images.randomElement()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame=contentView.frame
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        imageView.image = nil
    }
    */


}
