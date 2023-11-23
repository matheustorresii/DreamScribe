//
//  AddScreen.swift
//  DreamScribe
//
//  Created by Matheus Torres on 17/09/23.
//

import Combine
import SwiftUI

struct AddScreen: View, NavigableView {
    
    // MARK: - PUBLIC PROPERTIES
    
    var navigation: PassthroughSubject<FlowNavigationStyle, Never> = .init()
    
    // MARK: - PRIVATE PROPERTIES
    
    @State private var dreamType: String = DreamType.normal.rawValue
    @State private var text: String = ""
    @State private var tag: String = ""
    @State private var tagCollection: [String] = []
    @ObservedObject private var viewModel: AddViewModel = .init()
    private let placeholder: String = "Write your dream here"
    
    // MARK: - BODY
    
    var body: some View {
        ZStack {
            Color.dreamPink.ignoresSafeArea()
            buildViewForState()
        }
        .navigationTitle("New Dream")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.dreamPink, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    didTapSave()
                }
            }
        }
    }
    
    // MARK: - PRIVATE METHODS
    
    @ViewBuilder
    private func buildViewForState() -> some View {
        switch viewModel.state {
        case .idle:
            buildScrollView()
        case .loading:
            LoadingView()
        case .error:
            ErrorView()
        case .created:
            LoadingView()
                .onAppear {
                    Task { @MainActor in
                        self.navigation.send(.pop)
                    }
                }
        }
    }
    
    @ViewBuilder
    private func buildScrollView() -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                buildTextEditor()
                buildSegmentedPicker()
                Text("Insert tags:")
                    .fontWeight(.bold)
                    .foregroundColor(.dreamPurple)
                
                TextField("College, Mom, Happiness...", text: $tag, onCommit: {
                    tagCollection.append(tag)
                }).onSubmit {
                    tag = ""
                }
                buildTagsListView()
            }
        }
        .padding(.horizontal, 16)
    }
    
    private func didTapSave() {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.locale = .current
        dateFormatter.calendar = .current
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        let date = dateFormatter.string(from: .init())
        let dream = DreamModel(date: date,
                               description: text,
                               tags: tagCollection,
                               type: .init(rawValue: dreamType) ?? .normal)
        viewModel.saveDream(dream)
    }
    
    @ViewBuilder
    private func buildTextEditor() -> some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .fontWeight(.bold)
                    .foregroundColor(.dreamPurple)
                    .disabled(true)
                    .padding(.horizontal, 8)
            }
            
            TextEditor(text: $text)
                .frame(minHeight: 35, alignment: .leading)
                .foregroundColor(.dreamPurple)
                .multilineTextAlignment(.leading)
                .opacity(text.isEmpty ? 0.5 : 1)
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(8)
    }
    
    @ViewBuilder
    private func buildSegmentedPicker() -> some View {
        Picker("Dream type", selection: $dreamType) {
            ForEach(DreamType.allCases.map { $0.rawValue }, id: \.self) {
                Text($0)
            }
        }
        .colorMultiply(.dreamPink)
        .pickerStyle(.segmented)
    }
    
    @ViewBuilder
    private func buildTagsListView() -> some View {
        GeometryReader { geo in
            FlexibleView(availableWidth: geo.size.width,
                         data: tagCollection,
                         spacing: 8,
                         alignment: .leading) { item in
                Text(item)
                    .padding(8)
                    .foregroundColor(.dreamPink)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.dreamPurple))
                    .onTapGesture {
                        if let index = tagCollection.firstIndex(of: item) {
                            tagCollection.remove(at: index)
                        }
                    }
            }
        }
    }
}

