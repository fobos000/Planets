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

    let scene = SCNScene()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        cameraNode.position = SCNVector3(x: 0, y: 30, z: 0)
        
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
        
        let constraint = SCNLookAtConstraint(target: planetNode)
        cameraNode.constraints = [constraint]
        
        scene.rootNode.addChildNode(planetNode)
        
        for i in 1..<9 {
            addSphere(SCNVector3(Float(i), 0.0, 0.0))
        }
        
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
    
    func defaultSphereNode() -> SCNNode {
        return sphereNode(0.2)
    }
    
    func addNode(node: SCNNode, point: SCNVector3)  {
        scene.rootNode.addChildNode(node)
        node.position = point
    }
    
    func addSphere(point: SCNVector3) {
        let sphereNode = defaultSphereNode()
        addNode(sphereNode, point: point)
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
