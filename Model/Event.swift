//
//  Event.swift
//  VERO-Digital-Solutions-Tahir-Kizir-Interview
//
//  Created by Tahir Kizir on 17.03.2023.
//

import UIKit

struct Event
{
    func showError(_ title:String?,_ message:String?)->UIAlertController
    {
        let a = UIAlertController(title: title, message: "error code:"+(message ?? "-"), preferredStyle: .alert)
        a.addAction(UIAlertAction(title: "ok", style: .default))
        return a
    }

}

