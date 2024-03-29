import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-tasks"
export default class extends Controller {
  static targets = ["form", "query", "list"];

  connect() {

  }

  search(event) {
    // event.preventDefault();
    // console.log(this.queryTarget.value);
    console.log(this.queryTarget.value);
    console.log(this.formTarget.action);
    console.log(this.listTarget);
    const query = this.queryTarget.value.trim();

    if (!query) {
      return;
    }
    const url = `${this.formTarget.action}?query=${this.queryTarget.value}`;
    console.log(url);
    fetch(url, {headers: {"Accept": "text/plain"}})
      .then(response => response.text())
      .then((data) => {
        // console.log(data);
        this.listTarget.outerHTML = data;
      })
  }
}
