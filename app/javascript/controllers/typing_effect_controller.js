import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="typing-effect"
export default class extends Controller {
  static targets = ["placeholder"];
  connect() {
    this.placeholderElement = this.placeholderTarget;
    this.placeholderText = this.placeholderElement.getAttribute("placeholder");
    this.currentIndex = 0;
    this.typingInterval = 4000;
    this.startTyping();
  }

  startTyping() {
    this.typingIntervalId = setInterval(() => {
      if (this.currentIndex <= this.placeholderText.length) {
        const typedText = this.placeholderText.substring(0, this.currentIndex);
        this.placeholderElement.setAttribute("placeholder", typedText);
        this.currentIndex++;
      } else {
        clearInterval(this.typingIntervalId);
        setTimeout(() => {
          this.currentIndex = 0;
          this.startTyping();
        }, 3000);
      }
    }, this.typingInterval);
  }
}
