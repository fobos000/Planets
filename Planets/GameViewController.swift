//
//  GameViewController.swift
//  Planets
//
//  Created by O.Ohorbach on 6/30/16.
//  Copyright (c) 2016 O.Ohorbach. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = SCNScene()
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        cameraNode.position = SCNVector3(x: 0, y: 15, z: 0)
        
        // Create Omni Light
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLightTypeOmni
        lightNode.light!.color = UIColor.yellowColor()
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(lightNode)
        
        // Create Ambient Light
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = SCNLightTypeAmbient
        ambientLightNode.light!.color = UIColor.purpleColor()
        scene.rootNode.addChildNode(ambientLightNode)
        
        let planetNode = sphereNode(1.0)
        
        let satellite = sphereNode(0.5)
        let satelliteMaterial = satellite.geometry!.firstMaterial!
        satelliteMaterial.diffuse.contents = UIColor.whiteColor()
        satelliteMaterial.emission.contents = UIColor.redColor()
        satellite.position = SCNVector3(2.0, 0.0, 0.0)
        
        let constraint = SCNLookAtConstraint(target: planetNode)
        cameraNode.constraints = [constraint]
        
        scene.rootNode.addChildNode(planetNode)
        planetNode.addChildNode(satellite)
        
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // set the scene to the view
        scnView.scene = scene
    }
    
    func sphereNode(radius: CGFloat) -> SCNNode {
        let geometry = SCNSphere(radius: radius)
        let node = SCNNode(geometry: geometry)
        return node
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}
