//
//  Player.swift
//  AAAHSTEROIS
//
//  Created by Gabrielle Brandenburg dos Anjos on 19/11/16.
//  Copyright © 2016 Wellington Bezerra. All rights reserved.
//

import SpriteKit

class Player {
    
    var coordinate: CGPoint!
    var laser: SKSpriteNode!
    var energy: Int!
    var speed: CGFloat!
    var overlay: GameScene!
    
    let category: Int = 1
    let color: String!
    let name: String!
    let number: Int!
    
    let shakeLabel = SKLabelNode(text: "SHAKE")

    init(coordinate: CGPoint, color: String, name: String, number: Int){
            
        self.energy = 8
        self.speed = CGFloat(70.0)
        self.coordinate = coordinate
        self.color = color
        self.name = name
        self.number = number
        
        setShakeLabel()
        
        self.laser = setupLaser(color: color)
        
    }
    
    func setupLaser(color: String) -> SKSpriteNode{
        let laser = SKSpriteNode(texture: SKTexture(imageNamed:"mira\(color)8"))
        laser.position = self.coordinate
        laser.physicsBody = SKPhysicsBody(circleOfRadius: laser.size.width/2)
        laser.physicsBody?.affectedByGravity = false
        laser.physicsBody?.isDynamic = true
        laser.physicsBody?.velocity = CGVector.zero
        
        laser.addChild(shakeLabel)
        
        //TODO: tirar aquele pulinho escroto que acontece quando encosta na borda
        // (linearDamping = 0 nao resolve)
        
        return laser
    }
    
    func setShakeLabel(){
        
        shakeLabel.fontColor = UIColor.white
        shakeLabel.fontSize = 62.0
        shakeLabel.fontName = ".SFUIDisplay-Bold"
        shakeLabel.horizontalAlignmentMode = .center
        shakeLabel.verticalAlignmentMode = .center
        
        shakeLabel.isHidden = true
    }
    
    func shoot() {
        
        if energy > 0 {
        energy = energy - 1;
        print("\n energy: \(energy)")
        
        
            
        let texture = "mira\(color!)\(energy!)"
        print("\n texture path: \(texture)")
        
        self.laser.texture = SKTexture(imageNamed: texture)
            
        // Som do tiro do laser
        //self.overlay.runAction(action: self.overlay.laserFireSound)
        /*
        DispatchQueue.main.async {
                self.overlay.runAction(action: self.overlay.laserFireSound)
            }
        */
            
        }
        
        if energy == 0{
            
            shakeLabel.isHidden = false
        } else {
            shakeLabel.isHidden = true
        }
 
    }
    
    func recharge() {
        
        energy = energy + 8
        if energy > 8 { energy = 8 }
        
        let texture = "mira\(color!)\(energy!)"
        
        self.laser.texture = SKTexture(imageNamed: texture)
        
        shakeLabel.isHidden = true

        // Som da recarga - NÃO USAR!!! - TA DANDO PROBLEMA
        //self.overlay.runAction(action: self.overlay.laserRechargeSound)
        /*
        DispatchQueue.main.async {
            self.overlay.runAction(action: self.overlay.laserRechargeSound)
        }
 */
    }
    
}

//a movimentação do jogador de iphone será diferente da movimento feito com o remote
class IphonePlayer: Player {
    
    func move(direction: CGVector) {
        self.laser.physicsBody?.velocity = direction
    }

}


