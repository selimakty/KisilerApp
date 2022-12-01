//
//  UpgradeViewController.swift
//  KisilerApp
//
//  Created by Selim on 19.11.2022.
//

import UIKit

class UpgradeViewController: UIViewController {

    @IBOutlet weak var isimTextField: UITextField!
    @IBOutlet weak var numaraTextField: UITextField!
    
    let context = appDelegate.persistentContainer.viewContext
    var kisi:Kisiler?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let updateKisi = kisi{
            isimTextField.text = updateKisi.kisi_ad
            numaraTextField.text = updateKisi.kisi_numara
        }
    }
    
    @IBAction func guncelleButton(_ sender: Any) {
        
        if let k = kisi,let isim = isimTextField.text, let numara = numaraTextField.text{
            
            k.kisi_ad = isim
            k.kisi_numara = numara
            
            appDelegate.saveContext()
            
            navigationController?.popViewController(animated: true)
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
