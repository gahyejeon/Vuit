//
//  Trash.swift
//  Vuit
//
//  Created by 내꺼다 on 4/21/25.
//


//                if items.isEmpty {
//                    VStack {
//                        Text("로고")
//                            .padding(.top, 200)
//                            .foregroundColor(.gray)
//                            .multilineTextAlignment(.center)
//                            .frame(maxWidth: .infinity, maxHeight: .infinity)
//                        Text("부끄러운 경험을 공유해주세요!")
////                            .padding(.top, 200)
//                            .foregroundColor(.gray)
//                            .multilineTextAlignment(.center)
//                            .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    }
//
//                }
//
//            }
//
//            .background(Color.backColor)
//
//
//
//            //
//            ScrollView {
//                LazyVStack(spacing: 25) {
//                    ForEach(items) { item in
//                        NavigationLink {
//                            DetailView(item: item)
//                        } label: {
//                            VStack(alignment: .leading, spacing: 8) {
//                                Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
//                                    .font(.body)
//                                    .foregroundColor(.black)
//                            }
//                            .padding()
//                            .frame(maxWidth: .infinity, minHeight: 300)
//                            .background(RoundedRectangle(cornerRadius: 20)
//                                .fill(Color.postColor)
//                            )
//                            .padding(.horizontal)
//                        }
//                        .buttonStyle(.plain)
//                    }
//                }
//                .padding(.top)
//            }
//            .background(Color.backColor)
//            .navigationTitle("부잇")
//            .navigationBarTitleDisplayMode(.inline) // 라지타이틀 없애버리기
//            .toolbarBackground(Color.backColor, for: .navigationBar)
//            .toolbarBackground(.visible, for: .navigationBar)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button(action: addItem) {
//                        Image(systemName: "plus")
//                    }
//                }
//
//            }
//
//            // ZStack 쓸지 overlay쓸지 고민
////            ZStack {
////                Button(action: addItem)
////            }
//        }
//
//
//    }
//
