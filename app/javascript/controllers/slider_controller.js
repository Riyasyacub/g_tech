import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="ajax"
export default class extends Controller {

  static targets = ["icon", "target_element"]

  connect() {
  }

  open() {
    let ele = this.target_elementTarget;
    ele.style.display = "block";
  }

  close() {
    let ele = this.target_elementTarget;
    ele.style.display = "none";
  }

  openAndRender() {
    event.preventDefault();
    let ele = this.iconTarget;
    let t_ele = this.target_elementTarget;
    if (t_ele.style.display === '' || t_ele.style.display === 'none') {
      let url = ele.dataset.url
      let frame_id = "turbo-frame#" + ele.dataset.frame
      let frame = document.querySelector(frame_id)
      frame.src = url
      frame.reload()
      this.open();
    } else {
      this.close();
    }
  }
}
