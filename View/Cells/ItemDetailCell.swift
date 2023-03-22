//
//  itemTBVCell.swift
//  VERO-Digital-Solutions-Tahir-Kizir-Interview
//
//  Created by Tahir Kizir on 14.03.2023.
//

import UIKit

class ItemDetailCell: UITableViewCell
{
    
    private let descriptionLabel : UILabel =
    {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        label.textColor = UIColor(named:"multiColorBaseBlack")
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    
    func setCell(_ itemTuple:(String,Any))
    {
        descriptionLabel.text = "\(itemTuple.0)\(itemTuple.1)"
    }
    
    func configureUI()
    {
        addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -6).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6).isActive = true
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)


        configureUI()

    }
    

    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

}
