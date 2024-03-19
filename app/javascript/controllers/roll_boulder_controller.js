import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["boulder", "hill"];

  initialize() {
    this.currentStage = 0;
    console.log(this.boulderTarget);
    console.log(this.hillTarget);
    this.stageFunctions = [
      this.rollBoulder1,
      this.rollBoulder2,
      this.rollBoulder3,
      this.rollBoulder4,
      this.rollBoulder5,
      // Add more functions for additional stages
    ];
  }

  nextStage() {
    console.log("nextStage function called");
    if (this.currentStage < this.stageFunctions.length) {
      this.stageFunctions[this.currentStage]();
      this.currentStage++;
    }
  }

  rollBoulder1() {
    const hillWidth = this.hillTarget.offsetWidth;
    const hillHeight = this.hillTarget.offsetHeight;
    const boulderWidth = this.boulderTarget.offsetWidth;
    const boulderHeight = this.boulderTarget.offsetHeight;
    const newPositionX = hillWidth - boulderWidth;
    const newPositionY = hillHeight - boulderHeight;

    this.boulderTarget.classList.add("transition-effect");
    // Move the this.boulderTarget to the top right
    this.boulderTarget.style.transform = `translate(${newPositionX}px, -${newPositionY}px) rotate(720deg)`;
  }

  rollBoulder2() {
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

  rollBoulder3() {
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

  rollBoulder4() {
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

  rollBoulder5() {
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
