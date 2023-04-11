//
//  Home.swift
//  ResponsiveUI
//
//  Created by BoiseITGuru on 3/29/23.
//

import SwiftUI
import Charts

struct Home: View {
    var props: Properties
    // MARK: View Properties
    @State var showSideBar: Bool = false
    
    var body: some View {
        HStack(spacing: 0) {
            // MARK: Showing Only For IPad
            if props.isiPad {
                ViewThatFits {
                    SidebarView()
                    ScrollView(.vertical, showsIndicators: false) {
                        SidebarView()
                    }
                }
            }
            
            ScrollView(.vertical, showsIndicators:  false) {
                VStack {
                    HeaderView()
                    InfoCards()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            DailySalesView()
                            PieChartView()
                        }
                        .padding(.horizontal, 15)
                    }
                    .padding(.horizontal, -15)
                    
                    TrendingItemsView()
                }
                .padding(15)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .background {
            Color.black
                .opacity(0.04)
                .ignoresSafeArea()
        }
        .offset(x: showSideBar ? 100 : 0)
        .overlay(alignment: .leading) {
            // MARK: Side Bar For Non iPad Devices
            ViewThatFits {
                SidebarView()
                ScrollView(.vertical, showsIndicators: false) {
                    SidebarView()
                }
            }
            .offset(x: showSideBar ? 0 : -100)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background {
                Color.black
                    .opacity(showSideBar ? 0.75 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            showSideBar.toggle()
                        }
                    }
            }
        }
    }
    
    // MARK: Trending Items View
    @ViewBuilder
    func TrendingItemsView()->some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Trending Dishes")
                .font(.title3.bold())
                .padding(.bottom)
            
            let isAdoptable = props.isiPad && !props.isMaxSplit
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: isAdoptable ? 2 : 1), spacing: isAdoptable ? 20 : 15) {
                ForEach(trendingDishes) { item in
                    HStack(spacing: 15) {
                        Image(systemName: "fork.knife.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 35, height: 35)
                            .padding(10)
                            .background {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(Color.orange.opacity(0.1))
                            }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(item.title)
                                .fontWeight(.bold)
                                .lineLimit(1)
                            
                            Label {
                                Text(item.title)
                                    .foregroundColor(Color.orange)
                            } icon: {
                                Text("\(item.subTitle):")
                            }
                            .font(.callout)
                            .fontWeight(.semibold)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay(alignment: .topTrailing, content: {
            Button("View All") {}
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(Color.orange)
                .offset(y: 6)
        })
        .padding(15)
        .background {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(.gray.opacity(0.5))
        }
    }
    
    // MARK: PieChart View
    @ViewBuilder
    func PieChartView()->some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Total Income")
                .font(.title2.bold())
            
            ZStack {
                Circle()
                    .trim(from: 0.5, to: 1)
                    .stroke(.red, style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                
                Circle()
                    .trim(from: 0.2, to: 0.5)
                    .stroke(.yellow, style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                
                Circle()
                    .trim(from: 0, to: 0.2)
                    .stroke(.green, style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                
                Text("$200k")
                    .font(.title)
                    .fontWeight(.heavy)
            }
            .padding(8)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            HStack(spacing: 15) {
                Label {
                    Text("Food")
                        .font(.caption)
                } icon: {
                    Image(systemName: "circle.fill")
                        .font(.caption2)
                        .foregroundStyle(.green)
                }
                
                Label {
                    Text("Drink")
                        .font(.caption)
                } icon: {
                    Image(systemName: "circle.fill")
                        .font(.caption2)
                }
                
                Label {
                    Text("Other")
                        .font(.caption)
                } icon: {
                    Image(systemName: "circle.fill")
                        .font(.caption2)
                        .foregroundStyle(.yellow)
                }
            }
        }
        .padding(15)
        .frame(width: 250, height: 250)
        .background {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(.gray.opacity(0.5))
        }
    }
    
    // MARK: Graph View
    @ViewBuilder
    func DailySalesView()->some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Daily Sales")
                .font(.title3.bold())
            
            Chart {
                ForEach(dailySales) { sale in
                    // MARK: Area Mark For Gradient BG
                    AreaMark(x: .value("Time", sale.time), y: .value("Sale", sale.sales))
                        .foregroundStyle(.linearGradient(colors: [
                            Color.orange.opacity(0.6),
                            Color.orange.opacity(0.5),
                            Color.orange.opacity(0.3),
                            Color.orange.opacity(0.1),
                            .clear
                        ], startPoint: .top, endPoint: .bottom))
                        .interpolationMethod(.catmullRom)
                    
                    // MARK: Line Mark
                    LineMark(x: .value("Time", sale.time), y: .value("Sale", sale.sales))
                        .foregroundStyle(Color.orange)
                        .interpolationMethod(.catmullRom)
                    
                    // MARK: Point Mark For Showing Points
                    PointMark(x: .value("Time", sale.time), y: .value("Sale", sale.sales))
                        .foregroundStyle(Color.orange)
                }
            }
            .frame(height: 180)
        }
        .padding(15)
        .background {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(.gray.opacity(0.5))
        }
        .frame(minWidth: props.isiPad ? props.size.width - 400 : props.size.width - 30)
    }
    
    // MARK: Info Cards View
    @ViewBuilder
    func InfoCards()->some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 18) {
                ForEach(infos) { info in
                    VStack(alignment: .leading, spacing: 18) {
                        HStack(spacing: 15) {
                            Text(info.title)
                                .font(.title3.bold())
                            
                            Spacer()
                            
                            HStack(spacing: 8) {
                                Image(systemName: info.loss ? "arrow.down" : "arrow.up")
                                Text("\(info.percentage)%")
                            }
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(info.loss ? .red : .green)
                        }
                        
                        HStack(spacing: 15) {
                            Image(systemName: info.icon)
                                .font(.title3)
                                .foregroundColor(.white)
                                .frame(width: 45, height: 45)
                                .background {
                                    Circle()
                                        .fill(info.iconColor)
                                }
                            
                            Text(info.amount)
                                .font(.title.bold())
                        }
                    }
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(.gray.opacity(0.5))
                    }
                }
            }
        }
    }
    
    // MARK: Header View
    func HeaderView()->some View {
        // MARK: Dynmaic Layout (iOS 16+)
        let layout = props.isiPad && !props.isMaxSplit ? AnyLayout(HStackLayout()) : AnyLayout(VStackLayout(spacing: 22))
        
        return layout {
//            VStack(alignment: .leading, spacing: 8) {
//                Text("Seattle, New York")
//                    .font(.title2)
//                    .fontWeight(.bold)
//
//                Text(Date().formatted(date: .abbreviated, time: .omitted))
//                    .font(.caption)
//            }
//            .frame(maxWidth: .infinity, alignment: .leading)
            
            // MARK: Search Bar With Menu Button
            HStack(spacing: 10) {
                if !(props.isiPad && !props.isMaxSplit) {
                    Button {
                        withAnimation(.easeInOut) {
                            showSideBar.toggle()
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.title2)
                    }
                }
                
                TextField("Search", text: .constant(""))
                
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 22, height: 22)
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background {
                Capsule()
                    .fill(.gray.opacity(0.5))
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
