import { Controller } from "@hotwired/stimulus";

var forms;
var forms_array;

var checked_array;
let list_length;

export default class extends Controller {
  static targets = ["boulder", "hill", "textBubble"];

  connect() {
    const hillWidth = this.hillTarget.offsetWidth;
    const hillHeight = this.hillTarget.offsetHeight;
    const boulderWidth = this.boulderTarget.offsetWidth;
    const boulderHeight = this.boulderTarget.offsetHeight;
    this.setPosition();
    this.isOnRight = true;
    this.initialSwapDone = false;

    this.getChecked();
    // Uses the number of checked tasks to set the boulder's current position
    this.currentStage = checked_array.length;
    const newPositionX = hillWidth - boulderWidth;
    const newPositionY = hillHeight - boulderHeight;

    this.setStages();
    this.updateTextBubblePosition();

    if (this.currentStage === 0) {
      // Move the this.boulderTarget to the top right
      const firstPositionX =
        (newPositionX / list_length) * checked_array.length;
      const firstPositionY =
        (newPositionY / list_length) * checked_array.length;
      this.boulderTarget.style.transform = `translate(${firstPositionX}px, -${firstPositionY}px) rotate(0deg)`;
      // this.currentStage++;
    } else if (this.currentStage === 1) {
      const secondPositionX =
        (newPositionX / list_length) * checked_array.length;
      const secondPositionY =
        (newPositionY / list_length) * checked_array.length;
      this.boulderTarget.style.transform = `translate(${secondPositionX}px, -${secondPositionY}px) rotate(360deg)`;
      // this.currentStage++;
    } else if (this.currentStage === 2) {
      const thirdPositionX =
        (newPositionX / list_length) * checked_array.length;
      const thirdPositionY =
        (newPositionY / list_length) * checked_array.length;
      this.boulderTarget.style.transform = `translate(${thirdPositionX}px, -${thirdPositionY}px) rotate(720deg)`;
      // this.currentStage++;
    } else if (this.currentStage === 3) {
      const fourthPositionX =
        (newPositionX / list_length) * checked_array.length;
      const fourthPositionY =
        (newPositionY / list_length) * checked_array.length;
      this.boulderTarget.style.transform = `translate(${fourthPositionX}px, -${fourthPositionY}px) rotate(1080deg)`;
      // this.currentStage++;
    } else if (this.currentStage === 4) {
      const fourthPositionX =
        (newPositionX / list_length) * checked_array.length;
      const fourthPositionY =
        (newPositionY / list_length) * checked_array.length;
      this.boulderTarget.style.transform = `translate(${fourthPositionX}px, -${fourthPositionY}px) rotate(1440deg)`;
    } else {
      this.boulderTarget.style.transform = `translate(${newPositionX}px, -${newPositionY}px) rotate(1800deg)`;
    }

    this.updateTextBubblePosition();
  }

  setPosition() {
    forms = document.querySelectorAll(".button-container");
    forms_array = [...forms];
    const list_length = forms_array.length;
    return list_length;
  }

  getChecked() {
    checked_array = [];
    forms_array.forEach((form) => {
      if (form.children[0].children[2].children[0].children[1].checked) {
        checked_array.push(
          form.children[0].children[2].children[0].children[1]
        );
        return checked_array;
      } else {
        checked_array = checked_array.filter(function (input) {
          return input !== form.children[0].children[2].children[0].children[1];
        });
      }
    });
  }

  setStages() {
    forms = document.querySelectorAll(".button-container");
    forms_array = [...forms];
    list_length = forms_array.length;
    return list_length;
  }

  remove() {
    this.getChecked();
    this.setStages();
    this.currentStage = 0;
    this.rollBoulder();
    this.setPosition();
    this.rollBoulder();
  }

  tick(e) {
    const button = e.target;

    // respond to check event, see if checked
    if (button.checked) {
      checked_array.push(button);
      this.currentStage = checked_array.length;
    } else {
      checked_array = checked_array.filter(function (input) {
        return input !== button;
      });
      this.currentStage = checked_array.length;
    }

    this.rollBoulder();
  }

  rollBoulder() {
    const hillWidth = this.hillTarget.offsetWidth;
    const hillHeight = this.hillTarget.offsetHeight;
    const boulderWidth = this.boulderTarget.offsetWidth;
    const boulderHeight = this.boulderTarget.offsetHeight;

    this.setStages();
    this.textBubbleTarget.style.display = "none";

    this.boulderTarget.classList.add("transition-effect");
    if (checked_array.length === 0) {
      this.initialSwapDone = false;
      this.isOnRight = true;
    }
    this.boulderTarget.addEventListener(
      "transitionend",
      this.updateTextBubblePosition.bind(this),
      { once: true }
    );

    const newPositionX = hillWidth - boulderWidth;
    const newPositionY = hillHeight - boulderHeight;

    if (this.currentStage === 0) {
      // Move the this.boulderTarget to the top right
      const firstPositionX =
        (newPositionX / list_length) * checked_array.length;
      const firstPositionY =
        (newPositionY / list_length) * checked_array.length;
      return (this.boulderTarget.style.transform = `translate(${firstPositionX}px, -${firstPositionY}px) rotate(0deg)`);
      // this.currentStage++;
    } else if (this.currentStage === 1) {
      const secondPositionX =
        (newPositionX / list_length) * checked_array.length;
      const secondPositionY =
        (newPositionY / list_length) * checked_array.length;
      return (this.boulderTarget.style.transform = `translate(${secondPositionX}px, -${secondPositionY}px) rotate(360deg)`);
      // this.currentStage++;
    } else if (this.currentStage === 2) {
      const thirdPositionX =
        (newPositionX / list_length) * checked_array.length;
      const thirdPositionY =
        (newPositionY / list_length) * checked_array.length;
      return (this.boulderTarget.style.transform = `translate(${thirdPositionX}px, -${thirdPositionY}px) rotate(720deg)`);
      // this.currentStage++;
    } else if (this.currentStage === 3) {
      const fourthPositionX =
        (newPositionX / list_length) * checked_array.length;
      const fourthPositionY =
        (newPositionY / list_length) * checked_array.length;
      return (this.boulderTarget.style.transform = `translate(${fourthPositionX}px, -${fourthPositionY}px) rotate(1080deg)`);
      // this.currentStage++;
    } else if (this.currentStage === 4) {
      const fourthPositionX =
        (newPositionX / list_length) * checked_array.length;
      const fourthPositionY =
        (newPositionY / list_length) * checked_array.length;
      return (this.boulderTarget.style.transform = `translate(${fourthPositionX}px, -${fourthPositionY}px) rotate(1440deg)`);
    } else {
      return (this.boulderTarget.style.transform = `translate(${newPositionX}px, -${newPositionY}px) rotate(1800deg)`);
    }
  }

  updateTextBubblePosition() {
    const boulderRect = this.boulderTarget.getBoundingClientRect();

    const offsetX = this.isOnRight ? 150 : -150; // Adjust based on desired position relative to the boulder
    const offsetY = this.isOnRight ? 50 : 0; // Adjust based on desired position relative to the boulder

    const textBubbleX = boulderRect.left + window.scrollX + offsetX;
    const textBubbleY = boulderRect.top + window.scrollY - offsetY;

    this.textBubbleTarget.style.left = `${textBubbleX}px`;
    this.textBubbleTarget.style.top = `${textBubbleY}px`;

    if (!this.initialSwapDone) {
      this.isOnRight = !this.isOnRight;
      this.initialSwapDone = true;
    }
  }
}
