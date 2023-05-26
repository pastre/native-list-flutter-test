//
//  ViewController.swift
//  DeleteMe
//
//  Created by Bruno Pastre on 26/05/23.
//

import UIKit

import Flutter

class ViewController: UITableViewController {
    let engine: FlutterEngine
    
    init(engine: FlutterEngine) {
        self.engine = engine
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FlutterCell.self, forCellReuseIdentifier: .identifier)
        tableView.backgroundColor = .blue
        print("---- LOADED")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    private var viewControllers: [FlutterViewController] = []
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .identifier) as! FlutterCell
        
        let controller = FlutterViewController(engine: engine, nibName: nil, bundle: nil)
        addChild(controller)
        cell.configure(flutterView: controller.view)
        controller.didMove(toParent: self)
        viewControllers.append(controller)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
}

final class FlutterCell: UITableViewCell {
    
    private var shouldConfigure = true
    
    func configure(flutterView: UIView) {
        guard shouldConfigure else { return }
        shouldConfigure = false
    
        contentView.addSubview(flutterView)
        
        flutterView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            flutterView.topAnchor.constraint(equalTo: contentView.topAnchor),
            flutterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            flutterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            flutterView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    
}

extension String {
    static var identifier: String { "unique_id" }
}
