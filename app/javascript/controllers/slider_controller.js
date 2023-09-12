import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["slider", "output"];

  connect() {
    this.outputTarget.textContent = this.sliderTarget.value;
  }

  updateOutput() {
    this.outputTarget.textContent = this.sliderTarget.value;
  }
}
