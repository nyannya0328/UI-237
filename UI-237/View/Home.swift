//
//  Home.swift
//  UI-237
//
//  Created by にゃんにゃん丸 on 2021/06/14.
//

import SwiftUI
extension View{
    
    func getRect()->CGRect{
        
        return UIScreen.main.bounds
    }
}

struct Home: View {
    @State var wish = false
    @State var finish = false
    var body: some View {
        ZStack{
            
            VStack{
                
                Image("p1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: getRect().width / 1.3)
                
                Text("Happy Birthday\nBear!")
                    .font(.custom("Limelight-Regular", size: 30))
                    .foregroundColor(.blue)
                    .lineSpacing(15)
                    .multilineTextAlignment(.center)
                
                Text("Conglatulation!")
                    .font(.custom("Limelight-Regular", size: 15))
                    .foregroundColor(.red)
                    .padding(.top,10)
                
                
                Button(action: doAnimaiton, label: {
                    Text("WISH")
                         .font(.custom("Limelight-Regular", size: 15))
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .padding(.horizontal,15)
                        .background(Color.primary)
                        .cornerRadius(10)
                        .shadow(color: .white, radius: 5, x: 5, y: 5)
                       .padding(.top,10)
                })
                 .disabled(wish)
                
              
                
            }
            
            EmitterView()
                .scaleEffect(wish ? 1 : 0,anchor: .top)
                .opacity(wish && !finish ? 1 : 0)
                .offset(y: wish ? 0 : getRect().height / 2)
                .ignoresSafeArea()
                
        }
    }
    
    func doAnimaiton(){
        
        
        withAnimation(.spring()){
            
            wish = true
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            
            withAnimation(.easeInOut(duration: 1.5)){
                
                
                finish = false
                
            }
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                
                wish = false
                finish = false
                
            }
            
            
        }
        
        
        
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct EmitterView :UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIView {
        
        let view = UIView()
        view.backgroundColor = .clear
        let emitterLayer = CAEmitterLayer()
        emitterLayer.emitterShape = .line
        emitterLayer.emitterCells = cretateEmitterCells()
        emitterLayer.emitterSize = CGSize(width: getRect().width, height: 1)
        
        emitterLayer.emitterPosition = CGPoint(x: getRect().width / 2, y: 0)
        
        view.layer.addSublayer(emitterLayer)
        
        
        
        return view
        
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    func cretateEmitterCells() -> [CAEmitterCell]{
        
        var emmitercells : [CAEmitterCell] = []
        
        for index in 1...13{
            
            let cell = CAEmitterCell()
            
            
            cell.contents = UIImage(named: getImage(index: index))?.cgImage
            
            cell.color = getColor().cgColor
            
            //
            
            cell.birthRate = 5
            cell.velocity = 150
            cell.lifetime = 10
            cell.scale = 0.3
            
            cell.emissionLongitude = .pi
            cell.emissionRange = 0.3
            
            cell.spin = 5
            cell.spinRange = 10
         
            cell.yAcceleration = 30
            
            
            emmitercells.append(cell)
            
            
        }
        
        return emmitercells
        
        
        
        
        
        
    }
    
    
    func getColor ()->UIColor{
        
        let colors : [UIColor] = [
            .systemRed,.systemGreen,.systemBlue,.systemOrange
        
            
        ]
        
        return colors.randomElement()!
        
        
    }
    
    
    func getImage(index : Int)->String{
        
        
        if index < 4{
            
            
            return "circle"
        }
        
       else if index > 5 && index <= 8 {
            
            return "rectangle"
        }
        
       else{
        
        return "triangle"
       }
        
        
        
        
    }

}
