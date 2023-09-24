//
//  SecondPasswordView.swift
//  autoCheck
//
//  Created by 방성환 on 2023/09/24.
//

import SwiftUI

struct SecondPasswordView: View {
    @State var secondPassword: String = ""
    @State var secondPasswordCheck: String = String(Double.random(in: 9999999999...99999999999999))
    
    var body: some View {
        
    }
}

#Preview {
    SecondPasswordView()
}
