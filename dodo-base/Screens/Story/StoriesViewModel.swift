//
//  StoriesViewModel.swift
//  PizzaProject
//
//  Created by Andrew on 01.02.2026.
//

import Foundation

final class StoriesViewModel {
    
    let stories: [Story]
    var currentIndex: Int
    
    init(stories: [Story], selectedStory: Story) {
        self.stories = stories
        self.currentIndex = stories.firstIndex { $0.id == selectedStory.id } ?? 0
    }
    
    func nextStory() {
        currentIndex += 1
    }
    
    var isLast: Bool {
        currentIndex >= stories.count - 1
    }
}
