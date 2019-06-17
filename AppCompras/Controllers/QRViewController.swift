//
//  QRViewController.swift
//  AppCompras
//
//  Created by Jhonny Rivera on 6/5/19.
//  Copyright © 2019 Tecsup. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox
import Alamofire

class QRViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    
    var productosModel: [ProductoModel] = []
    
    var mainViewController: UITabBarController!
    
    @IBOutlet weak var camaraQrView: UIView!
    
    var captureDevice:AVCaptureDevice?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var captureSession:AVCaptureSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        guardarProductoCarrito(codigoQR: "123456789")
        guardarProductoCarrito(codigoQR: "123789456")
        
//        self.navigationController?.pushViewController(vc, animated: true)
        
//        self.navigationController?.popViewController(animated: true)
        
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.title = "Scanner"
        view.backgroundColor = .white
        
        captureDevice = AVCaptureDevice.default(for: .video)
        // Check if captureDevice returns a value and unwrap it
        if let captureDevice = captureDevice {
            
            do {
                let input = try AVCaptureDeviceInput(device: captureDevice)
                
                captureSession = AVCaptureSession()
                guard let captureSession = captureSession else { return }
                captureSession.addInput(input)
                
                let captureMetadataOutput = AVCaptureMetadataOutput()
                captureSession.addOutput(captureMetadataOutput)
                
                captureMetadataOutput.setMetadataObjectsDelegate(self, queue: .main)
                captureMetadataOutput.metadataObjectTypes = [.code128, .qr, .ean13,  .ean8, .code39] //AVMetadataObject.ObjectType
                
                captureSession.startRunning()
                
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                videoPreviewLayer?.videoGravity = .resizeAspectFill
                videoPreviewLayer?.frame = view.layer.bounds
                view.layer.addSublayer(videoPreviewLayer!)
                
            } catch {
                print("Error Device Input")
            }
            
        }
        
//        view.addSubview(codeLabel)
//        codeLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        codeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        codeLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        codeLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        print("en el aparecer")
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("en el desaparecer")
//        let carritoTab = self.storyboard?.instantiateViewController(withIdentifier: "TabBar") as! TabBarViewController
//
//        self.navigationController?.popToViewController(carritoTab, animated: true)
        let main = self.storyboard?.instantiateViewController(withIdentifier: "Principal") as! UITabBarController
        
        if isMovingFromParentViewController{
            print("hacia el padre")
            main.selectedIndex = 1
        }
        
        
        print(main.selectedIndex = 1)
    }
    
    let codeLabel:UILabel = {
        let codeLabel = UILabel()
        codeLabel.backgroundColor = .white
        codeLabel.translatesAutoresizingMaskIntoConstraints = false
        return codeLabel
    }()
    
    let codeFrame:UIView = {
        let codeFrame = UIView()
        codeFrame.layer.borderColor = UIColor.green.cgColor
        codeFrame.layer.borderWidth = 2
        codeFrame.frame = CGRect.zero
        codeFrame.translatesAutoresizingMaskIntoConstraints = false
        return codeFrame
    }()
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count == 0 {
            //print("No Input Detected")
            codeFrame.frame = CGRect.zero
            codeLabel.text = "No Data"
            return
        }
        
        let metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        guard let stringCodeValue = metadataObject.stringValue else { return }
        
        view.addSubview(codeFrame)
        
        guard let barcodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObject) else { return }
        codeFrame.frame = barcodeObject.bounds
        codeLabel.text = stringCodeValue
        
        // Play system sound with custom mp3 file
        if let customSoundUrl = Bundle.main.url(forResource: "beep-07", withExtension: "mp3") {
            var customSoundId: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(customSoundUrl as CFURL, &customSoundId)
            //let systemSoundId: SystemSoundID = 1016  // to play apple's built in sound, no need for upper 3 lines
            
            AudioServicesAddSystemSoundCompletion(customSoundId, nil, nil, { (customSoundId, _) -> Void in
                AudioServicesDisposeSystemSoundID(customSoundId)
            }, nil)
            
            AudioServicesPlaySystemSound(customSoundId)
        }
        
        
        
        // Call the function which performs navigation and pass the code string value we just detected
        
        print("El valor es \(stringCodeValue.count)")
//        displayDetailsViewController(scannedCode: stringCodeValue)
        
        if stringCodeValue.count > 0{
            guardarProductoCarrito(codigoQR: stringCodeValue)
        }
        
        
    }
    
    func guardarProductoCarrito(codigoQR:String){
        print("En el if")
        
        let url = "\(Constant.API_BASE_URL)/producto/codigo"
        let params: Parameters = ["codigo": codigoQR]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default).responseArray{(response: DataResponse<[ProductoModel]>) in
            
                if response.response?.statusCode == 200 {
                
                self.productosModel = response.result.value!
                
                
                for pro in self.productosModel{
                    
                    print("en el for \(pro.codigo!)")
                    
                    let delegate = (UIApplication.shared.delegate as!   AppDelegate)
                    
                    let context = delegate.persistentContainer.viewContext
                    let productos = Producto(context: context)
                    
                    productos.categoria_id = pro.categoria_id as! Int16
                    productos.codigo = pro.codigo
                    productos.precio = pro.precio
                    productos.nombre_producto = pro.nombre_producto
                    productos.imagen = pro.imagen
                    productos.descripcion = pro.descripcion
                    productos.id_producto = pro.id_producto as! Int16
                    delegate.saveContext()
                    
                    // Stop capturing and hence stop executing metadataOutput function over and over again
                    
                }
                
                }else{
                    print("Error \(String(describing: response.response?.statusCode))")
            }
            
            
        }
        
        self.captureSession?.stopRunning()
        self.navigationController?.popViewController(animated: true)
    }
    
        
    
        
        
        
        
    
    

}
