//
//  SidebarView.swift
//  Ds Life Planner
//
//  Created by BoiseITGuru on 4/11/23.
//

import SwiftUI

struct SidebarView: View {
    @SceneStorage("selectedPage") var selectedPage: AppPages = .today
    @Namespace var animation
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "list.bullet.clipboard")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 55, height: 55)
                .padding(.bottom, 20)
            
            ForEach(AppPages.allCases, id: \.rawValue) { page in
                VStack(spacing: 8) {
                    Image(systemName: "gear")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 22, height: 22)
                        .foregroundColor(.orange)
                    
                    Text(page.rawValue)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.orange)
                }
                .foregroundColor(selectedPage == page ? Color.orange : .black)
                .padding(.vertical, 13)
                .frame(width: 65)
                .background {
                    if selectedPage == page {
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(Color.orange.opacity(0.1))
                            .matchedGeometryEffect(id: "TAB", in: animation)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        selectedPage = page
                    }
                }
            }
            
            Spacer()
            
            Button {
                
            } label: {
                VStack {
                    Image(systemName: "person")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 45, height: 45)
                        .clipShape(Circle())
                    
                    Text("Profile")
                        .font(.caption)
                        .fontWeight(.semibold)
                }
            }
            .padding(.top, 20)
        }
        .padding(.vertical, 15)
        .frame(maxHeight: .infinity, alignment: .top)
        .frame(width: 100)
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
