//
//  itemTBVCell.swift
//  VERO-Digital-Solutions-Tahir-Kizir-Interview
//
//  Created by Tahir Kizir on 14.03.2023.
//

import UIKit

class ItemCell: UITableViewCell
{
    
    private let taskLabel : UILabel =
    {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        label.textColor = UIColor(named:"multiColorBaseBlack")
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    
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
    
    private let colorLabel : UILabel =
    {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        label.transform = CGAffineTransform(rotationAngle: .pi/2)
        label.textColor = UIColor(named:"multiColorBaseBlack")
        return label
    }()
    
    private lazy var colorView : UIView =
    {
       let view = UIView()
       view.translatesAutoresizingMaskIntoConstraints = false
       view.addSubview(colorLabel)
       colorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor,constant: -16).isActive = true
       colorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
       return view
    }()
    
    func x_(h:String) -> String
    {
        var x = h
        x.removeFirst()
        return x
    }
    
    func a(hex:String) -> UIColor
    {
        let h = (hex.contains("#")) ? x_(h:hex) : hex
        
        var r = 0.0
        var g = 0.0
        var b = 0.0
        
        var x = 0.0
        var y = 0.0
        var z = 0.0
        
        for i in h
        {
            x += 1.0
            let k = (x == 1) ? ((i.isNumber) ? i.wholeNumberValue! * 16 : Int(exactly: i.asciiValue!)! * 16) : ((i.isNumber) ? i.wholeNumberValue! * 1 : Int(exactly: i.asciiValue!)! * 1)
            z += Double(k)
            if x == 2.0
            {
                y += 1.0
                if y == 1.0
                {
                    r = z
                }
                else if y == 2.0
                {
                    g = z
                }
                else
                {
                    b = z
                }
                x = 0.0
                z = 0.0
            }
        }
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    
    func setCell(_ item:Item)
    {
        taskLabel.text = item.task
        descriptionLabel.text = item.description
        colorLabel.text = item.colorCode
        taskLabel.text!.append("-\(item.title)")
        colorView.backgroundColor = (item.colorCode == "") ? UIColor(red: 0, green: 0, blue: 0, alpha: 0) : a(hex: item.colorCode)
    }
    
    func configureUI()
    {
        addSubview(taskLabel)
        taskLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        taskLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        taskLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        
        addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: taskLabel.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -36).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6).isActive = true
        
        addSubview(colorView)
        colorView.topAnchor.constraint(equalTo: taskLabel.topAnchor, constant: 0).isActive = true
        colorView.rightAnchor.constraint(equalTo: rightAnchor,constant: -2).isActive = true
        colorView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        colorView.bottomAnchor.constraint(equalTo: descriptionLabel.bottomAnchor,constant: 0).isActive = true
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
