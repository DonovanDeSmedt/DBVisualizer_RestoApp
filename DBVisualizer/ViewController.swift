//
//  ViewController.swift
//  DBVisualizer
//
//  Created by Donovan De Smedt on 26/11/16.
//  Copyright © 2016 Donovan De Smedt. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate,UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var txfCampus: UITextField!
    @IBOutlet weak var txfResto: UITextField!
    
    @IBOutlet weak var txfBezetting: UITextField!
    @IBOutlet weak var txfBeschikbaarheid: UITextField!
    
    @IBOutlet weak var sliderBeschikbaarheid: UISlider!
    @IBOutlet weak var sliderBezetting: UISlider!
    
    let restoPickerView = UIPickerView()
    let campusPickerView = UIPickerView()
    
    var dbRef :FIRDatabaseReference!
    var restaurants = [Restaurant]()
    var currentRestaurant :Restaurant = Restaurant()
    
    private let repo = CampusRepository()
    
    private var restos :[CampusRepository.Resto] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        
        dbRef = FIRDatabase.database().reference().child("restaurants")
        
        campusPickerView.delegate = self
        restoPickerView.delegate = self
        
        txfCampus.inputView = campusPickerView
        txfResto.inputView = restoPickerView
        
        startObservingDB()
        
    }
    
    
    func startObservingDB() {
        
        dbRef.observeSingleEvent(of: .value, with: { (snapshot: FIRDataSnapshot) in
            var newRestos = [Restaurant]()
            
            for resto in snapshot.children {
                let restoObject = Restaurant(snapshot: resto as! FIRDataSnapshot)
                newRestos.append(restoObject)
            }
            self.restaurants = newRestos
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == campusPickerView {
            return repo.campussen.count
        }
        
        if pickerView == restoPickerView {
            restos = repo.getRestos(of: txfCampus.text!)
            return repo.getRestos(of: txfCampus.text!).count
        }
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == campusPickerView {
            return repo.campussen[row]
        }
        
        if pickerView == restoPickerView {
            return repo.getRestos(of: txfCampus.text!).map {$0.naam}[row]//repo.restos.map {$0.naam}[row]
        }
        
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == campusPickerView{
            txfCampus.text = repo.campussen[row]
        }
        
        if pickerView ==  restoPickerView{
            txfResto.text = repo.getRestos(of: txfCampus.text!).map {$0.naam}[row]
            getData(of: restos[restoPickerView.selectedRow(inComponent: 0)])
        }
        
    }
    
    
    
    func getData(of resto: CampusRepository.Resto){
        let id = resto.id
        currentRestaurant = restaurants.filter {$0.key == id}.first!
        sliderBezetting.value = Float((currentRestaurant.bezetting)!) / 100.0
        sliderBeschikbaarheid.value = Float((currentRestaurant.beschikbaarheid)!) / 100.0
        
        
        txfBezetting.text = "\(currentRestaurant.bezetting!)"
        txfBeschikbaarheid.text = "\(currentRestaurant.beschikbaarheid!)"
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickRandom(_ sender: UIButton) {
    }
    @IBAction func onChangeBezetting(_ sender: UISlider){
        txfBezetting.text = "\(Int(sender.value * 100))"
        dbRef.child(currentRestaurant.key).child("bezetting").setValue(Int(sender.value * 100))
    }
    @IBAction func onChangeBeschikbaarheid(_ sender: UISlider){
        txfBeschikbaarheid.text = "\(Int(sender.value * 100))"
        dbRef.child(currentRestaurant.key).child("beschikbaarheid").setValue(Int(sender.value * 100))
    }
    
    
}
extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UITableViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard()
    {
        view.endEditing(true)
    }
}

