//
//  itemTBVCell.swift
//  VERO-Digital-Solutions-Tahir-Kizir-Interview
//
//  Created by Tahir Kizir on 14.03.2023.
//

import UIKit


class ProfilCell: UITableViewCell
{
    
    private lazy var descriptionLabel : UILabel =
    {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        label.textColor = UIColor(named:"multiColorBaseBlack")
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    func setCell(_ itemTuple:(String,Any,Bool))
    {
        let x = itemTuple.0
        let y = itemTuple.2
        if let d = itemTuple.1 as? String
        {
            if y
            {
                let attributedString1 = NSMutableAttributedString(string:"\(x)",attributes: [NSAttributedString.Key.foregroundColor:UIColor(named:"multiColorBaseBlack") ?? UIColor.black,NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15,weight: UIFont.Weight.regular)])
                let attributedString2 = NSMutableAttributedString(string:"\(d.prefix(140))...",attributes: [NSAttributedString.Key.foregroundColor:UIColor(named:"multiColorBaseBlack") ?? UIColor.black,NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15,weight: UIFont.Weight.regular)])
                let attributedString3 = NSMutableAttributedString(string:" read more",attributes: [NSAttributedString.Key.foregroundColor:UIColor.blue,NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15,weight: UIFont.Weight.regular)])
                
                attributedString1.append(attributedString2)
                attributedString1.append(attributedString3)
                
                descriptionLabel.attributedText = attributedString1
            }
            else
            {
                descriptionLabel.text = "\(x)\(d)"
            }
        }
        else
        {
            descriptionLabel.text = "\(x)\(itemTuple.1)"
        }
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
