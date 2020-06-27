//
//  infoCell.swift
//  MyTelstra_Evaluation
//
//  Created by N, Azik Abdullah (Cognizant) on 27/06/20.
//  Copyright © 2020 N, Azik Abdullah (Cognizant). All rights reserved.
//

import UIKit

class InfoCell: UITableViewCell {
    
    var factContent:FactContent? {
        didSet {
            guard let contentItem = factContent else {return}
            if let titleText = contentItem.title {
                titleLabel.text = titleText
            }
            if let descriptionText = contentItem.description {
                descriptionLabel.text = "\(descriptionText)"
                descriptionLabel.sizeToFit()
            }
        }
    }
        
    let detailsImageView:UIImageView = {
        let img = UIImageView()
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
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(detailsImageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(descriptionLabel)
        
        
        //
        let views: [String: Any] = [
          "detailsImageView": detailsImageView,
          "titleLabel": titleLabel,
          "descriptionLabel": descriptionLabel]

        //
        var allConstraints: [NSLayoutConstraint] = []

        //
        let imageVerticalConstraints = NSLayoutConstraint.constraints(
          withVisualFormat: "V:|-15-[detailsImageView(70)]",
          metrics: nil,
          views: views)
        allConstraints += imageVerticalConstraints

        //
        let titleLabelVerticalConstraints = NSLayoutConstraint.constraints(
          withVisualFormat: "V:|-10-[titleLabel(30)]",
          metrics: nil,
          views: views)
        allConstraints += titleLabelVerticalConstraints

        //
        let descriptionLabelVerticalConstraints = NSLayoutConstraint.constraints(
          withVisualFormat: "V:|-50-[descriptionLabel]",
          metrics: nil,
          views: views)
        allConstraints += descriptionLabelVerticalConstraints
        
        //
        let imageHorizontalConstraints = NSLayoutConstraint.constraints(
          withVisualFormat: "H:|-10-[detailsImageView(70)]",
          metrics: nil,
          views: views)
        allConstraints += imageHorizontalConstraints

        //
        let titleLabelHorizontalConstraints = NSLayoutConstraint.constraints(
          withVisualFormat: "H:[detailsImageView]-10-[titleLabel(300)]",
          metrics: nil,
          views: views)
        allConstraints += titleLabelHorizontalConstraints

        //
        let descriptionLabelHorizontalConstraints = NSLayoutConstraint.constraints(
          withVisualFormat: "H:[detailsImageView]-10-[descriptionLabel]",
          metrics: nil,
          views: views)
        allConstraints += descriptionLabelHorizontalConstraints

        NSLayoutConstraint.activate(allConstraints)

        descriptionLabel.topAnchor.constraint(equalTo:self.detailsImageView.centerYAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo:titleLabel.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
}

