//
//  RecDetailsViewController.swift
//  finalproject
//
//  Created by Тимур Бакланов on 11.12.2021.
//

import UIKit

class RecDetailsViewController: UIViewController {

    @IBOutlet weak var recImage: UIImageView!
    
    @IBOutlet weak var recTitle: UILabel!
    @IBOutlet weak var summary: UITextView!
    
    var rec: Reciepe!
    var recDet: RecDetails!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recTitle.text = rec.title
        ServiceController.shared.getRecDetails(rec: rec) { result in
            DispatchQueue.main.async {
                self.recDet = result
                self.summary.attributedText = self.recDet.summary.htmlToAttributedString
                let url = URL(string: self.recDet.image)
                let data = try? Data(contentsOf: url!)
                self.recImage.image = UIImage(data: data!)
        }
    }
    

    

}
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
