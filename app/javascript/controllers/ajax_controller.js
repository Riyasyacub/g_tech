import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="ajax"
export default class extends Controller {

  static targets = ["input_element"]

  connect() {
  }

  getAndRender() {
    let ele = this.input_elementTarget;
    let url = ele.dataset.url
    let frame_id = "turbo-frame#" + ele.dataset.frame
    let frame = document.querySelector(frame_id)
    let parsed_url;
    if (url.includes('{id}')) {
      parsed_url = url.replace("{id}", ele.value)
      if (ele.value === undefined || ele.value === null || ele.value === '') {
        frame.innerHTML = "<div class='border border-2 rounded-md' ><h1>Please select Student to display summary</h1></div>"
        return
      }
    } else {
      parsed_url = url
    }

    frame.src = parsed_url
    frame.reload()
  }
}
