//
//  ContentView.swift
//  Vuit
//
//  Created by 내꺼다 on 4/14/25.
//

import SwiftUI
import SwiftData

enum HomeStatus {
    case empty
    case populated([Item])
}

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Item.timestamp, order: .reverse) private var items: [Item]
    
    var homeStatus: HomeStatus {
        if items.isEmpty {
            return .empty
        } else {
            return .populated(items)
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                Color.backColor.ignoresSafeArea()
                
                ScrollView {
                    VStack {
                        switch homeStatus {
                        case .empty:
                            VStack(spacing: 10) {
                                Text("로고")
                                    .padding(.top, 200)
                                    .foregroundColor(.gray)
                                Text("부끄러운 경험을 공유해주세요!")
                                    .foregroundColor(.gray)
                                    .padding()
                            }
                            .frame(maxWidth: .infinity, minHeight: 500)
                            
                        case .populated(let items):
                            LazyVStack(spacing: 20) {
                                ForEach(items) { item in
                                    itemView(item)
                                }
                                .padding(.top, 20)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                
                Button(action: addItem) {
                    Image("postButton")
                }
                .padding()
            }
            .navigationTitle("부잇")
            .navigationBarTitleDisplayMode(.inline)   // 라지타이틀 없애버리기
            .toolbarBackground(Color.backColor, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar) // 투명을 보이게 바꾸기
        }
    }
                

    
    private func itemView(_ item: Item) -> some View {
        NavigationLink {
            DetailView(item: item)
        } label: {
            VStack(alignment: .leading, spacing: 8) {
                Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    .font(.body)
                    .foregroundColor(.black)
            }
            .padding()
            .frame(maxWidth: .infinity, minHeight: 300)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.postColor)
            )
            .padding(.horizontal)
        }
        .buttonStyle(.plain)
    }
    

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

}



#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
