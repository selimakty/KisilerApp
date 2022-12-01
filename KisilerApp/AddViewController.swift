//
//  AddViewController.swift
//  KisilerApp
//
//  Created by Selim on 19.11.2022.
//

import UIKit

class AddViewController: UIViewController {

    
    
    @IBOutlet weak var isimTextField: UITextField!
    @IBOutlet weak var numaraTextField: UITextField!

    let context = appDelegate.persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func kisiEkleButton(_ sender: Any) {
        
        if let isim = isimTextField.text, let numara = numaraTextField.text{
            
            let kisi = Kisiler(context: context)
            
            kisi.kisi_ad = isim
            kisi.kisi_numara = numara
            
            appDelegate.saveContext()
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
