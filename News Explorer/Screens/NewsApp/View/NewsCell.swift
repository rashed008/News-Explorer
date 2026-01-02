//
//  NewsCell.swift
//  News Explorer
//
//  Created by Rashed Pervez on 2/1/26.
//

import UIKit

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var newsBackgroundView: UIView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsDescriptionLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsPublishedTimeLabel: UILabel!
    @IBOutlet weak var newsContentLabel: UILabel!
    
    var article: Article? {
        didSet {
            newsDetailConfiguration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        newsDetailConfiguration()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func newsDetailConfiguration() {
        guard let article else { return }
        newsTitleLabel.text = article.title
        newsDescriptionLabel.text = article.description
        newsImageView.setImage(from: article.urlToImage ?? "")
        newsPublishedTimeLabel.text = article.publishedAt
        newsContentLabel.text = article.content
    }
    
    
}
