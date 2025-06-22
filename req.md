# 📄 Notes App – Updated Specification Document

## **Overview**

A modern, minimal, offline-only Notes app built with Flutter and Hive. Designed for speed and clarity with no fancy gimmicks. Uses `animated_notch_bottom_bar` for navigation.

---

## ✅ Features Summary

1. **Notes List** (Home)
2. **Clipboard History**
3. **AI Chat Assistant**

---

## **1. Navigation**

* Uses [`animated_notch_bottom_bar`](https://pub.dev/packages/animated_notch_bottom_bar)
* **3 Tabs**:

  * Notes
  * Clipboard
  * AI Chat

---

## **2. Notes List Page**

### **Functionality:**

* Displays a scrollable list of note tiles.
* Each **Note Tile** contains:

  * `title` (String)
  * `contentPreview` (first few lines of content)
* Tapping a note opens the **Note Detail Page**.

---

## **3. Clipboard History Page**

### **Functionality:**

* Displays a list of clipboard entries.
* Same UI and architecture as Notes List Page.
* Each **Clipboard Tile** shows:

  * `contentPreview` only (no title)

---

## **4. Note Detail Page**

### **Opened when a note is tapped**

* Editable `title` field
* Editable `content` area (supports rich text, links)
* **Buttons**:

  * Share
  * Delete
* **Auto-save** on changes
* Editable by tapping on title/content

---

## **5. Clipboard Detail Page (Optional)**

* Same as Note Detail, minus the title.
* Mostly view-only or minimal editing (if needed)

---

## **6. AI Chat Page**

* Basic chat interface
* Integrated with LLM (e.g., Gemini free model)
* Can access content from notes and clipboard for contextual help

---

## **7. Data Model**

Create a **common data model** for both Notes and Clipboard:

```dart
class NoteItem {
  final String id;
  final String? title; // null for clipboard entries
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Add Hive TypeAdapter annotations here
}
```

> 🔄 Clipboard entries are just `NoteItem`s with `title == null`.

---

## **8. Storage**

* All data stored **locally** using Hive
* No network or sync dependencies
* Use `Hive TypeAdapter` for `NoteItem`
* Use box name like `notesBox` - don't save clipboard data

---

## **9. Non-functional Requirements**

* Entirely **offline-first**
* Minimal, distraction-free UI
* Highly responsive with smooth navigation
* Compatible with **GitHub Copilot** suggestions

---