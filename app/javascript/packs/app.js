$(document).ready(function () {
  $(".table").DataTable({
    searching: false,
    info: false,
    columnDefs: [
      {
        searchable: false,
        orderable: false,
        targets: "no-sort",
      },
    ],
    order: [[5, "desc"]],
  });

  $("#image").hide();

  $("#select").change(function () {
    $(this).closest("form").submit();
  });

  $(".csv").tooltip();

  $("#user_profile").on("change", function () {
    var file = this.files[0];
    if (file["type"].split("/")[0] === "image") {
      var obj = new FileReader();
      obj.onload = function (data) {
        var image = document.getElementById("image");
        image.src = data.target.result;
        image.style.display = "block";
      };
      obj.readAsDataURL(file);
      document.getElementById("profileLabel").innerHTML = file.name;
      $("#profile").hide();
    } else {
      alert("File Accepts Image Only");
    }
  });

  $("#file").on("change", function () {
    var file = this.files[0];
    console.log(file["type"].split("/")[1]);
    if (file["type"].split("/")[1] === "csv") {
      document.getElementById("fileLabel").innerHTML = file.name;
    } else {
      alert("File Accepts CSV Only");
    }
  });

  var profile = document.getElementById("profile");
  if (profile != null) {
    document.getElementById("profileLabel").innerHTML = profile
      .getAttribute("src")
      .split("/")
      .pop();
  }
});
