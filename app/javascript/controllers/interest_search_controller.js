import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="interest-search"
export default class extends Controller {
  static targets = ["list"];

  connect() {
    this.initializeInterestButtons();
  }

  initializeInterestButtons() {
    const interestButtons = this.element.querySelectorAll(".interest-button");
    interestButtons.forEach(button => {
      button.addEventListener("click", this.handleInterestButtonClick.bind(this));
    });
  }

  handleInterestButtonClick(event) {
    event.preventDefault();
    const title = event.currentTarget.dataset.title;
    this.filterTasksByInterest(title);
  }

  filterTasksByInterest(interest) {
    const url = `/tasks?query=${interest}`;

    fetch(url, { headers: {"Accept": "text/plain"}})
      .then(response => response.text())
      .then(data => {
        this.listTarget.innerHTML = data;
      })
  }
}
