//
//  ContentView.swift
//  ironGameDome
//
//  Created by גיא אינהורן on 04/07/2026.
//

import SwiftUI
import RealityKit
import ARKit

struct ContentView : View {

    var body: some View {
        RealityView { content in

            // Create a cube model
            let model = Entity()
            let mesh = MeshResource.generateBox(size: 0.1, cornerRadius: 0.005)
            let material = SimpleMaterial(color: .gray, roughness: 0.15, isMetallic: true)
            model.components.set(ModelComponent(mesh: mesh, materials: [material]))
            model.position = [0, 0.05, 0]

            // Create horizontal plane anchor for the content
            let anchor = AnchorEntity(.plane(.horizontal, classification: .any, minimumBounds: SIMD2<Float>(0.2, 0.2)))
            anchor.addChild(model)

            // Add the horizontal plane anchor to the scene
            content.add(anchor)

            content.camera = .spatialTracking
            
            // Create a toy car
            if let carEntity = try? Entity.load(named: "toy_car") {
                let anchorEntity = AnchorEntity(plane: .horizontal)
                anchor.addChild(carEntity)
            }
            else {
                print("no car loaded")
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ContentView()
}
