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
    document.getElementById("fileLabel").innerHTML = file.name;
    $("#profile").hide();
  } else {
    alert("File Accepts Image Only");
  }
});

$("#image").hide();

var profile = document.getElementById("profile");
if (profile != null) {
  document.getElementById("fileLabel").innerHTML = profile.getAttribute("src").split("/").pop();
}