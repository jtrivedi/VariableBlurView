//
//  ContentView.swift
//  VariableBlurView
//
//  Created by Janum Trivedi on 5/29/23.
//

import SwiftUI
import UIKit

class VariableBlurUIView: UIVisualEffectView {

    init(gradientMask: UIImage, maxBlurRadius: CGFloat = 20) {
        super.init(effect: UIBlurEffect(style: .regular))

        // `CAFilter` is a private QuartzCore class that we dynamically declare in `CAFilter.h`.
        let variableBlur = CAFilter.filter(withType: "variableBlur") as! NSObject

        // The blur radius at each pixel depends on the alpha value of the corresponding pixel in the gradient mask.
        // An alpha of 1 results in the max blur radius, while an alpha of 0 is completely unblurred.
        guard let gradientImageRef = gradientMask.cgImage else {
            fatalError("Could not decode gradient image")
        }

        variableBlur.setValue(maxBlurRadius, forKey: "inputRadius")
        variableBlur.setValue(gradientImageRef, forKey: "inputMaskImage")
        variableBlur.setValue(true, forKey: "inputNormalizeEdges")

        // Get rid of the visual effect view's dimming/tint view, so we don't see a hard line.
        let tintOverlayView = subviews[1]
        tintOverlayView.alpha = 0

        // We use a `UIVisualEffectView` here purely to get access to its `CABackdropLayer`,
        // which is able to apply various, real-time CAFilters onto the views underneath.
        let backdropLayer = subviews.first?.layer

        // Replace the standard filters (i.e. `gaussianBlur`, `colorSaturate`, etc.) with only the variableBlur.
        backdropLayer?.filters = [variableBlur]
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct VariableBlurView: UIViewRepresentable {
    typealias UIViewType = VariableBlurUIView

    func makeUIView(context: Context) -> VariableBlurUIView {
        VariableBlurUIView(gradientMask: UIImage(named: "alpha-gradient")!)
    }

    func updateUIView(_ uiView: VariableBlurUIView, context: Context) {
        // No-op
    }
}

struct ContentView: View {
    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                VStack {
                    Image("camping")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
                        .padding()
                }
                .padding(.top, 50)
            }

            VStack {
                VariableBlurView()
                    .frame(height: 120)
                    .allowsHitTesting(false)

                Spacer()
            }
        }
        .ignoresSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
