import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["boulder", "textBubble"];

  connect() {
    this.phrases = ["Hello there!", "Welcome to our site.", "Enjoy your stay!"];
    this.currentPhraseIndex = 0;
    this.fadeDuration = 1000; // Duration for fade in/out in milliseconds
    this.delayBetweenPhrases = 3000; // Delay between phrases
    this.startPhraseSequence();
  }

  startPhraseSequence() {
    this.showNextPhrase();
  }

  showNextPhrase() {
    const phrase = this.phrases[this.currentPhraseIndex];
    const textBubble = this.textBubbleTarget;

    textBubble.textContent = ""; // Clear existing text
    this.typeText(textBubble, phrase, 0, () => {
      setTimeout(() => {
        this.fadeOut(textBubble, () => {
          this.currentPhraseIndex =
            (this.currentPhraseIndex + 1) % this.phrases.length;
          this.showNextPhrase();
        });
      }, this.delayBetweenPhrases);
    });

    this.fadeIn(textBubble);
  }

  typeText(element, text, index, callback) {
    if (index < text.length) {
      element.textContent += text.charAt(index);
      setTimeout(() => this.typeText(element, text, index + 1, callback), 100);
    } else {
      callback();
    }
  }

  fadeIn(element) {
    element.style.opacity = 0;
    element.style.display = "block";

    let last = +new Date();
    const tick = () => {
      element.style.opacity =
        +element.style.opacity + (new Date() - last) / this.fadeDuration;
      last = +new Date();

      if (+element.style.opacity < 1) {
        requestAnimationFrame(tick);
      }
    };
    tick();
  }

  fadeOut(element, callback) {
    element.style.opacity = 1;

    let last = +new Date();
    const tick = () => {
      element.style.opacity =
        +element.style.opacity - (new Date() - last) / this.fadeDuration;
      last = +new Date();

      if (+element.style.opacity > 0) {
        requestAnimationFrame(tick);
      } else {
        element.style.display = "none";
        callback();
      }
    };
    tick();
  }
}
