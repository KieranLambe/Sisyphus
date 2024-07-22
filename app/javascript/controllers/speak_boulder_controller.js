import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["boulder", "textBubble"];

  connect() {
    const isLoggedIn = this.element.dataset.userLoggedIn === "true";
    const username = this.element.dataset.username || "Guest";
    this.phrases = isLoggedIn
      ? [
          `Welcome back ${username}!`,
          "To get the ball rolling, select some tasks,",
          "I will climb this hill as you progress!",
        ]
      : [
          "Hello there!",
          "Ready to get the ball rolling?",
          "Login or create a free account.",
        ];
    this.currentPhraseIndex = 0;
    this.fadeDuration = 500; // Duration for fade in/out in milliseconds
    this.delayBetweenPhrases = 3000; // Delay between phrases

    if (this.isHomePage()) {
      this.startPhraseSequence();
      console.log("speaking");
    }
  }

  isHomePage() {
    return (
      window.location.pathname === "/" ||
      window.location.pathname === "/index.html"
    );
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
