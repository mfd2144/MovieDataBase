//
//  CollectionReusableView.swift
//  MobilliumMovies
//
//  Created by Mehmet fatih DOĞAN on 17.04.2022.
//

import UIKit
import Combine

class PageControllerFooter: UICollectionReusableView {
    static let reuseIdentifier = "PageControllerFooter"
    private lazy var pageControl: UIPageControl = {
            let control = UIPageControl()
            control.translatesAutoresizingMaskIntoConstraints = false
            control.isUserInteractionEnabled = false
            control.currentPageIndicatorTintColor = .white
            control.pageIndicatorTintColor = .darkGray.withAlphaComponent(0.4)
            return control
        }()
    
        private var pagingInfoToken: AnyCancellable?
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupView()
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupView()
        }

        func configure(with numberOfPages: Int) {
            pageControl.numberOfPages = numberOfPages
        }

        func subscribeTo(subject: PassthroughSubject<PagingInfo, Never>) {
            pagingInfoToken = subject
                .receive(on: DispatchQueue.main)
                .sink { [weak self] pagingInfo in
                    self?.pageControl.numberOfPages = pagingInfo.totalPage
                    self?.pageControl.currentPage = pagingInfo.currentPage
                }
        }

        private func setupView() {
            backgroundColor = .clear
            pageControl.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
            addSubview(pageControl)
            NSLayoutConstraint.activate([
                pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
                pageControl.topAnchor.constraint(equalTo: topAnchor)
            ])
        }

        override func prepareForReuse() {
            super.prepareForReuse()
            pagingInfoToken?.cancel()
            pagingInfoToken = nil
        }
}
