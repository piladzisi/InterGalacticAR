//
//  ViewController.swift
//  InterGalacticAR
//
//  Created by anna.sibirtseva on 22/07/2019.
//  Copyright © 2019 anna.sibirtseva. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class PlanetViewerVC: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var planetName: String!
    let baseNode = SCNNode()
    let planetNode = SCNNode()
    let textNode = SCNNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.debugOptions = [.showFeaturePoints, .showBoundingBoxes, .showCameras]
        
        addBaseNode()
        addPlanet()
        addText()
        
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(dismiss(fromGesture:)))
        sceneView.addGestureRecognizer((gesture))
      //  let scene = SCNScene(named: "art.scnassets/ship.scn")!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    func addBaseNode() {
        let baseLocation = SCNVector3(x: 0.0, y: 0.0, z: -2.0)
        baseNode.position = baseLocation
        sceneView.scene.rootNode.addChildNode(baseNode)
    }
    
    func addPlanet() {
        let planet = SCNSphere(radius: 0.3)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: planetName)
        planet.materials = [material]
        planetNode.geometry = planet
        baseNode.addChildNode(planetNode)
        
        
        let planetRotate = SCNAction.rotateBy(x: 0, y: 2 * .pi, z: 0, duration: 25)
        let repeatRotate = SCNAction.repeatForever(planetRotate)
        planetNode.runAction(repeatRotate)
    }
    
    func addText() {
        let text = SCNText(string: planetName.capitalized, extrusionDepth: 1)
        text.font = UIFont(name: "futura", size: 16)
        text.flatness = 0
        let scaleFactor = 0.1 / text.font.pointSize
        textNode.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)
        textNode.geometry = text
        let max = textNode.boundingBox.max.x
        let min = textNode.boundingBox.min.x
        let midpoint = -((max - min) / 2 + min) * Float(scaleFactor)
        textNode.position = SCNVector3(midpoint, 0.35, 0)
        baseNode.addChildNode(textNode)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    @objc func dismiss(fromGesture gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .right {
            dismiss(animated: true, completion: nil)
        }
    }
}
