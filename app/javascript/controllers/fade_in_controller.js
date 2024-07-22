import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["firstFadeInElement", "secondFadeInElement"];

  connect() {
    // Set initial style to hide elements
    this.firstFadeInElementTargets.forEach((element) => {
      element.style.opacity = 0;
      element.style.display = "none";
    });

    this.secondFadeInElementTargets.forEach((element) => {
      element.style.opacity = 0;
      element.style.display = "none";
    });

    // Call fadeIn methods with different delays
    setTimeout(() => {
      this.fadeIn(this.firstFadeInElementTargets);
    }, 500); // 500 milliseconds delay for the first set of elements

    if (this.isHomePage()) {
      setTimeout(() => {
        this.fadeIn(this.secondFadeInElementTargets);
      }, 1500); // 1500 milliseconds delay for the second set of elements
    }
  }

  isHomePage() {
    return (
      window.location.pathname === "/" ||
      window.location.pathname === "/index.html"
    );
  }

  fadeIn(targets) {
    targets.forEach((element) => {
      element.style.display = "block"; // Show the element
      element.style.opacity = 0;

      let opacity = 0;
      const duration = 1000; // Duration of fade-in animation in milliseconds
      const increment = 1 / (duration / 16); // Incremental change in opacity per frame (16ms)

      const fade = () => {
        opacity += increment;
        element.style.opacity = opacity;

        if (opacity < 1) {
          requestAnimationFrame(fade);
        }
      };

      fade();
    });
  }
}
