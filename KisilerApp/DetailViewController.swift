//
//  DetailViewController.swift
//  KisilerApp
//
//  Created by Selim on 19.11.2022.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var isimLabel: UILabel!
    @IBOutlet weak var numaraLabel: UILabel!
    
    let context = appDelegate.persistentContainer.viewContext
    var kisi : Kisiler?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let kisiDetail = kisi{
            isimLabel.text = kisiDetail.kisi_ad
            numaraLabel.text = kisiDetail.kisi_numara
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
