import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="print"
export default class extends Controller {

  static targets = ["divName"]

  connect() {
  }

  printDiv() {
    var divName = this.divNameTarget;
    var printContents = divName.innerHTML;
    var originalContents = document.body.innerHTML;

    var data = `<head><title>` + "Print" + `</title>
     </head><body>` + printContents + `<p><strong>Date:</strong> `+ new Date().toLocaleDateString("en-IN") +`</p>` + `</body>`

    function PopUp(data) {
      var mywindow = window.open('', '');

      var is_chrome = Boolean(mywindow.chrome);
      mywindow.document.write(data);
      mywindow.document.close(); // necessary for IE >= 10 and necessary before onload for chrome

      if (is_chrome) {
        mywindow.onload = function () { // wait until all resources loaded
          mywindow.focus(); // necessary for IE >= 10
          mywindow.print();
          //mywindow.close();// change window to mywindow
        };
      } else {
        mywindow.document.close(); // necessary for IE >= 10
        mywindow.focus(); // necessary for IE >= 10
        mywindow.print();
        //mywindow.close();
      }

      return true;
    }

    PopUp(data)

    document.body.innerHTML = originalContents;
  }

}