//
//  infoCell.swift
//  MyTelstra_Evaluation
//
//  Created by N, Azik Abdullah (Cognizant) on 27/06/20.
//  Copyright © 2020 N, Azik Abdullah (Cognizant). All rights reserved.
//

import UIKit
import LazyImage
class InfoCell: UITableViewCell {
    lazy var lazyImage:LazyImage = LazyImage()
    var factContent:FactContent? {
        didSet {
            guard let contentItem = factContent else {return}
            
            if let titleText = contentItem.title {
                titleLabel.text = titleText
            } else {
                titleLabel.text = ""//Restrict data mixup with other rows
            }
            
            if let descriptionText = contentItem.description {
                descriptionLabel.text = "\(descriptionText)"
                descriptionLabel.sizeToFit()//height restrictions to the text content
            } else {
                descriptionLabel.text = ""
            }
            
            detailsImageView.image = UIImage(named: "placeholder")
            self.lazyImage.show(imageView: self.detailsImageView, url: contentItem.imageHref ?? "", completion: { (error:LazyImageError?) in//Imagedownload and show
                if error != nil {//Any issue in downloading image will show placeholder
                    self.detailsImageView.image = UIImage(named: "placeholder")
                }
            })
        }
    }
        
    let detailsImageView:LazyImageView = {
        let img = LazyImageView()
        img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.clipsToBounds = true
        return img
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .black
        label.clipsToBounds = true
        label.numberOfLines = 0//for n number of lines
        label.lineBreakMode = .byWordWrapping//For multiple lines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(detailsImageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(descriptionLabel)
    
        let views: [String: Any] = [
          "detailsImageView": detailsImageView,
          "titleLabel": titleLabel,
          "descriptionLabel": descriptionLabel]
    
        var allConstraints: [NSLayoutConstraint] = []
    
        let imageVerticalConstraints = NSLayoutConstraint.constraints(//Imageview y position and height
          withVisualFormat: "V:|-15-[detailsImageView(70)]",
          metrics: nil,
          views: views)
        allConstraints += imageVerticalConstraints
    
        let titleLabelVerticalConstraints = NSLayoutConstraint.constraints(//Title y position and height
          withVisualFormat: "V:|-10-[titleLabel(30)]",
          metrics: nil,
          views: views)
        allConstraints += titleLabelVerticalConstraints
    
        let descriptionLabelVerticalConstraints = NSLayoutConstraint.constraints(//Description Label y position
          withVisualFormat: "V:|-50-[descriptionLabel]",
          metrics: nil,
          views: views)
        allConstraints += descriptionLabelVerticalConstraints
    
        let imageHorizontalConstraints = NSLayoutConstraint.constraints(//Imageview x position and Width
          withVisualFormat: "H:|-10-[detailsImageView(70)]",
          metrics: nil,
          views: views)
        allConstraints += imageHorizontalConstraints
    
        let titleLabelHorizontalConstraints = NSLayoutConstraint.constraints(//Title x position and width
          withVisualFormat: "H:[detailsImageView]-10-[titleLabel(300)]",
          metrics: nil,
          views: views)
        allConstraints += titleLabelHorizontalConstraints
    
        let descriptionLabelHorizontalConstraints = NSLayoutConstraint.constraints(//Description Label x position
          withVisualFormat: "H:[detailsImageView]-10-[descriptionLabel]",
          metrics: nil,
          views: views)
        allConstraints += descriptionLabelHorizontalConstraints
        NSLayoutConstraint.activate(allConstraints)

        descriptionLabel.topAnchor.constraint(equalTo:self.detailsImageView.centerYAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo:titleLabel.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true//Description label height and width is dynamically adjusted
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
