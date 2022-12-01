//
//  ViewController.swift
//  KisilerApp
//
//  Created by Selim on 19.11.2022.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var kisilerTableView: UITableView!
    
    let context = appDelegate.persistentContainer.viewContext
    var kisiListe : [Kisiler] = [Kisiler]()
    
    var aramaYapildiMi = false
    var arananText:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        kisilerTableView.delegate = self
        kisilerTableView.dataSource = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if aramaYapildiMi {
            getKisi(searchText: arananText!)
        }
        else{
            getKisiler()
        }
        kisilerTableView.reloadData()
    }
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = sender as? Int
        
        if segue.identifier == "DetaySegue" {
            let gidilecekVc = segue.destination as? DetailViewController
            gidilecekVc?.kisi = kisiListe[index!]
        }
        
        if segue.identifier == "GuncelleSegue" {
            let gidilecekVc = segue.destination as?UpgradeViewController
            gidilecekVc?.kisi = kisiListe[index!]
        }
        
    }

    func getKisiler(){
        // veri okuma isteği oluşturuyoruz
        let fetchRequest:NSFetchRequest<Kisiler> = Kisiler.fetchRequest()
        
        // sıralama kolonunu ve türünü belirttiyoruz
        //let sort = NSSortDescriptor(key: #keyPath(Kisiler.kisi_numara), ascending: true)
        
        // filtre sorgusu oluşturuyoruz -- %i integer değişkeni anlamına gelir string için %@ kullanılır
        //fetchRequest.predicate = NSPredicate(format: "kisi_yas == %i", 22)
        
        // sıralama ayarını fetch içine atıyoruz
        //fetchRequest.sortDescriptors = [sort]
        
        
        do{
            // diziye fetch isteğini yolladığımız verileri yazdıyoruz
            kisiListe = try context.fetch(fetchRequest)
        }
        catch{
            print("hata oluştu")
        }
        
        // ekrana yazdırıyoruz
        for kisiler in kisiListe {
            print("\(kisiler.kisi_ad!) : \(kisiler.kisi_numara!)")
        }
    }
    
    func getKisi(searchText:String){
        let fetchRequest:NSFetchRequest<Kisiler> = Kisiler.fetchRequest()
        
        let predicate1:NSPredicate = NSPredicate(format: "kisi_ad CONTAINS[c] %@",searchText)
        let predicate2:NSPredicate = NSPredicate(format: "kisi_numara CONTAINS %@",searchText)
        let predicate:NSPredicate  = NSCompoundPredicate(orPredicateWithSubpredicates: [predicate1,predicate2] )
        
        fetchRequest.predicate = predicate
            
        do{
            kisiListe = try context.fetch(fetchRequest)
        }
        catch{
                print("hata meydana geldi")
        }
    }
    
    func setKisiler(ad:String,numara:String){
        let kisi = Kisiler(context: context)
        
        kisi.kisi_ad = ad
        kisi.kisi_numara = numara
        
        appDelegate.saveContext()
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kisiListe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let kisi = kisiListe[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "KisilerCell",for: indexPath) as! KisilerTableViewCell
        
        cell.KisilerLabel.text = kisi.kisi_ad! + " - " + kisi.kisi_numara!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "DetaySegue", sender: indexPath.row)
    }
    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//
//        let DeleteAction = UITableViewRowAction(style: .default, title: "Sil", handler: {
//
//            (action:UITableViewRowAction,indexPath:IndexPath)-> Void in
//
//            // sil action
//        })
//
//        let UpdateAction = UITableViewRowAction(style: .normal, title: "Güncelle", handler: {
//
//            (action:UITableViewRowAction,indexPath:IndexPath)-> Void in
//
//            // update action
//            self.performSegue(withIdentifier: "GuncelleSegue", sender: indexPath.row)
//        })
//
//        return [DeleteAction,UpdateAction]
//    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Sil") { _, _, completionHandler in
            
            let kisi = self.kisiListe[indexPath.row]
            self.context.delete(kisi)
            appDelegate.saveContext()
            
            if self.aramaYapildiMi {
                self.getKisi(searchText: self.arananText!)
            }
            else{
                self.getKisiler()
            }
            self.kisilerTableView.reloadData()
            
            completionHandler(true)
         }
        
        let upgradeAction = UIContextualAction(style: .normal, title: "Güncelle") { _, _, completionHandler in
            self.performSegue(withIdentifier: "GuncelleSegue", sender: indexPath.row)
            completionHandler(true)
         }
        
        
         let configuration = UISwipeActionsConfiguration(actions: [deleteAction,upgradeAction])
         configuration.performsFirstActionWithFullSwipe = false
         return configuration
    }
}

extension ViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        arananText = searchText
        
        if searchText != ""{
            getKisi(searchText: searchText)
            aramaYapildiMi = true;
        }
        else
        {
            getKisiler()
            aramaYapildiMi = false
        }
        
        kisilerTableView.reloadData()
    }
}
