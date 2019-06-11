//
//  BookController.swift
//  Reading List
//
//  Created by Marlon Raskin on 6/11/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController: Codable {
	
	// MARK: - Computed Properties
	private(set) var books: [Book] = []
	
	private var readingListURL: URL? {
		let fileManager = FileManager.default
		guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
		return documents.appendingPathComponent("books.plist")
	}
	
	var readBooks: [Book] {
		let booksThatHaveBeenRead = books.filter({ return $0.hasBeenRead == true })
		return booksThatHaveBeenRead
	}
	
	var unreadBooks: [Book] {
		let booksNotRead = books.filter({ return $0.hasBeenRead == false })
		return booksNotRead
	}
	
	
	// MARK: - Book Functions
	func createBook(with title: String, with reasonToRead: String) {
		let newBook = Book(title: title, reasonToRead: reasonToRead)
		books.append(newBook)
		saveToPersistentStore()
	}
	
	func deleteBook(book: Book) {
		if books.contains(book) {
			books.removeAll()
		}
		saveToPersistentStore()
	}
	
	func updateHasBeenRead(for book: Book) {
		guard let bookIndex = books.firstIndex(of: book) else { return }
		books[bookIndex].hasBeenRead = !book.hasBeenRead
		saveToPersistentStore()
	}
	
	func updateBook(for book: Book, title: String?, reason: String?) {
		guard let bookIndex = books.firstIndex(of: book) else { return }
		guard let bookTitle = title else { return }
		books[bookIndex].title = bookTitle
		guard let reasonToRead = reason else { return }
		books[bookIndex].reasonToRead = reasonToRead
	}
	
	// MARK: - Persistence Functions
	func saveToPersistentStore() {
		guard let url = readingListURL else { return }
		do {
			let encodeBooks = PropertyListEncoder()
			let booksData = try encodeBooks.encode(books)
			try booksData.write(to: url)
		} catch {
			print("Error saving books data: \(error)")
		}
	}
	
	func loadFromPersistentStore() {
		let fileManager = FileManager.default
		guard let url = readingListURL,
			fileManager.fileExists(atPath: url.path) else { return }
		do {
			let decodeBooks = PropertyListDecoder()
			let data = try Data(contentsOf: url)
			books = try decodeBooks.decode([Book].self, from: data)
		} catch {
			print("Error loading books data: \(error)")
		}
	}
}
