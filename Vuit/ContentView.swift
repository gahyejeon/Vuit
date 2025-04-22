//
//  ContentView.swift
//  Vuit
//
//  Created by 내꺼다 on 4/14/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Item.timestamp, order: .reverse) private var items: [Item]
    @State private var isPresentingPostingView = false
    
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
                                // 내용 수정해야 함
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
                
                Button(action: {
                    isPresentingPostingView = true
                }) {
                    Image("postButton")
                }
                .padding()
                
                }
            .navigationTitle("부잇")
            .navigationBarTitleDisplayMode(.inline)   // 라지타이틀 없애버리기
            .toolbarBackground(Color.backColor, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar) // 투명을 보이게 바꾸기
            // navigationDestination 위치
            .navigationDestination(isPresented: $isPresentingPostingView) {
                PostingView()
            }
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
                Text(item.text)
                    .font(.body)
                    .foregroundColor(.black)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 300)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.postColor)
                    .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 4, y: 4)
            )
            .padding(.horizontal)
        }
        .buttonStyle(.plain)
    }
    

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date(), text: "샘플")
            modelContext.insert(newItem)
        }
    }

}



#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}



// 보이는 글 정렬 정해야하고
