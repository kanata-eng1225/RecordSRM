import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  changeRange(event) {
    const selectedValue = event.target.value;
    window.location.href = `/stress_records?range=${selectedValue}`;
  }
}
