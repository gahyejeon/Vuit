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
//                                Text("로고")
                                //                                    .foregroundColor(.gray)
                                Image("Logo2")
                                    .padding(.top, 170)
                                Image("postit")
                                //                                Text("부끄러운 경험을")
                                //                                    .foregroundColor(.gray)
                                //                                    .font(.system(size: 24, weight: .medium))
                                //                                    .padding(.top)
//                                
//                                Text("공유해주세요!")
//                                    .foregroundColor(.gray)
//                                    .font(.system(size: 24, weight: .medium))
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
                PostingView(editingItem: nil)
            }
        }
    }
    
    private func itemView(_ item: Item) -> some View {
        NavigationLink {
            DetailView(item: item)
        } label: {
            ZStack(alignment: .bottomTrailing) {
                Rectangle()
                    .fill(Color.postColor)
                    .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 4, y: 4)

                Text(item.text)
                    .font(.body)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, maxHeight: .infinity,  alignment: .center)
                    .padding(.top, 10)
                    .padding(.bottom, 35)

                Text(item.timestamp, format: Date.FormatStyle(date: .abbreviated, time: .shortened))
                    .font(.body)
                    .foregroundColor(.gray)
                    .padding([.bottom, .trailing], 12)
            }.frame(height: 300)
                .padding(.horizontal)
        }
        .buttonStyle(.plain)
    }
    
//        private func itemView(_ item: Item) -> some View {
//            NavigationLink {
//                DetailView(item: item)
//            } label: {
//                ZStack(alignment: .bottomTrailing) {
//                    Rectangle()
//                        .fill(Color.postColor)
//                        .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 4, y: 4)
//    
//                    VStack {
//                        Spacer()
//                        Text(item.text)
//                            .font(.body)
//                            .foregroundColor(.black)
//                            .multilineTextAlignment(.center)
//                            .frame(maxWidth: .infinity)
//                            .padding(.bottom, 8)
//                        Spacer()
//                    }
//                    .padding()
//    
//                    Text(item.timestamp, format: Date.FormatStyle(date: .abbreviated, time: .shortened))
//                        .font(.body)
//                        .foregroundColor(.gray)
//                        .padding([.bottom, .trailing], 12)
//                }
//    
//                .frame(height: 300)
//                .padding(.horizontal)
//            }
//            .buttonStyle(.plain)
//        }
    
    
    private func addItem() {
        withAnimation {
            let newItem = Item(id: UUID(), timestamp: Date(), text: "샘플")
            modelContext.insert(newItem)
        }
    }
    
}



#Preview {
    ContentView()
        .modelContainer(for: [Item.self, Comment.self], inMemory: true)
}



// 보이는 글 정렬 정해야하고
