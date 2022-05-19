//
//  ImageDetectionHelper.swift
//  Listrikku
//
//  Created by Ardian Pramudya Alphita on 09/05/22.
//

import CoreML
import Vision
import CoreImage
import UIKit

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
    
    static func detectText(image: CIImage, completion: @escaping (_ result: Int) -> Void) {
        var result = [Int]()
        
        let handler = VNImageRequestHandler(ciImage: image, options: [:])
        let request = VNRecognizeTextRequest { request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation], error == nil else { return }
            
            let text = observations.compactMap { value in
                value.topCandidates(1).first?.string
            }
            
            for (index, value) in text.enumerated() {
                if isItWatt(word: value) {                    
                    // Get number from string. eg: 200W -> 200
                    let string = text[index]
                    if let number = Int(string.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
                        // Do something with this number
                        result.append(number)
                    }
                }
            }
        }
        
        do {
            try handler.perform([request])
            completion(result.first ?? 0)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func isItWatt(word: String) -> Bool {
        if let i = word.firstIndex(of: "W") {
            let index: Int = word.distance(from: word.startIndex, to: i)
            if (index == word.count - 1){
                return true
            }
        }
        return false
    }
}
