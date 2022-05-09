//
//  ImageDetectionHelper.swift
//  Listrikku
//
//  Created by Ardian Pramudya Alphita on 09/05/22.
//

import CoreML
import Vision
import CoreImage

class ImageDetectionHelper {
    static func detectImage(image: CIImage, completion: @escaping (_ results: VNClassificationObservation) -> Void) {
        let defaultConfig = MLModelConfiguration()
        
        let imageClassifierWrapper = try? ElectronicImageClassifier_2(configuration: defaultConfig)
        guard let imageClassifier = imageClassifierWrapper else {
            fatalError("App failed to create an image classifier model instance.")
        }
        
        let imageClassifierModel = imageClassifier.model
        guard let imageClassifierVisionModel = try? VNCoreMLModel(for: imageClassifierModel) else {
            fatalError("App failed to create a `VNCoreMLModel` instance.")
        }
        
        let request = VNCoreMLRequest(model: imageClassifierVisionModel) { request, error in
            guard let results = request.results as? [VNClassificationObservation], let topResult = results.first else {
                fatalError("Unexpected result type from VNCoreMLRequest")
            }
            
            DispatchQueue.main.async { completion(topResult) }
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                try handler.perform([request])
            } catch {
                print(error)
            }
        }
    }
}
