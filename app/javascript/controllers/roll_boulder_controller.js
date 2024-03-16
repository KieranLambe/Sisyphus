import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["boulder", "hill"];

  rollBoulder() {
    const boulder = this.boulderTarget; // Get the element associated with this controller
    const hill = this.hillTarget;

    const hillWidth = hill.offsetWidth;
    const hillHeight = hill.offsetHeight;
    const boulderWidth = boulder.offsetWidth;
    const boulderHeight = boulder.offsetHeight;
    const newPositionX = hillWidth - boulderWidth;
    const newPositionY = hillHeight - boulderHeight;

    boulder.classList.add("transition-effect");
    // Move the boulder to the top right
    boulder.style.transform = `translate(${newPositionX}px, -${newPositionY}px) rotate(720deg)`;
  }
}
