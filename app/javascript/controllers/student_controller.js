import {Controller} from "@hotwired/stimulus"
var courses;
var found_course;

// Connects to data-controller="ajax"
export default class extends Controller {

  static targets = ["category", "course", "total_fees", "exam_fee", "completed_at", "date_of_joining"]

  connect() {
  }

  setCourses() {
    let category = this.categoryTarget.value;
    let course = this.courseTarget;
    if (category === '' || category === undefined || category === null) {
      let str = '<option>Select Course</option>'
      course.innerHTML = str
    } else {
      fetch(`/categories/${category}.json`)
        .then((response) => response.json())
        .then((data) => {
          courses = data;
          let str = '<option>Select Course</option>'
          data.forEach((d) => {
            str += `<option value='${d.id}'>${d.name}</option>`
          })
          course.innerHTML = str
        })
    }

  }

  setCourseAttributes() {
    let course = this.courseTarget.value;

    found_course = courses.find(c => c.id === course);

    this.total_feesTarget.value = found_course.total_fee
    this.exam_feeTarget.value = found_course.exam_fee

    this.setCompletedDate();
  }

  setCompletedDate() {
    if(found_course) {
      this.completed_atTarget.value = this.parseDate(new Date(Date.parse(this.date_of_joiningTarget.value) + (found_course.duration * 24 * 60 * 60 * 1000)).toLocaleDateString("en-US"));
    }
  }

  parseDate(date_str) {
    let date_arr = date_str.split("/");
    return `${date_arr[2]}-${date_arr[0]}-${date_arr[1]}`
  }
}
