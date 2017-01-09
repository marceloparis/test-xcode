//
//  ViewController.swift
//  GuestTheNumber
//
//  Created by mac holon on 3/1/17.
//  Copyright © 2017 mac holon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var rangoLbl : UILabel!

    @IBOutlet weak var numeroTxtField : UITextField!

    @IBOutlet weak var mensajeLbl : UILabel!

    @IBOutlet weak var cantIntentosLbl : UILabel!
    
    fileprivate var limiteInferior = 0
    fileprivate var limiteSuperior = 100
    fileprivate var cantidadIntentos = 0
    fileprivate var numeroSecreto = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numeroTxtField.becomeFirstResponder()
        reset()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onOkPresionado( _ sender:AnyObject) {
        let number = Int(numeroTxtField.text!)
        if let number = number {
            numeroSeleccionado(number)
        } else {
            let alert = UIAlertController(title: nil, message: "Ingrese un Número", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
   }

}

private extension ViewController {
    
    enum Comparador {
        case menor
        case mayor
        case igual
    }
    
    func numeroSeleccionado( _ numero : Int ){
        switch compararNumero(numero , otroNumero: numeroSecreto) {
        case .menor :
            limiteInferior = max(limiteInferior,numero)
            mensajeLbl.text="El número ingresado fué Menor"
            numeroTxtField.text=""
            cantidadIntentos+=1
            mostrarRango()
            mostrarIntentos()
           
        case .mayor :
            limiteSuperior = min(limiteSuperior,numero)
            mensajeLbl.text="El número ingresado fué Mayor"
            numeroTxtField.text=""
            cantidadIntentos+=1
            mostrarRango()
            mostrarIntentos()

        case .igual:
            
            let alert = UIAlertController( title: nil ,
                                           message: "Has ganado en \(cantidadIntentos) intentos!" ,
                                           preferredStyle: UIAlertControllerStyle.alert )
            
            alert.addAction(
                UIAlertAction(title: "OK" ,
                style: UIAlertActionStyle.default,
                handler: { cmd in
                    self.reset()
                    self.numeroTxtField.text=""
                })
            )
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    func compararNumero( _ numero: Int , otroNumero: Int ) -> Comparador {
        if numero==otroNumero {
            return .igual }
        else if numero<otroNumero {
            return .menor
        }
        return .mayor
    }
}

private extension ViewController {
    func generarNumeroSecreto() {
        let diff = limiteSuperior - limiteInferior
        let randomNumber = Int(arc4random_uniform(UInt32(diff)))
        numeroSecreto = randomNumber + Int(limiteInferior)
    }
    func resetData() {
        limiteInferior = 0
        limiteSuperior = 100
        cantidadIntentos = 0
    }
    func resetMsg() {
        mensajeLbl.text = ""
    }
    func reset(){
        resetData()
        mostrarRango()
        mostrarIntentos()
        generarNumeroSecreto()
        resetMsg()
    }
    func mostrarRango(){
        rangoLbl.text="\(limiteInferior) y \(limiteSuperior)"
    }
    func mostrarIntentos(){
        cantIntentosLbl.text="Cantidad de Intentos: \(cantidadIntentos)"
    }
    
}
